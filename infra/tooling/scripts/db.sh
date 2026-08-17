#!/usr/bin/env sh
set -eu

STACK_ENV="${STACK_ENV:-dev}"
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
ROOT_DIR=$(CDPATH= cd -- "${SCRIPT_DIR}/../.." && pwd)
STACK_COMPOSE_FILE="${ROOT_DIR}/infra/runtime/compose.yaml"
STACK_ENV_FILE="${ROOT_DIR}/infra/environments/${STACK_ENV}/orchestration/compose.env"
PROJECT_ENV_FILE="${ROOT_DIR}/infra/environments/.local/project.env"

require_file() {
  if [ ! -f "$1" ]; then
    echo "Missing file: $1" >&2
    exit 1
  fi
}

run_compose() {
  require_file "$STACK_ENV_FILE"
  require_file "$PROJECT_ENV_FILE"
  set -a
  . "$PROJECT_ENV_FILE"
  set +a
  docker compose --env-file "$STACK_ENV_FILE" -f "$STACK_COMPOSE_FILE" "$@"
}

case "${1:-}" in
  shell)
    shift
    run_compose exec db psql -U "${POSTGRES_USER:-app}" -d "${POSTGRES_DB:-coffee_chatbot_development}" "$@"
    ;;
  logs)
    shift
    run_compose logs -f db "$@"
    ;;
  *)
    echo "Usage: db.sh {shell|logs}" >&2
    exit 1
    ;;
esac
