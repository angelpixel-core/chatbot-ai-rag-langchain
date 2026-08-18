# Runtime Bootstrap

Bootstrap assets for runtime-adjacent platform setup.

## Assets

- `argocd-values.yaml` - Helm values for Argo CD bootstrap.
- `bootstrap-argocd.sh` - one-shot Argo CD install plus root application bootstrap.
- `db/` - PostgreSQL bootstrap assets used by Compose and local Kubernetes.

## Convention

- Each bootstrap subfolder should have its own `README.md` at the folder root.
- The owning architecture section should include a checklist item for every bootstrap subfolder.
- Add a new bootstrap subfolder only when it has a distinct responsibility.
