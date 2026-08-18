# 12. Dockerfile Ownership

## Decision

A Dockerfile belongs naturally close to the application it packages.
It is part of the application packaging boundary, not shared infrastructure.

Example:

```text
apps/services/chatbot/
├── config/
├── manage.py
├── entrypoint.sh
└── Dockerfile
```

- [x] Treat Dockerfile as an application packaging boundary.
- [x] Do not consider Dockerfile part of the business/domain model.
- [x] Do not consider Dockerfile infrastructure provisioning.
- [x] Do not centralize every application Dockerfile under shared infra runtime folders.
- [x] Keep application-specific build knowledge with the application.

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

## Verification Checklist

- [x] Application Dockerfiles live next to their owning apps.
- [x] The service Dockerfile is under `apps/services/chatbot/`.
- [x] The web Dockerfile is under `apps/web/chatbot/`.
- [x] Runtime build scripts point to the app-local Dockerfiles.
- [ ] Build environment-independent images.
- [ ] Promote the same immutable artifact across environments.


## Criteria

- Apply with [0. Core Principles](./00-core-principles.md) and [1. Target Repository Model](./01-target-repository-model.md).
