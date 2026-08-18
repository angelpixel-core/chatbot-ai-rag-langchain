# Infra

Tool-agnostic infrastructure root.

## Layout

- `runtime/` - bootstrap assets shared by local execution and cluster bootstrap.
- `local/` - local orchestration assets such as Compose, local Kubernetes definitions, and local scripts.
- `environments/` - environment-specific configuration values.
- `provisioning/` - provider infrastructure definitions.
- `tooling/` - scripts and lint helpers.

## Command Layers

- `Makefile` is the root facade for humans.
- `infra/tooling/scripts/*` is the imperative glue layer.
- `infra/runtime/*` holds bootstrap assets.
- `infra/local/*` holds local orchestration assets and local scripts.
- `infra/provisioning/aws/*` holds Terraform and cloud state.
- `infra/delivery/*` holds declarative cluster delivery manifests.

## Boundary Rules

- Keep `Makefile` targets thin and stable.
- Keep shell scripts small, explicit, and single-purpose.
- Let scripts call tools directly; do not build orchestration frameworks in shell.
- Keep Terraform in provisioning roots, not in the Makefile.
- Keep delivery manifests declarative; use shell only for one-time bootstrap or validation.
- Document any new command family both here and in the corresponding script README before adding more targets.
