# 7. `apps/cli/`

- [ ] Treat CLI programs as first-class executable applications when they have meaningful independent behavior.
- [ ] Do not hide substantial CLI products inside generic `scripts/`.
- [ ] Keep small operational helpers under `tooling/scripts/`.
- [ ] Distinguish product CLI from repository automation.

Rule of thumb:

```text
product-facing executable     -> apps/cli/
repository/platform helper    -> tooling/scripts/
```


## Criteria

- Apply with [0. Core Principles](./00-core-principles.md) and [1. Target Repository Model](./01-target-repository-model.md).
