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
