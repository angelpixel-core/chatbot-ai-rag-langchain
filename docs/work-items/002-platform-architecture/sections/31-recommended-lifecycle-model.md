# 31. Recommended Lifecycle Model

Use this conceptual distinction:

```text
LOCAL
  │
  ├── implementation
  ├── fast validation
  ├── local test config
  ├── Compose
  └── optional local Kubernetes
          │
          ▼
         CI
          │
  ┌───────┴────────┐
  │ automated tests│
  │ artifact build │
  └───────┬────────┘
          ▼
     DEVELOPMENT
     (optional shared)
          │
          ▼
         QA
          │
          ▼
       STAGING
          │
          ▼
     PRODUCTION
```

- [ ] Do not force every project to have every stage.
- [ ] Introduce persistent environments because a workflow requires them.


## Criteria

- Apply with [0. Core Principles](./00-core-principles.md) and [1. Target Repository Model](./01-target-repository-model.md).
