#!/usr/bin/env sh
set -eu

CLUSTER_NAME="${K3D_CLUSTER_NAME:-coffee-chatbot-local}"
NAMESPACE="${K3D_NAMESPACE:-coffee-chatbot-runtime}"
ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/../../.." && pwd)
KUSTOMIZE_DIR="${ROOT_DIR}/infra/runtime/kubernetes/overlays/local"
GENERATED_DIR="${KUSTOMIZE_DIR}/.generated"
DEV_ENV_DIR="${ROOT_DIR}/infra/environments/dev"
DEV_COMPOSE_ENV_FILE="${DEV_ENV_DIR}/orchestration/compose.env"
DEV_APP_CORE_ENV_FILE="${DEV_ENV_DIR}/app/core.env"
DEV_APP_DB_ENV_FILE="${DEV_ENV_DIR}/app/db.env"
DEV_DB_BOOTSTRAP_ENV_FILE="${DEV_ENV_DIR}/db/bootstrap.env"
DB_INITDB_SRC_DIR="${ROOT_DIR}/infra/runtime/containers/db/entrypoint/initdb.d"
SERVER_IMAGE="${SERVER_IMAGE:-coffee-chatbot-server:local}"
WEB_IMAGE="${WEB_IMAGE:-coffee-chatbot-web:local}"
SERVER_PORT="${SERVER_PORT:-10001}"
WEB_PORT="${WEB_PORT:-10002}"

require_command() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "Missing command: $1" >&2
    exit 1
  }
}

require_file() {
  [ -f "$1" ] || {
    echo "Missing file: $1" >&2
    exit 1
  }
}

load_env_file() {
  file="$1"
  require_file "$file"
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

write_generated_files() {
  mkdir -p "$GENERATED_DIR"

  cat > "$GENERATED_DIR/runtime.env" <<EOF
STACK_ENV=${STACK_ENV:-dev}
NEXT_PUBLIC_API_BASE_URL=${NEXT_PUBLIC_API_BASE_URL:-http://localhost:${SERVER_PORT}}
SERVER_INTERNAL_PORT=${SERVER_INTERNAL_PORT:-8000}
WEB_INTERNAL_PORT=${WEB_INTERNAL_PORT:-3000}
DB_INTERNAL_PORT=${DB_INTERNAL_PORT:-5432}
SERVER_PORT=${SERVER_PORT}
WEB_PORT=${WEB_PORT}
DB_PORT=${DB_PORT:-10003}
EOF

  cat > "$GENERATED_DIR/secrets.env" <<EOF
DB_CONNECTION_STRING=${DB_CONNECTION_STRING:-postgresql://app:app_password@db:5432/coffee_chatbot_development}
POSTGRES_DB=${POSTGRES_DB:-coffee_chatbot_development}
POSTGRES_USER=${POSTGRES_USER:-app}
POSTGRES_PASSWORD=${POSTGRES_PASSWORD:-app_password}
POSTGRES_QUEUE_DB=${POSTGRES_QUEUE_DB:-coffee_chatbot_development_queue}
POSTGRES_CABLE_DB=${POSTGRES_CABLE_DB:-coffee_chatbot_development_cable}
POSTGRES_TEST_DB=${POSTGRES_TEST_DB:-coffee_chatbot_test}
POSTGRES_TEST_QUEUE_DB=${POSTGRES_TEST_QUEUE_DB:-coffee_chatbot_test_queue}
POSTGRES_TEST_CABLE_DB=${POSTGRES_TEST_CABLE_DB:-coffee_chatbot_test_cable}
EOF

  cat > "$GENERATED_DIR/db-image-patch.yaml" <<EOF
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: db
spec:
  template:
    spec:
      containers:
        - name: db
          image: postgres:${POSTGRES_VERSION:-16.4}-alpine
EOF

  mkdir -p "$GENERATED_DIR/initdb.d"
  for script in 001-create-user.sh 002-create-databases.sh 003-grant-permissions.sh 004-enable-extensions.sh; do
    cp "$DB_INITDB_SRC_DIR/$script" "$GENERATED_DIR/initdb.d/$script"
  done
}

load_runtime_sources() {
  load_env_file "$DEV_COMPOSE_ENV_FILE"
  load_env_file "$DEV_APP_CORE_ENV_FILE"
  load_env_file "$DEV_APP_DB_ENV_FILE"
  load_env_file "$DEV_DB_BOOTSTRAP_ENV_FILE"
}

cluster_exists() {
  output="$(k3d cluster list 2>/dev/null || true)"
  while IFS= read -r line; do
    case "$line" in
      "$CLUSTER_NAME"*)
        return 0
        ;;
    esac
  done <<EOF
$output
EOF
  return 1
}

ensure_cluster() {
  require_command k3d
  if cluster_exists; then
    k3d cluster start "$CLUSTER_NAME" >/dev/null 2>&1 || true
    return 0
  fi

  k3d cluster create "$CLUSTER_NAME" \
    --servers 1 \
    --agents 1 \
    --wait \
    --port "${SERVER_PORT}:30080@loadbalancer" \
    --port "${WEB_PORT}:30081@loadbalancer"
}

build_images() {
  require_command docker
  docker build \
    --build-arg "PYTHON_VERSION=${PYTHON_VERSION:-3.15.0rc1}" \
    --build-arg "UID=${UID:-1000}" \
    --build-arg "GID=${GID:-1000}" \
    --build-arg "SERVER_PORT=${SERVER_INTERNAL_PORT:-8000}" \
    --target "${SERVER_IMAGE_STAGE:-base}" \
    -t "$SERVER_IMAGE" \
    -f "$ROOT_DIR/infra/runtime/containers/server/Dockerfile" \
    "$ROOT_DIR"
  docker build \
    --build-arg "NODE_VERSION=${NODE_VERSION:-22.0.0}" \
    --build-arg "UID=${UID:-1000}" \
    --build-arg "GID=${GID:-1000}" \
    --build-arg "WEB_PORT=${WEB_INTERNAL_PORT:-3000}" \
    --target "${WEB_IMAGE_STAGE:-base}" \
    -t "$WEB_IMAGE" \
    -f "$ROOT_DIR/infra/runtime/containers/web/Dockerfile" \
    "$ROOT_DIR"
}

import_images() {
  require_command k3d
  k3d image import "$SERVER_IMAGE" "$WEB_IMAGE" -c "$CLUSTER_NAME"
}

apply_manifests() {
  require_command kubectl
  write_generated_files
  kubectl apply -k "$KUSTOMIZE_DIR"
}

wait_for_rollouts() {
  require_command kubectl
  kubectl rollout status deployment/server -n "$NAMESPACE" --timeout=180s
  kubectl rollout status deployment/web -n "$NAMESPACE" --timeout=180s
  kubectl rollout status statefulset/db -n "$NAMESPACE" --timeout=180s
}

case "${1:-}" in
  up)
    load_runtime_sources
    ensure_cluster
    build_images
    import_images
    apply_manifests
    wait_for_rollouts
    ;;
  apply)
    load_runtime_sources
    ensure_cluster
    build_images
    import_images
    apply_manifests
    wait_for_rollouts
    ;;
  down|delete)
    require_command k3d
    k3d cluster delete "$CLUSTER_NAME"
    ;;
  status)
    require_command kubectl
    kubectl get pods,svc -n "$NAMESPACE" -o wide
    ;;
  logs)
    require_command kubectl
    kubectl logs -n "$NAMESPACE" -l app.kubernetes.io/part-of=coffee-chatbot --all-containers=true -f --tail=100
    ;;
  *)
    echo "Usage: cluster.sh {up|down|logs|status|apply|delete}" >&2
    exit 1
    ;;
esac
