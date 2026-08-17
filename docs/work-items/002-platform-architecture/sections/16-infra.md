# 16. `infra/`

`infra/` describes where and how software runs.

It does NOT contain the business application itself.

## Target

```text
infra/
├── provisioning/
├── platform/
├── delivery/
└── local/
```

- [ ] Keep infrastructure responsibilities explicitly separated.
- [ ] Eliminate duplicated manifests where responsibilities overlap.
- [ ] Do not use `runtime/` as a generic dumping ground.


## Criteria

- Apply with [0. Core Principles](./00-core-principles.md) and [1. Target Repository Model](./01-target-repository-model.md).
