# Delivery

Declarative GitOps manifests for cluster reconciliation.

## Layout

- `applications/` - ArgoCD `Application` entrypoints and their app-of-apps kustomization.
- `core-platform/` - Platform add-ons and controllers.
- `user-apps/` - Application workloads.

## Bootstrap

- Apply `applications/root.yaml` once to seed ArgoCD.
- Keep `applications/kustomization.yaml` free of `root.yaml` so the entrypoint does not self-reference.
- Use empty `kustomization.yaml` files as placeholders until each workload tree is implemented.
