#!/usr/bin/env sh
set -eu

STACK_ENV="${STACK_ENV:-dev}"
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
ROOT_DIR=$(CDPATH= cd -- "${SCRIPT_DIR}/../.." && pwd)
STACK_COMPOSE_FILE="${ROOT_DIR}/infra/local/compose.yaml"
STACK_ENV_FILE="${ROOT_DIR}/infra/environments/${STACK_ENV}/orchestration/compose.env"

require_file() {
  if [ ! -f "$1" ]; then
    echo "Missing file: $1" >&2
    exit 1
  fi
}

run_compose() {
  require_file "$STACK_ENV_FILE"
  docker compose --env-file "$STACK_ENV_FILE" -f "$STACK_COMPOSE_FILE" "$@"
}

case "${1:-}" in
  up)
    shift
    run_compose up -d "$@"
    ;;
  down)
    shift
    run_compose down "$@"
    ;;
  logs)
    shift
    run_compose logs -f "$@"
    ;;
  *)
    echo "Usage: stack.sh {up|down|logs}" >&2
    exit 1
    ;;
esac
