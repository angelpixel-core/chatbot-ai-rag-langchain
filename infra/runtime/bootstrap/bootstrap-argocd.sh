#!/usr/bin/env sh
set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/../../.." && pwd)
ARGOCD_NAMESPACE="${ARGOCD_NAMESPACE:-argocd}"
ARGOCD_RELEASE_NAME="${ARGOCD_RELEASE_NAME:-argocd}"
ARGOCD_HELM_REPO_NAME="${ARGOCD_HELM_REPO_NAME:-argo}"
ARGOCD_HELM_REPO_URL="${ARGOCD_HELM_REPO_URL:-https://argoproj.github.io/argo-helm}"
ARGOCD_HELM_CHART_VERSION="${ARGOCD_HELM_CHART_VERSION:-7.8.3}"
ARGOCD_VALUES_FILE="${ARGOCD_VALUES_FILE:-$ROOT_DIR/infra/runtime/bootstrap/argocd-values.yaml}"
ROOT_APP_FILE="${ROOT_APP_FILE:-$ROOT_DIR/infra/delivery/applications/root.yaml}"

require_command() {
  command -v "$1" >/dev/null 2>&1 || {
    printf '%s\n' "Missing command: $1" >&2
    exit 1
  }
}

require_file() {
  [ -f "$1" ] || {
    printf '%s\n' "Missing file: $1" >&2
    exit 1
  }
}

require_command kubectl
require_command helm
require_file "$ARGOCD_VALUES_FILE"
require_file "$ROOT_APP_FILE"

wait_for_application_status() {
  app_name="$1"
  expected_sync="$2"
  expected_health="$3"
  timeout_seconds="${4:-600}"
  interval_seconds=5
  elapsed_seconds=0

  while [ "$elapsed_seconds" -lt "$timeout_seconds" ]; do
    sync_status=$(kubectl get applications.argoproj.io "$app_name" -n "$ARGOCD_NAMESPACE" -o jsonpath='{.status.sync.status}' 2>/dev/null || true)
    health_status=$(kubectl get applications.argoproj.io "$app_name" -n "$ARGOCD_NAMESPACE" -o jsonpath='{.status.health.status}' 2>/dev/null || true)

    if [ "$sync_status" = "$expected_sync" ] && [ "$health_status" = "$expected_health" ]; then
      return 0
    fi

    sleep "$interval_seconds"
    elapsed_seconds=$((elapsed_seconds + interval_seconds))
  done

  printf '%s\n' "Timed out waiting for Application/$app_name to be $expected_sync/$expected_health" >&2
  kubectl get applications.argoproj.io "$app_name" -n "$ARGOCD_NAMESPACE" -o yaml >&2 || true
  exit 1
}

kubectl create namespace "$ARGOCD_NAMESPACE" --dry-run=client -o yaml | kubectl apply -f - >/dev/null
helm repo add "$ARGOCD_HELM_REPO_NAME" "$ARGOCD_HELM_REPO_URL" --force-update >/dev/null
helm repo update >/dev/null
helm upgrade --install "$ARGOCD_RELEASE_NAME" "$ARGOCD_HELM_REPO_NAME/argo-cd" \
  --namespace "$ARGOCD_NAMESPACE" \
  --version "$ARGOCD_HELM_CHART_VERSION" \
  --values "$ARGOCD_VALUES_FILE" \
  --wait \
  --timeout 10m

kubectl wait --for=condition=Available deployment --all -n "$ARGOCD_NAMESPACE" --timeout=10m
kubectl apply -f "$ROOT_APP_FILE"
wait_for_application_status delivery-root Synced Healthy 600
