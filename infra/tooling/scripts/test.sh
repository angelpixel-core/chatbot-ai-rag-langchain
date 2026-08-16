#!/usr/bin/env sh
set -eu

TEST_ENV="${TEST_ENV:-test}"
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
ROOT_DIR=$(CDPATH= cd -- "${SCRIPT_DIR}/../.." && pwd)
TEST_STACK_ENV_FILE="${ROOT_DIR}/infra/environments/${TEST_ENV}/orchestration/compose.env"
TEST_APP_CORE_ENV_FILE="${ROOT_DIR}/infra/environments/${TEST_ENV}/app/core.env"
TEST_APP_DB_ENV_FILE="${ROOT_DIR}/infra/environments/${TEST_ENV}/app/db.env"
TEST_DB_BOOTSTRAP_ENV_FILE="${ROOT_DIR}/infra/environments/${TEST_ENV}/db/bootstrap.env"

IMAGE_NAME="${IMAGE_NAME:-coffee-chatbot-test}"
TEST_DB_CONTAINER_NAME="${TEST_DB_CONTAINER_NAME:-coffee-chatbot-test-db}"

require_file() {
  if [ ! -f "$1" ]; then
    echo "Missing file: $1" >&2
    exit 1
  fi
}

load_env_file() {
  file="$1"
  [ -f "$file" ] || return 0

  while IFS= read -r line || [ -n "$line" ]; do
    case "$line" in
      ''|'#'*)
        continue
        ;;
    esac

    case "$line" in
      *=*)
        key=${line%%=*}
        value=${line#*=}
        export "$key=$value"
        ;;
    esac
  done < "$file"
}

build_image() {
  require_file "$TEST_STACK_ENV_FILE"
  docker build \
      --file "${ROOT_DIR}/infra/runtime/containers/server/Dockerfile" \
    --build-arg "PYTHON_VERSION=${PYTHON_VERSION:-3.15.0rc1}" \
    --build-arg "UID=${UID:-1000}" \
    --build-arg "GID=${GID:-1000}" \
    --tag "$IMAGE_NAME" \
    "$ROOT_DIR"
}

ensure_database() {
  require_file "$TEST_DB_BOOTSTRAP_ENV_FILE"
  load_env_file "$TEST_APP_DB_ENV_FILE"
  load_env_file "$TEST_DB_BOOTSTRAP_ENV_FILE"
  docker network inspect coffee_chatbot_net >/dev/null 2>&1 || \
    docker network create --driver bridge coffee_chatbot_net >/dev/null
  docker rm -f "$TEST_DB_CONTAINER_NAME" >/dev/null 2>&1 || true
  docker run -d \
    --name "$TEST_DB_CONTAINER_NAME" \
    --network coffee_chatbot_net \
    --network-alias db \
    --env-file "$TEST_DB_BOOTSTRAP_ENV_FILE" \
    postgres:${POSTGRES_VERSION:-16.4}-alpine \
    postgres -p "${DB_INTERNAL_PORT:-5432}" >/dev/null

  cleanup_database() {
    docker rm -f "$TEST_DB_CONTAINER_NAME" >/dev/null 2>&1 || true
  }

  trap cleanup_database EXIT INT TERM

  wait_for_database
}

wait_for_database() {
  host="${DB_HOST:-db}"
  port="${DB_PORT:-5432}"
  user="${POSTGRES_USER:-app}"
  db_name="${POSTGRES_DB:-coffee_chatbot_development}"
  max_attempts="${DB_WAIT_ATTEMPTS:-300}"
  attempt=1

  while [ "$attempt" -le "$max_attempts" ]; do
    if docker exec "$TEST_DB_CONTAINER_NAME" pg_isready -h 127.0.0.1 -p "$port" -U "$user" -d "$db_name" >/dev/null 2>&1; then
      return 0
    fi

    sleep 1
    attempt=$((attempt + 1))
  done

  echo "Timed out waiting for database on ${host}:${port}" >&2
  docker logs "$TEST_DB_CONTAINER_NAME" >&2 || true
  return 1
}

run_in_image() {
  command="$1"
  shift

  load_env_file "$TEST_APP_CORE_ENV_FILE"
  load_env_file "$TEST_APP_DB_ENV_FILE"

  if [ -n "${DB_CONNECTION_STRING:-}" ]; then
    docker run --rm \
      --network coffee_chatbot_net \
      --env-file "$TEST_APP_CORE_ENV_FILE" \
      --env-file "$TEST_APP_DB_ENV_FILE" \
      --env "DB_CONNECTION_STRING=${DB_CONNECTION_STRING}" \
      "$IMAGE_NAME" \
      sh -lc "$command" sh "$@"
  else
    docker run --rm \
      --network coffee_chatbot_net \
      --env-file "$TEST_APP_CORE_ENV_FILE" \
      --env-file "$TEST_APP_DB_ENV_FILE" \
      "$IMAGE_NAME" \
      sh -lc "$command" sh "$@"
  fi
}

case "${1:-}" in
  build)
    build_image
    ;;
  verify)
    ensure_database
    build_image
    run_in_image 'python -c "import os; print(os.getenv(\"STACK_ENV\", \"test\"))"'
    ;;
  pytest)
    shift
    ensure_database
    build_image
    if [ -n "${TEST_ARGS:-}" ]; then
      run_in_image "pytest ${TEST_ARGS}" "$@"
    else
      run_in_image 'pytest "$@"' "$@"
    fi
    ;;
  *)
    echo "Usage: test.sh {build|verify|pytest}" >&2
    exit 1
    ;;
esac
