# 16. `infra/`

`infra/` describes where and how software runs.

It does NOT contain the business application itself.

## Target

```text
infra/
├── bootstrap/
├── provisioning/
├── platform/
├── delivery/
└── local/
```

- [ ] Keep infrastructure responsibilities explicitly separated.
- [ ] Eliminate duplicated manifests where responsibilities overlap.
- [ ] Do not use `runtime/` as a generic dumping ground.
- [ ] Keep database bootstrap assets under `infra/runtime/bootstrap/` or an equivalent explicit bootstrap boundary.
- [ ] Give each bootstrap subfolder its own root `README.md` and matching checklist item in the owning section.


## Criteria

- Apply with [0. Core Principles](./00-core-principles.md) and [1. Target Repository Model](./01-target-repository-model.md).
