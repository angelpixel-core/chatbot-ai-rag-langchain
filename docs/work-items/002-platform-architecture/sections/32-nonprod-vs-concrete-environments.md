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
