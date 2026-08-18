# 21. Remove / Reconsider Current `infra/runtime/`

## Current Responsibility

```text
infra/runtime/
├── bootstrap/
```

## Migration Intent

- [x] Move application-specific Dockerfiles toward their owning applications.
- [x] Move Compose responsibility toward `infra/local/compose/`.
- [x] Move local Kubernetes responsibility toward `infra/local/kubernetes/`.
- [x] Move operational helper scripts toward `tooling/scripts/` or a narrowly scoped local-infra script location.
- [ ] Remove `infra/runtime/` if no unique responsibility remains.

The word `runtime` is not inherently wrong.

The issue is that the current directory now mostly contains:

```text
bootstrap assets
```

which is a narrower responsibility, but still distinct from local orchestration.

## Bootstrap Layout

- [x] Keep `infra/runtime/bootstrap/db/` documented as its own bootstrap domain.
- [x] Keep `infra/runtime/bootstrap/README.md` at the bootstrap root.
- [ ] Add a root `README.md` for any new bootstrap subfolder.
- [ ] Add a checklist item in the corresponding architecture section for any new bootstrap subfolder.


## Criteria

- Apply with [0. Core Principles](./00-core-principles.md) and [1. Target Repository Model](./01-target-repository-model.md).
