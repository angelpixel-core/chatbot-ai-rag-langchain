# 3. `apps/services/`

## Definition

A service is a long-running or independently executable server-side process.

Examples may include:

```text
apps/services/
├── core/
├── chatbot/
├── payments/
├── search-indexer/
└── notification-worker/
```

- [x] Use `services/` instead of `server/` as the general category.
- [x] A service may expose HTTP.
- [ ] A service may expose gRPC.
- [ ] A service may expose GraphQL.
- [ ] A service may consume events.
- [ ] A service may publish events.
- [ ] A service may execute background jobs.
- [ ] A service may execute scheduled jobs.
- [ ] A service may have no externally exposed network API.
- [ ] A service may contain application, domain, persistence, and integration logic.
- [x] Do not encode `microservice` into the directory taxonomy unless the architecture explicitly requires it.

## Service vs Microservice

- [x] Treat "service" as the neutral repository classification.
- [x] Treat "microservice" as an architectural/deployment decision.
- [ ] Do not define microservices based primarily on code size.
- [ ] Do not define microservices based primarily on whether HTTP endpoints exist.
- [ ] A microservice should represent a cohesive capability with an explicit boundary and independent lifecycle.
- [ ] A microservice should normally be independently deployable.
- [ ] A microservice may be entirely event-driven.
- [ ] A microservice may be a worker.
- [ ] A microservice may own persistence.
- [ ] A microservice may expose several interfaces.

## Domain Boundaries

- [ ] Keep domain boundaries explicit even inside a monolith.
- [ ] Allow bounded contexts to exist before extracting services.
- [ ] Prefer modular boundaries before premature distribution.

Example:

```text
services/core/
├── identity/
├── catalog/
├── ordering/
├── payments/
└── billing/
```

can remain one deployable.

Later:

```text
services/
├── core/
│   ├── identity/
│   ├── catalog/
│   ├── ordering/
│   └── billing/
│
└── payments/
```

may become appropriate if Payments requires an independent lifecycle.

- [x] Extract services because of operational/business boundaries, not because a directory exists.


## Verification Checklist

- [x] Aligned with [0. Core Principles](./00-core-principles.md).
- [x] Aligned with [1. Target Repository Model](./01-target-repository-model.md).
- [x] Confirmed against the current repository state.

## Criteria

- Apply with [0. Core Principles](./00-core-principles.md) and [1. Target Repository Model](./01-target-repository-model.md).
