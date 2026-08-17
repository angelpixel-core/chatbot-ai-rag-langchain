# 32. `nonprod` vs Concrete Environments

`nonprod` is useful as an **infrastructure grouping**, not necessarily as a user-facing environment.

Example:

```text
infrastructure accounts
├── nonprod
│   ├── development
│   ├── QA
│   └── staging
│
└── prod
```

- [ ] Allow cloud infrastructure to group development/QA/staging as `nonprod`.
- [ ] Keep individual deployment configurations distinguishable.
- [ ] Do not collapse all non-production behavior into one indistinguishable configuration.


## Criteria

- Apply with [0. Core Principles](./00-core-principles.md) and [1. Target Repository Model](./01-target-repository-model.md).
