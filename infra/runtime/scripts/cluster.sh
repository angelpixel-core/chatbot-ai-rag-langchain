#!/usr/bin/env sh
set -eu

CLUSTER_NAME="${K3D_CLUSTER_NAME:-coffee-chatbot-local}"
NAMESPACE="${K3D_NAMESPACE:-coffee-chatbot-runtime}"
ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/../../.." && pwd)
KUSTOMIZE_DIR="${ROOT_DIR}/infra/runtime/kubernetes/overlays/local"
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
  docker build -t "$SERVER_IMAGE" -f "$ROOT_DIR/infra/runtime/containers/server/Dockerfile" "$ROOT_DIR"
  docker build -t "$WEB_IMAGE" -f "$ROOT_DIR/infra/runtime/containers/web/Dockerfile" "$ROOT_DIR"
}

import_images() {
  require_command k3d
  k3d image import "$SERVER_IMAGE" "$WEB_IMAGE" -c "$CLUSTER_NAME"
}

apply_manifests() {
  require_command kubectl
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
    ensure_cluster
    build_images
    import_images
    apply_manifests
    wait_for_rollouts
    ;;
  apply)
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
