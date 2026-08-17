# 21. Remove / Reconsider Current `infra/runtime/`

## Current Responsibility

```text
infra/runtime/
├── compose.yaml
├── containers/
├── kubernetes/
└── scripts/
```

## Migration Intent

- [ ] Move application-specific Dockerfiles toward their owning applications.
- [ ] Move Compose responsibility toward `infra/local/compose/`.
- [ ] Move local Kubernetes responsibility toward `infra/local/kubernetes/`.
- [ ] Move operational helper scripts toward `tooling/scripts/` or a narrowly scoped local-infra script location.
- [ ] Remove `infra/runtime/` if no unique responsibility remains.

The word `runtime` is not inherently wrong.

The issue is that the current directory combines:

```text
packaging
+ local orchestration
+ Kubernetes
+ operational scripts
```

which represent different responsibilities.


## Criteria

- Apply with [0. Core Principles](./00-core-principles.md) and [1. Target Repository Model](./01-target-repository-model.md).
