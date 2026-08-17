# 34. Deployment Strategies

Strategies such as:

- rolling deployment
- canary
- blue/green
- progressive rollout

primarily concern **production release behavior**.

- [ ] Model deployment strategy as part of delivery.
- [ ] Do not confuse environment promotion with deployment strategy.
- [ ] Staging validates the candidate artifact.
- [ ] Production rollout strategy controls exposure of that artifact to real traffic.

Conceptually:

```text
QA
  ↓
staging
  ↓
approved artifact
  ↓
production
  │
  ├── rolling
  ├── canary
  └── blue/green
```
