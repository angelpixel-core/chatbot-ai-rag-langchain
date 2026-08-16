# Runtime Kubernetes

Local Kubernetes manifests for the app split used in EKS.

## Layout

- `base/` - shared workloads and services.
- `overlays/local/` - full local `k3d` stack with app, database, and runtime config.

## Local Model

- `compose` remains the fastest local workflow.
- `k3d` runs the full stack in Kubernetes, including the database.
- The shared runtime contract is `DB_CONNECTION_STRING`.
- The local overlay reads directly from `infra/environments/dev/` so the same contract drives both Compose and Kubernetes.
