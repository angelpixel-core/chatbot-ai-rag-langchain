#!/usr/bin/env sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

AWS_PROFILE="${AWS_PROFILE:-}"
AWS_REGION="${AWS_REGION:-}"
EKS_CLUSTER_NAME="${EKS_CLUSTER_NAME:-}"
EKS_ROLE_ARN="${EKS_ROLE_ARN:-}"
EKS_CONTEXT_NAME="${EKS_CONTEXT_NAME:-${EKS_CLUSTER_NAME:-}}"

require_command() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "Missing command: $1" >&2
    exit 1
  }
}

require_var() {
  name="$1"
  value="$2"

  if [ -z "$value" ]; then
    echo "Missing required environment variable: $name" >&2
    exit 1
  fi
}

aws_base() {
  require_command aws
  require_var AWS_REGION "$AWS_REGION"

  if [ -n "$AWS_PROFILE" ]; then
    AWS_PROFILE="$AWS_PROFILE" AWS_REGION="$AWS_REGION" aws "$@"
  else
    AWS_REGION="$AWS_REGION" aws "$@"
  fi
}

kubectl_base() {
  require_command kubectl
  kubectl "$@"
}

show_usage() {
  cat <<'EOF'
Usage: eks.sh {identity|kubeconfig|context|status|nodes|pods|verify}

Required environment variables:
  AWS_REGION
  EKS_CLUSTER_NAME (for kubeconfig/context/status/nodes/pods/verify)

Optional environment variables:
  AWS_PROFILE
  EKS_ROLE_ARN
  EKS_CONTEXT_NAME
EOF
}

update_kubeconfig() {
  require_var EKS_CLUSTER_NAME "$EKS_CLUSTER_NAME"

  if [ -n "$EKS_ROLE_ARN" ]; then
    aws_base eks update-kubeconfig \
      --name "$EKS_CLUSTER_NAME" \
      --region "$AWS_REGION" \
      --role-arn "$EKS_ROLE_ARN" \
      --alias "$EKS_CONTEXT_NAME"
  else
    aws_base eks update-kubeconfig \
      --name "$EKS_CLUSTER_NAME" \
      --region "$AWS_REGION" \
      --alias "$EKS_CONTEXT_NAME"
  fi
}

cluster_status() {
  require_var EKS_CLUSTER_NAME "$EKS_CLUSTER_NAME"
  kubectl_base --context "$EKS_CONTEXT_NAME" cluster-info
}

cluster_nodes() {
  require_var EKS_CLUSTER_NAME "$EKS_CLUSTER_NAME"
  kubectl_base --context "$EKS_CONTEXT_NAME" get nodes -o wide
}

cluster_pods() {
  require_var EKS_CLUSTER_NAME "$EKS_CLUSTER_NAME"
  kubectl_base --context "$EKS_CONTEXT_NAME" get pods -A
}

case "${1:-}" in
  identity)
    shift
    aws_base sts get-caller-identity "$@"
    ;;
  kubeconfig)
    shift
    update_kubeconfig "$@"
    ;;
  context)
    shift
    update_kubeconfig
    kubectl_base config current-context
    ;;
  status)
    shift
    update_kubeconfig
    cluster_status
    ;;
  nodes)
    shift
    update_kubeconfig
    cluster_nodes
    ;;
  pods)
    shift
    update_kubeconfig
    cluster_pods
    ;;
  verify)
    shift
    aws_base sts get-caller-identity
    update_kubeconfig
    kubectl_base config current-context
    cluster_status
    cluster_nodes
    cluster_pods
    ;;
  *)
    show_usage >&2
    exit 1
    ;;
esac
