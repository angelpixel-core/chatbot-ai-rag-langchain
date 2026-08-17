# 20. `infra/local/`

## Responsibility

Provide local infrastructure orchestration.

## Target

```text
infra/local/
├── compose/
└── kubernetes/
```

## Compose

- [ ] Keep Compose as the fast/default local development path where appropriate.
- [ ] Use it for normal developer iteration.
- [ ] Keep local dependencies easy to start and destroy.

## Local Kubernetes

- [ ] Keep Kubernetes locally when infrastructure-sensitive behavior needs validation.
- [ ] Use local Kubernetes for near-production topology testing.
- [ ] Use it for Kubernetes-specific integration behavior.
- [ ] Use it for infrastructure demonstrations when useful.
- [ ] Do not require Kubernetes for every ordinary development cycle.

Therefore:

```text
Compose
   =
developer convenience

Local Kubernetes
   =
infrastructure/runtime fidelity
```

Both are valid because they solve different problems.


## Criteria

- Apply with [0. Core Principles](./00-core-principles.md) and [1. Target Repository Model](./01-target-repository-model.md).
