# 12. Dockerfile Ownership

## Decision

A Dockerfile belongs naturally close to the application it packages.

Example:

```text
apps/services/chatbot/
├── src/
├── tests/
├── pyproject.toml
└── Dockerfile
```

- [ ] Treat Dockerfile as an application packaging boundary.
- [ ] Do not consider Dockerfile part of the business/domain model.
- [ ] Do not consider Dockerfile infrastructure provisioning.
- [ ] Do not centralize every application Dockerfile under `infra/containers/`.
- [ ] Keep application-specific build knowledge with the application.

Conceptually:

```text
source
   │
   │ Dockerfile
   ▼
runtime artifact
   │
   ▼
deployment
```

## Docker Image Rules

- [ ] Build environment-independent images.
- [ ] Do not build a separate application image for QA.
- [ ] Do not build another image for staging.
- [ ] Do not build another image for production solely because configuration differs.
- [ ] Promote the same immutable artifact across environments.

Target flow:

```text
source
  │
  ▼
image:1.4.2
  │
  ├── development
  ├── QA
  ├── staging
  └── production
```

- [ ] Follow "build once, configure at runtime, promote the same artifact."


## Criteria

- Apply with [0. Core Principles](./00-core-principles.md) and [1. Target Repository Model](./01-target-repository-model.md).
