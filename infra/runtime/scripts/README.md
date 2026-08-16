# Runtime Scripts

Helpers for local execution workflows.

## Scripts

- `cluster.sh` - lifecycle, build, import, apply, logs, and status for the local k3d stack.
- `bootstrap-argocd.sh` - one-shot ArgoCD install plus root application bootstrap.
- `bootstrap-argocd.sh` also smoke-checks `Application/delivery-root` for `Synced` and `Healthy`.
