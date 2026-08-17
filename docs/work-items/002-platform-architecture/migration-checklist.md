---
id: stage-1-Platform-Repository-Architecture-Migration-Checklist
aliases: []
tags: []
---

# Platform Repository — Architecture & Migration Checklist

> Practical checklist for validating the repository structure before,
> during, and after the structural migration.
>
> This document captures the architectural conventions, boundaries,
> responsibilities, and trade-offs agreed for the platform.
>
> The goal is not to prescribe technologies prematurely.
> The goal is to preserve clear ownership, deployment boundaries,
> runtime responsibilities, environment isolation, and future
> evolvability.

---

## Goal

Define a durable repository architecture for the platform repo and migrate toward it in controlled steps.

## Status

- Overall: in progress
- Current mode: section-by-section migration planning

## Legend

- `[ ]` pending
- `[x]` completed
- `[-]` intentionally deferred

## Index

- [ ] 0. Core Principles ([sections/00-core-principles.md](sections/00-core-principles.md))
- [ ] 1. Target Repository Model ([sections/01-target-repository-model.md](sections/01-target-repository-model.md))
- [ ] 2. `apps/` — Executable Product Units
- [ ] 3. `apps/services/`
- [ ] 4. `apps/web/`
- [ ] 5. `apps/mobile/`
- [ ] 6. `apps/desktop/`
- [ ] 7. `apps/cli/`
- [ ] 8. `embedded/`
- [ ] 9. Product Capabilities vs Execution Targets
- [ ] 10. `packages/`
- [ ] 11. `datasets/`
- [ ] 12. Dockerfile Ownership
- [ ] 13. Configuration
- [ ] 14. Secrets
- [ ] 15. Secret Ownership
- [ ] 16. `infra/` ([sections/16-infra.md](sections/16-infra.md))
- [ ] 17. `infra/provisioning/` ([sections/17-infra-provisioning.md](sections/17-infra-provisioning.md))
- [ ] 18. `infra/platform/` ([sections/18-infra-platform.md](sections/18-infra-platform.md))
- [ ] 19. `infra/delivery/` ([sections/19-infra-delivery.md](sections/19-infra-delivery.md))
- [ ] 20. `infra/local/` ([sections/20-infra-local.md](sections/20-infra-local.md))
- [ ] 21. Remove / Reconsider Current `infra/runtime/` ([sections/21-reconsider-infra-runtime.md](sections/21-reconsider-infra-runtime.md))
- [ ] 22. Kubernetes Duplication ([sections/22-kubernetes-duplication.md](sections/22-kubernetes-duplication.md))
- [ ] 23. Environment Taxonomy ([sections/23-environment-taxonomy.md](sections/23-environment-taxonomy.md))
- [ ] 24. Local ([sections/24-local.md](sections/24-local.md))
- [ ] 25. Development ([sections/25-development.md](sections/25-development.md))
- [ ] 26. Test ([sections/26-test.md](sections/26-test.md))
- [ ] 27. CI ([sections/27-ci.md](sections/27-ci.md))
- [ ] 28. QA ([sections/28-qa.md](sections/28-qa.md))
- [ ] 29. Staging ([sections/29-staging.md](sections/29-staging.md))
- [ ] 30. Production ([sections/30-production.md](sections/30-production.md))
- [ ] 31. Recommended Lifecycle Model
- [ ] 32. `nonprod` vs Concrete Environments
- [ ] 33. Kustomize Model
- [ ] 34. Deployment Strategies
- [ ] 35. `environments/`
- [ ] 36. `tooling/`
- [ ] 37. Makefile
- [ ] 38. Monorepo Decision
- [ ] 39. When Repository Separation Becomes Appropriate
- [ ] 40. Git Submodules
- [ ] 41. Prefer Artifact Composition Over Source Composition
- [ ] 42. Platform Definition
- [ ] 43. Product Platform vs Internal Developer Platform
- [ ] 44. Application Ownership
- [ ] 45. External Integration Ownership
- [ ] 46. Technology Placement
- [ ] 47. Technology Independence
- [ ] 48. Documentation
- [ ] 49. Migration-Specific Checks ([sections/49-migration-specific-checks.md](sections/49-migration-specific-checks.md))
- [ ] 50. Migration Order ([sections/50-migration-order.md](sections/50-migration-order.md))
- [ ] 51. Final Architecture Validation ([sections/51-final-architecture-validation.md](sections/51-final-architecture-validation.md))
- [ ] 52. Architecture Invariants ([sections/52-architecture-invariants.md](sections/52-architecture-invariants.md))
- [ ] 53. North Star ([sections/53-north-star.md](sections/53-north-star.md))

# 0. Core Principles

- See [`sections/00-core-principles.md`](sections/00-core-principles.md).

---

# 1. Target Repository Model

- See [`sections/01-target-repository-model.md`](sections/01-target-repository-model.md).

---

# 2. `apps/` — Executable Product Units

## Definition

`apps/` contains software units that provide executable product capabilities.

- [ ] `apps/` represents executable software, not infrastructure.
- [ ] Categorize applications primarily by **execution/interaction target**.
- [ ] Do not categorize top-level applications primarily by programming language.
- [ ] Do not use `api/` as the generic counterpart of `web/`.
- [ ] Do not use `assistant/` as a top-level execution category.
- [ ] Do not use `intelligence/` as a generic execution category.
- [ ] Avoid using `core/` at this level unless it genuinely identifies a concrete product/application boundary.

Reason:

`API`, `assistant`, `intelligence`, and `core` describe interfaces,
capabilities, domains, or product concepts rather than where/how the
software executes.

---

# 3. `apps/services/`

## Definition

A service is a long-running or independently executable server-side process.

Examples may include:

    apps/services/
    ├── core/
    ├── chatbot/
    ├── payments/
    ├── search-indexer/
    └── notification-worker/

- [ ] Use `services/` instead of `server/` as the general category.
- [ ] A service may expose HTTP.
- [ ] A service may expose gRPC.
- [ ] A service may expose GraphQL.
- [ ] A service may consume events.
- [ ] A service may publish events.
- [ ] A service may execute background jobs.
- [ ] A service may execute scheduled jobs.
- [ ] A service may have no externally exposed network API.
- [ ] A service may contain application, domain, persistence, and integration logic.
- [ ] Do not encode `microservice` into the directory taxonomy unless the architecture explicitly requires it.

## Service vs Microservice

- [ ] Treat "service" as the neutral repository classification.
- [ ] Treat "microservice" as an architectural/deployment decision.
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

    services/core/
    ├── identity/
    ├── catalog/
    ├── ordering/
    ├── payments/
    └── billing/

can remain one deployable.

Later:

    services/
    ├── core/
    │   ├── identity/
    │   ├── catalog/
    │   ├── ordering/
    │   └── billing/
    │
    └── payments/

may become appropriate if Payments requires an independent lifecycle.

- [ ] Extract services because of operational/business boundaries, not because a directory exists.

---

# 4. `apps/web/`

## Definition

Contains applications whose primary interaction target is the Web.

Example:

    apps/web/
    ├── customer-portal/
    ├── admin-console/
    └── chatbot/

- [ ] Organize first by product/application.
- [ ] Put framework-specific implementation below the product boundary when useful.
- [ ] Do not require every web application to use the same framework.
- [ ] Allow Next.js, Rails, Django, Elixir, Rust, etc. where appropriate.
- [ ] Treat `web` as an execution/interaction target, not as a JavaScript synonym.

Possible structure:

    apps/web/
    └── customer-portal/
        └── ...

rather than:

    apps/
    └── nextjs/

---

# 5. `apps/mobile/`

## Definition

Contains applications targeting mobile/device ecosystems.

Potential future structure:

    apps/mobile/
    ├── ios/
    │   └── <product>/
    └── android/
        └── <product>/

- [ ] Organize by target platform when that distinction becomes meaningful.
- [ ] Allow multiple products under the same platform.
- [ ] Keep React Native/Kotlin/Swift/etc. as implementation choices rather than top-level architectural categories.
- [ ] Do not create `ios/` or `android/` prematurely if one cross-platform application is currently sufficient.

---

# 6. `apps/desktop/`

- [ ] Use only when an actual desktop-targeted application exists.
- [ ] Organize by product before implementation technology where possible.
- [ ] Keep Electron/Tauri/native/etc. as implementation details.

---

# 7. `apps/cli/`

- [ ] Treat CLI programs as first-class executable applications when they have meaningful independent behavior.
- [ ] Do not hide substantial CLI products inside generic `scripts/`.
- [ ] Keep small operational helpers under `tooling/scripts/`.
- [ ] Distinguish product CLI from repository automation.

Rule of thumb:

    product-facing executable     -> apps/cli/
    repository/platform helper    -> tooling/scripts/

---

# 8. `embedded/`

`embedded/` is intentionally NOT required today.

It would represent software targeting dedicated hardware such as:

- POS terminals
- IoT devices
- sensors
- gateways
- controllers
- dedicated appliances
- embedded vehicle systems

- [ ] Do not create `apps/embedded/` until an actual embedded target exists.
- [ ] Add the category later without changing the existing taxonomy.

---

# 9. Product Capabilities vs Execution Targets

Avoid this:

    apps/
    ├── assistant/
    ├── intelligence/
    ├── api/
    └── core/

when those names describe capabilities rather than execution targets.

Prefer:

    apps/
    ├── services/
    │   └── chatbot/
    └── web/
        └── chatbot/

Here:

    chatbot

is the product/capability.

While:

    services
    web

describe execution/interaction categories.

- [ ] Keep this distinction explicit during migration.

---

# 10. `packages/`

## Definition

Contains reusable software artifacts that are not independently operated applications.

Potential structure:

    packages/
    ├── contracts/
    ├── clients/
    ├── design-system/
    └── shared/

## `contracts/`

- [ ] Place shared interface/schema definitions here when appropriate.
- [ ] Examples may include OpenAPI schemas, protobuf definitions, event schemas, or shared DTO contracts.
- [ ] Avoid duplicating integration contracts across applications.

## `clients/`

- [ ] Place reusable service/provider clients here when genuinely shared.
- [ ] Avoid extracting a client library before multiple consumers justify it.

## `design-system/`

- [ ] Use for reusable UI primitives/design artifacts shared by multiple user interfaces.
- [ ] Do not create it merely because one web application has components.

## `shared/`

- [ ] Use sparingly.
- [ ] Do not turn `shared/` into an architectural junk drawer.
- [ ] Promote artifacts into more explicit categories when a clear responsibility emerges.

---

# 11. `datasets/`

- [ ] Keep datasets separate from executable applications.
- [ ] Distinguish source/reference datasets from generated runtime data.
- [ ] Do not commit sensitive production datasets.
- [ ] Document provenance and intended usage where appropriate.
- [ ] Keep AI/RAG datasets independent from a specific AI implementation when possible.

Example:

    datasets/
    └── coffee-shop/

rather than hiding the dataset inside:

    apps/services/chatbot/

when the data represents platform/product knowledge rather than application source.

---

# 12. Dockerfile Ownership

## Decision

A Dockerfile belongs naturally close to the application it packages.

Example:

    apps/services/chatbot/
    ├── src/
    ├── tests/
    ├── pyproject.toml
    └── Dockerfile

- [ ] Treat Dockerfile as an application packaging boundary.
- [ ] Do not consider Dockerfile part of the business/domain model.
- [ ] Do not consider Dockerfile infrastructure provisioning.
- [ ] Do not centralize every application Dockerfile under `infra/containers/`.
- [ ] Keep application-specific build knowledge with the application.

Conceptually:

    source
       │
       │ Dockerfile
       ▼
    runtime artifact
       │
       ▼
    deployment

## Docker Image Rules

- [ ] Build environment-independent images.
- [ ] Do not build a separate application image for QA.
- [ ] Do not build another image for staging.
- [ ] Do not build another image for production solely because configuration differs.
- [ ] Promote the same immutable artifact across environments.

Target flow:

    source
      │
      ▼
    image:1.4.2
      │
      ├── development
      ├── QA
      ├── staging
      └── production

- [ ] Follow "build once, configure at runtime, promote the same artifact."

---

# 13. Configuration

## Principle

Application configuration comes from the execution environment.

- [ ] Keep environment-independent defaults in application source where appropriate.
- [ ] Inject environment-specific values externally.
- [ ] Avoid environment branching scattered throughout application source.
- [ ] Avoid excessive `if production?`, `if staging?`, etc.
- [ ] Prefer explicit configuration inputs.
- [ ] Document every required configuration key.

Example committed artifact:

    config/
    ├── schema/
    ├── defaults/
    └── examples/

Exact organization may evolve.

---

# 14. Secrets

## Hard Rules

- [ ] Never commit real secrets.
- [ ] Never store production secrets in `.env` files tracked by Git.
- [ ] Never embed secrets into Docker images.
- [ ] Never embed secrets into Dockerfiles.
- [ ] Avoid exposing secrets through Docker build arguments.
- [ ] Never commit decrypted Rails credentials.
- [ ] Never commit cloud provider credentials.

## Repository Material

Repository may contain:

    .env.example
    config.example
    secrets.example
    README instructions
    secret references

but not secret values.

- [ ] Commit names/references/contracts for secrets.
- [ ] Keep actual values external.

---

# 15. Secret Ownership

Distinguish:

    secret ownership
    secret storage
    secret consumption

Example:

    Payment credential
           │
           ▼
    Security/Payments owner
           │
           ▼
         Vault
           │
           ▼
    workload identity
           │
           ▼
    payments service

- [ ] Define who owns each sensitive credential.
- [ ] Define which workload may consume it.
- [ ] Apply least privilege.
- [ ] Prefer workload identity over static global credentials.
- [ ] Allow services to read only required secrets.
- [ ] Avoid allowing applications to modify secrets unless explicitly required.
- [ ] Audit sensitive secret access where possible.
- [ ] Keep break-glass access exceptional and auditable.

---

# 16. `infra/`

- See [`sections/16-infra.md`](sections/16-infra.md).

---

# 17. `infra/provisioning/`

- See [`sections/17-infra-provisioning.md`](sections/17-infra-provisioning.md).

---

# 18. `infra/platform/`

- See [`sections/18-infra-platform.md`](sections/18-infra-platform.md).

---

# 19. `infra/delivery/`

- See [`sections/19-infra-delivery.md`](sections/19-infra-delivery.md).

---

# 20. `infra/local/`

- See [`sections/20-infra-local.md`](sections/20-infra-local.md).

---

# 21. Remove / Reconsider Current `infra/runtime/`

- See [`sections/21-reconsider-infra-runtime.md`](sections/21-reconsider-infra-runtime.md).

---

# 22. Kubernetes Duplication

- See [`sections/22-kubernetes-duplication.md`](sections/22-kubernetes-duplication.md).

---

# 23. Environment Taxonomy

- See [`sections/23-environment-taxonomy.md`](sections/23-environment-taxonomy.md).

---

# 24. Local

- See [`sections/24-local.md`](sections/24-local.md).

---

# 25. Development

- See [`sections/25-development.md`](sections/25-development.md).

---

# 26. Test

- See [`sections/26-test.md`](sections/26-test.md).

---

# 27. CI

- See [`sections/27-ci.md`](sections/27-ci.md).

---

# 28. QA

- See [`sections/28-qa.md`](sections/28-qa.md).

---

# 29. Staging

- See [`sections/29-staging.md`](sections/29-staging.md).

---

# 30. Production

- See [`sections/30-production.md`](sections/30-production.md).

---

# 31. Recommended Lifecycle Model

- See [`sections/31-recommended-lifecycle-model.md`](sections/31-recommended-lifecycle-model.md).

---

# 32. `nonprod` vs Concrete Environments

- See [`sections/32-nonprod-vs-concrete-environments.md`](sections/32-nonprod-vs-concrete-environments.md).

---

# 33. Kustomize Model

- See [`sections/33-kustomize-model.md`](sections/33-kustomize-model.md).

---

# 34. Deployment Strategies

- See [`sections/34-deployment-strategies.md`](sections/34-deployment-strategies.md).

---

# 35. `environments/`

- See [`sections/35-environments.md`](sections/35-environments.md).

---

# 36. `tooling/`

- See [`sections/36-tooling.md`](sections/36-tooling.md).

---

# 37. Makefile

- See [`sections/37-makefile.md`](sections/37-makefile.md).

---

# 38. Monorepo Decision

- See [`sections/38-monorepo-decision.md`](sections/38-monorepo-decision.md).

---

# 39. When Repository Separation Becomes Appropriate

- See [`sections/39-when-repository-separation-becomes-appropriate.md`](sections/39-when-repository-separation-becomes-appropriate.md).

---

# 40. Git Submodules

- See [`sections/40-git-submodules.md`](sections/40-git-submodules.md).

---

# 41. Prefer Artifact Composition Over Source Composition

- See [`sections/41-prefer-artifact-composition-over-source-composition.md`](sections/41-prefer-artifact-composition-over-source-composition.md).

---

# 42. Platform Definition

- See [`sections/42-platform-definition.md`](sections/42-platform-definition.md).

---

# 43. Product Platform vs Internal Developer Platform

- See [`sections/43-product-platform-vs-internal-developer-platform.md`](sections/43-product-platform-vs-internal-developer-platform.md).

---

# 44. Application Ownership

- See [`sections/44-application-ownership.md`](sections/44-application-ownership.md).

---

# 45. External Integration Ownership

- See [`sections/45-external-integration-ownership.md`](sections/45-external-integration-ownership.md).

---

# 46. Technology Placement

- See [`sections/46-technology-placement.md`](sections/46-technology-placement.md).

---

# 47. Technology Independence

- See [`sections/47-technology-independence.md`](sections/47-technology-independence.md).

---

# 48. Documentation

- See [`sections/48-documentation.md`](sections/48-documentation.md).

---

# 49. Migration-Specific Checks

- See [`sections/49-migration-specific-checks.md`](sections/49-migration-specific-checks.md).

---

# 50. Migration Order

- See [`sections/50-migration-order.md`](sections/50-migration-order.md).

---

# 51. Final Architecture Validation

- See [`sections/51-final-architecture-validation.md`](sections/51-final-architecture-validation.md).

---

# 52. Architecture Invariants

- See [`sections/52-architecture-invariants.md`](sections/52-architecture-invariants.md).

---

# 53. North Star

- See [`sections/53-north-star.md`](sections/53-north-star.md).
