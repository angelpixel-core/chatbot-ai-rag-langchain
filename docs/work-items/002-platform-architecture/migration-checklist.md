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

- [ ] 0. Core Principles
- [ ] 1. Target Repository Model
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
- [ ] 16. `infra/`
- [ ] 17. `infra/provisioning/`
- [ ] 18. `infra/platform/`
- [ ] 19. `infra/delivery/`
- [ ] 20. `infra/local/`
- [ ] 21. Remove / Reconsider Current `infra/runtime/`
- [ ] 22. Kubernetes Duplication
- [ ] 23. Environment Taxonomy
- [ ] 24. Local
- [ ] 25. Development
- [ ] 26. Test
- [ ] 27. CI
- [ ] 28. QA
- [ ] 29. Staging
- [ ] 30. Production
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
- [ ] 49. Migration-Specific Checks
- [ ] 50. Migration Order
- [ ] 51. Final Architecture Validation
- [ ] 52. Architecture Invariants
- [ ] 53. North Star

# 0. Core Principles

## Repository Design

- [ ] Organize the repository primarily by **responsibility and architectural intent**, not by technology.
- [ ] Prefer technology-agnostic directory names at higher architectural levels.
- [ ] Allow technology-specific names closer to implementation leaves.
- [ ] Do not introduce directories only because they may become useful someday.
- [ ] Every top-level directory must represent a clearly different responsibility.
- [ ] Avoid duplicating the same responsibility across multiple top-level directories.
- [ ] Avoid using directory structure to prematurely encode architectural decisions that have not yet been made.
- [ ] Prefer structures that can evolve without requiring a complete repository reorganization.

## Architectural Boundaries

- [ ] Distinguish between:
  - [ ] application source
  - [ ] shared packages
  - [ ] datasets
  - [ ] configuration
  - [ ] infrastructure provisioning
  - [ ] platform capabilities
  - [ ] workload delivery
  - [ ] local execution
  - [ ] tooling
  - [ ] documentation
- [ ] Do not confuse a domain boundary with a deployment boundary.
- [ ] Do not assume a bounded context must become a microservice.
- [ ] Do not assume every independently executable process requires its own repository.
- [ ] Do not assume every application inside `apps/` must use the same technology.

---

# 1. Target Repository Model

Use this conceptual structure as the migration target:

    platform/
    ├── apps/
    │   ├── services/
    │   ├── web/
    │   ├── mobile/
    │   ├── desktop/
    │   └── cli/
    │
    ├── packages/
    │   ├── contracts/
    │   ├── clients/
    │   ├── design-system/
    │   └── shared/
    │
    ├── datasets/
    │
    ├── config/
    │
    ├── infra/
    │   ├── provisioning/
    │   ├── platform/
    │   ├── delivery/
    │   └── local/
    │
    ├── environments/
    │
    ├── tooling/
    │   ├── scripts/
    │   ├── generators/
    │   └── hooks/
    │
    ├── docs/
    │   ├── architecture/
    │   ├── adr/
    │   └── ...
    │
    ├── Makefile
    └── README.md

- [ ] Treat this tree as an architectural taxonomy rather than a mandatory list of directories.
- [ ] Create only directories currently justified by actual artifacts.
- [ ] Keep empty future categories out of the repository unless they improve navigation or communicate an imminent boundary.

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

## Definition

`infra/` describes where and how software runs.

It does NOT contain the business application itself.

Target:

    infra/
    ├── provisioning/
    ├── platform/
    ├── delivery/
    └── local/

- [ ] Keep infrastructure responsibilities explicitly separated.
- [ ] Eliminate duplicated manifests where responsibilities overlap.
- [ ] Do not use `runtime/` as a generic dumping ground.

---

# 17. `infra/provisioning/`

## Responsibility

Provision external infrastructure/resources.

Examples:

- AWS accounts
- VPCs
- subnets
- EKS
- ECS
- RDS
- ECR
- IAM
- KMS
- DNS infrastructure
- cloud-level policies

Potential structure:

    infra/provisioning/
    └── aws/
        ├── modules/
        ├── shared/
        ├── nonprod/
        └── prod/

- [ ] Terraform/Pulumi/etc. belong here when provisioning external resources.
- [ ] Keep reusable provisioning modules separate from environment composition.
- [ ] Avoid mixing Kubernetes workload manifests with cloud provisioning.

---

# 18. `infra/platform/`

## Responsibility

Contains shared platform capabilities installed on top of provisioned infrastructure.

Potential examples:

    infra/platform/
    ├── networking/
    ├── security/
    ├── observability/
    └── controllers/

Possible capabilities:

- ingress controller
- cert-manager
- external-dns
- telemetry stack
- secret integration
- policy controllers
- GitOps controller

- [ ] Distinguish platform capabilities from user workloads.
- [ ] Distinguish platform configuration from underlying cloud provisioning.

---

# 19. `infra/delivery/`

## Responsibility

Defines how application workloads are deployed/promoted.

Potential structure:

    infra/delivery/
    ├── workloads/
    └── environments/

- [ ] Application Kubernetes manifests belong to the delivery responsibility.
- [ ] GitOps definitions belong here.
- [ ] Argo CD application definitions belong here when used for delivery.
- [ ] Keep workload delivery separate from platform controllers.
- [ ] Avoid maintaining an independent second copy of the same Kubernetes workload under another directory.

---

# 20. `infra/local/`

## Responsibility

Provide local infrastructure orchestration.

Target:

    infra/local/
    ├── compose/
    └── kubernetes/

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

    Compose
       =
    developer convenience

    Local Kubernetes
       =
    infrastructure/runtime fidelity

Both are valid because they solve different problems.

---

# 21. Remove / Reconsider Current `infra/runtime/`

Current responsibility:

    infra/runtime/
    ├── compose.yaml
    ├── containers/
    ├── kubernetes/
    └── scripts/

Migration intent:

- [ ] Move application-specific Dockerfiles toward their owning applications.
- [ ] Move Compose responsibility toward `infra/local/compose/`.
- [ ] Move local Kubernetes responsibility toward `infra/local/kubernetes/`.
- [ ] Move operational helper scripts toward `tooling/scripts/` or a narrowly scoped local-infra script location.
- [ ] Remove `infra/runtime/` if no unique responsibility remains.

The word `runtime` is not inherently wrong.

The issue is that the current directory combines:

    packaging
    + local orchestration
    + Kubernetes
    + operational scripts

which represent different responsibilities.

---

# 22. Kubernetes Duplication

Current migration must explicitly inspect:

    infra/delivery/user-apps/...
    infra/runtime/kubernetes/...

- [ ] Determine whether manifests represent the same workloads.
- [ ] Identify duplicated:
  - [ ] namespaces
  - [ ] deployments
  - [ ] services
  - [ ] ingress
  - [ ] configuration
  - [ ] labels
  - [ ] resource definitions
- [ ] Establish one canonical workload definition where practical.
- [ ] Use overlays/patches rather than copying complete manifests.
- [ ] Keep local differences as overlays.
- [ ] Keep non-production differences as overlays.
- [ ] Keep production differences as overlays.
- [ ] Avoid divergent copies of the same workload definition.

Conceptual goal:

    canonical workload
           │
      ┌────┼────┐
      ▼    ▼    ▼
    local QA   prod
       overlays/config

rather than:

    local-copy/
    qa-copy/
    staging-copy/
    production-copy/

---

# 23. Environment Taxonomy

Do not confuse:

    execution environment
    testing stage
    deployment stage
    Git branch

These are different dimensions.

---

# 24. Local

`local` describes **where execution occurs**, not a lifecycle stage.

- [ ] Local execution happens on a developer/operator machine.
- [ ] Local may use Compose.
- [ ] Local may use Kubernetes.
- [ ] Local may execute application test configuration.
- [ ] Do not treat `local` as synonymous with `development`.

---

# 25. Development

`development` describes an engineering environment/stage.

Possible meaning:

    feature branch
        ↓
       CI
        ↓
    shared development environment

- [ ] A shared development environment may exist.
- [ ] It may be deployed after merge to a development branch/trunk policy.
- [ ] Multiple developers may inspect integrated changes there.
- [ ] Do not require a shared dev environment if the project does not need one.

---

# 26. Test

`test` primarily describes an **application/testing configuration**, not necessarily a permanently deployed infrastructure environment.

Examples:

    local tests
    CI unit tests
    CI integration tests
    CI regression tests

- [ ] Do not automatically create a permanent `test` Kubernetes environment.
- [ ] Allow test configuration to run locally and inside CI.
- [ ] Treat ephemeral CI environments separately from persistent environments.

---

# 27. CI

CI is a validation pipeline, not necessarily an environment.

Typical progression:

    source
      ↓
    lint
      ↓
    unit tests
      ↓
    integration tests
      ↓
    build
      ↓
    artifact
      ↓
    additional validation

- [ ] Keep CI concerns separate from persistent deployment environments.
- [ ] Allow expensive test suites to run remotely.
- [ ] Allow developers to run faster subsets locally.

---

# 28. QA

QA may represent a real shared deployment environment.

Potential lifecycle:

    CI passed
       ↓
    deploy QA
       ↓
    automated validation
       +
    manual/semi-automated QA
       ↓
    promote

- [ ] Give QA its own environment-specific configuration when a persistent QA environment exists.
- [ ] Give QA its own secrets where required.
- [ ] Do not share production credentials with QA.

---

# 29. Staging

Staging is the final production-like validation environment.

- [ ] Keep staging topology reasonably close to production where valuable.
- [ ] Allow staging to use staging-specific datasets/configuration.
- [ ] Use staging for final integration and operational verification.
- [ ] Do not expect staging to reproduce production traffic scale.
- [ ] Do not confuse staging with CI.
- [ ] Do not require production rollout strategies merely to validate staging.

---

# 30. Production

Production serves real workloads/users.

- [ ] Production has independent secrets.
- [ ] Production has independent access policies.
- [ ] Production deployment must be explicitly controlled.
- [ ] Production promotion should use previously validated immutable artifacts.

---

# 31. Recommended Lifecycle Model

Use this conceptual distinction:

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

- [ ] Do not force every project to have every stage.
- [ ] Introduce persistent environments because a workflow requires them.

---

# 32. `nonprod` vs Concrete Environments

`nonprod` is useful as an **infrastructure grouping**, not necessarily as a user-facing environment.

Example:

    infrastructure accounts
    ├── nonprod
    │   ├── development
    │   ├── QA
    │   └── staging
    │
    └── prod

- [ ] Allow cloud infrastructure to group development/QA/staging as `nonprod`.
- [ ] Keep individual deployment configurations distinguishable.
- [ ] Do not collapse all non-production behavior into one indistinguishable configuration.

---

# 33. Kustomize Model

Prefer:

    base
    └── overlays
        ├── local
        ├── development
        ├── qa
        ├── staging
        └── production

when each overlay is actually required.

Alternatively, infrastructure-level grouping may use:

    base
    └── overlays
        ├── local
        ├── nonprod
        └── prod

only when differences genuinely exist at that grouping level.

- [ ] Do not create overlays merely to mirror environment names.
- [ ] Create overlays because configuration/resource topology differs.
- [ ] Prefer patches over copied manifests.
- [ ] Keep canonical definitions DRY.
- [ ] Avoid over-abstracting Kustomize solely to eliminate a few repeated lines.

DRY is subordinate to clarity.

---

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

---

# 35. `environments/`

This directory must not become a secret store.

Its purpose, if retained, should be **environment composition and configuration contracts**.

- [ ] Reassess current `infra/environments/`.
- [ ] Move environment concepts out of infrastructure subdomains when they apply across the whole platform.
- [ ] Keep only safe committed configuration.
- [ ] Keep `.example` / templates where needed.
- [ ] Keep documentation for acquiring/provisioning required secrets.
- [ ] Keep actual secret values external.

Potential conceptual form:

    environments/
    ├── development/
    ├── qa/
    ├── staging/
    └── production/

but only if repository-level environment composition requires it.

- [ ] Avoid duplicating Kustomize overlays inside `environments/`.
- [ ] Avoid duplicating Terraform variables inside `environments/`.
- [ ] Prefer references/composition over copies.

---

# 36. `tooling/`

Repository/platform engineering utilities belong here.

Target:

    tooling/
    ├── scripts/
    ├── generators/
    └── hooks/

- [ ] Move generic operational scripts here.
- [ ] Keep repository setup scripts here.
- [ ] Keep lint/bootstrap helpers here.
- [ ] Keep generators here.
- [ ] Keep Git hooks/setup here.
- [ ] Avoid putting product applications here.
- [ ] Avoid putting infrastructure definitions here.

---

# 37. Makefile

Treat the root Makefile as a **developer/platform interface**.

Examples conceptually:

    make setup
    make dev
    make test
    make lint
    make build
    make local-up
    make local-down
    make k8s-up
    make k8s-down

- [ ] Keep implementation complexity out of the Makefile.
- [ ] Delegate complex operations to scripts/tools.
- [ ] Use Make as a discoverable façade over common operations.
- [ ] Keep commands consistent across applications where practical.

---

# 38. Monorepo Decision

Current preference:

- [ ] Keep closely evolving applications, infrastructure, packages, and tooling in one monorepo while cross-cutting changes benefit from atomic commits/PRs.
- [ ] Allow one PR to represent a complete vertical feature.
- [ ] Do not split repositories solely because components are independently deployable.
- [ ] Do not introduce Git submodules simply to create conceptual boundaries.

Monorepo advantages currently desired:

- [ ] atomic cross-application changes
- [ ] cross-layer PR visibility
- [ ] easier local orchestration
- [ ] shared tooling
- [ ] simpler contract evolution
- [ ] easier demos
- [ ] centralized architectural visibility

---

# 39. When Repository Separation Becomes Appropriate

Consider extracting a component when several of these become true:

- [ ] independent release lifecycle
- [ ] independent ownership/team
- [ ] independent access/security requirements
- [ ] independent public/private visibility requirements
- [ ] substantially different CI/CD lifecycle
- [ ] independent versioning becomes operationally valuable
- [ ] repository size materially harms development workflows
- [ ] consumers require released versions independent of platform development
- [ ] component becomes reusable across multiple unrelated products/platforms

Do not extract merely because:

- [ ] it uses another language
- [ ] it has its own Dockerfile
- [ ] it deploys independently
- [ ] it has its own database
- [ ] it is called a "microservice"

---

# 40. Git Submodules

Git submodules are NOT the default architecture.

Use them only when source-level composition is intentionally required.

Potential legitimate future model:

    platform.git
    └── apps/
        ├── product-a -> commit/tag X
        ├── product-b -> commit/tag Y
        └── product-c -> commit/tag Z

- [ ] Introduce submodules only when independent repositories already provide real value.
- [ ] Do not use submodules to simulate repository boundaries prematurely.
- [ ] Accept that cross-repository feature changes lose atomicity.
- [ ] Accept additional CI/developer tooling complexity.
- [ ] Document submodule update procedures if adopted.

---

# 41. Prefer Artifact Composition Over Source Composition

For runtime/platform composition, prefer:

    product-a:1.8.3
    product-b:3.2.1
    product-c:0.9.0-beta

rather than requiring:

    git submodule product-a
    git submodule product-b
    git submodule product-c

where possible.

- [ ] Version application artifacts.
- [ ] Pin deployed versions.
- [ ] Keep source development independent from deployed platform composition.
- [ ] Allow a product to continue evolving while production remains pinned to a known-good version.

Example:

    product-a.git
        │
        ├── 1.8.3  ──────────────┐
        ├── 1.9.0                │
        └── 2.0-beta             │
                                 ▼
    platform.git
        product-a.image = 1.8.3

This gives independent evolution without requiring source composition.

---

# 42. Platform Definition

Treat the repository as potentially evolving from:

    one product
    + several applications
    + infrastructure

toward:

    multiple products
    + shared capabilities
    + infrastructure
    + delivery
    + operational tooling

Therefore `platform/` is a legitimate conceptual root.

- [ ] Platform may compose multiple applications/products.
- [ ] Platform may provide shared runtime capabilities.
- [ ] Platform may provide provisioning.
- [ ] Platform may provide delivery mechanisms.
- [ ] Platform may provide observability/security/networking.
- [ ] Platform may provide developer tooling.

---

# 43. Product Platform vs Internal Developer Platform

Keep the conceptual distinction.

## Product Platform

Represents:

    products
    + shared business capabilities
    + runtime composition

## Internal Developer Platform

Represents capabilities that help engineers build/run software:

    provisioning
    delivery
    observability
    secrets integration
    developer tooling
    golden paths
    environment management

- [ ] They may coexist in the same repository today.
- [ ] Do not assume they must become separate repositories.
- [ ] Preserve the conceptual boundary even when physically colocated.

---

# 44. Application Ownership

Every application should eventually make clear:

- [ ] What capability does it provide?
- [ ] Who/what consumes it?
- [ ] How does it execute?
- [ ] How is it packaged?
- [ ] What configuration does it require?
- [ ] What secrets does it require?
- [ ] What data does it own?
- [ ] What external systems does it integrate with?
- [ ] What contracts does it expose?
- [ ] What events does it consume?
- [ ] What events does it produce?
- [ ] How is it observed?
- [ ] How is it deployed?

These answers belong in documentation/metadata, not necessarily directory names.

---

# 45. External Integration Ownership

Preserve the broader engineering principle:

> Delegating execution to an external provider does not delegate
> accountability for the interaction.

For external integrations:

- [ ] Own the outgoing request intent.
- [ ] Persist relevant interaction state when business/audit requirements justify it.
- [ ] Track provider identifiers.
- [ ] Track relevant responses/status transitions.
- [ ] Define retry behavior.
- [ ] Define idempotency behavior.
- [ ] Define failure behavior.
- [ ] Define timeout behavior.
- [ ] Define reconciliation behavior where applicable.
- [ ] Avoid making an external provider the only source of operational truth for platform-owned workflows.

---

# 46. Technology Placement

Technologies belong as implementation choices beneath architectural boundaries.

Good:

    apps/
    ├── services/
    │   ├── core/        # Rails
    │   └── chatbot/     # Python
    ├── web/
    │   └── portal/      # Next.js
    └── mobile/
        └── client/      # React Native

Avoid:

    apps/
    ├── ruby/
    ├── python/
    ├── typescript/
    └── react/

- [ ] Architecture names the responsibility.
- [ ] Implementation selects the technology.

---

# 47. Technology Independence

The target architecture must remain compatible with:

- [ ] Ruby / Rails
- [ ] Python
- [ ] TypeScript / Node
- [ ] Next.js
- [ ] React Native
- [ ] Go
- [ ] Rust
- [ ] future languages/frameworks

without requiring a top-level repository redesign.

Infrastructure should similarly allow evolution between:

- [ ] Docker
- [ ] Kubernetes
- [ ] ECS
- [ ] serverless
- [ ] AWS
- [ ] other cloud providers

without redefining application ownership.

---

# 48. Documentation

Target:

    docs/
    ├── architecture/
    ├── adr/
    └── ...

- [ ] Keep architectural documentation.
- [ ] Keep ADRs that explain consequential decisions.
- [ ] Keep operational documentation needed to run the platform.
- [ ] Keep setup/onboarding documentation.
- [ ] Keep diagrams where they improve understanding.
- [ ] Keep public documentation intentional.

For public repositories:

- [ ] Reconsider publishing internal `work-items/`.
- [ ] Separate durable architectural knowledge from temporary implementation reasoning.
- [ ] Keep implementation planning/private reasoning outside the public artifact when it adds no consumer value.
- [ ] Extract useful conclusions into ADRs or architecture docs.

---

# 49. Migration-Specific Checks

Before moving any file:

- [ ] Identify its responsibility.
- [ ] Identify its owner.
- [ ] Determine whether it is source, packaging, configuration, provisioning, delivery, tooling, data, or documentation.
- [ ] Search for another artifact with the same responsibility.
- [ ] Determine whether duplication is intentional.
- [ ] Determine the canonical source before deleting anything.

During migration:

- [ ] Move one responsibility at a time.
- [ ] Preserve runnable states where practical.
- [ ] Update references immediately.
- [ ] Update Make targets.
- [ ] Update CI paths.
- [ ] Update Docker build contexts.
- [ ] Update Kustomize references.
- [ ] Update Terraform references.
- [ ] Update GitOps paths.
- [ ] Update documentation.

After each migration unit:

- [ ] Local development works.
- [ ] Tests work.
- [ ] Images build.
- [ ] Compose works.
- [ ] Local Kubernetes works where required.
- [ ] CI works.
- [ ] Kustomize builds successfully.
- [ ] Terraform/Pulumi validation works.
- [ ] No secret has entered Git history.
- [ ] No stale path remains.
- [ ] Documentation matches reality.

---

# 50. Migration Order

Prefer migrating from conceptual boundaries toward implementation details.

## Phase 1 — Applications

- [ ] Establish `apps/`.
- [ ] Establish `apps/services/`.
- [ ] Establish `apps/web/`.
- [ ] Establish `apps/mobile/` if currently justified.
- [ ] Move server-side application(s).
- [ ] Move web application(s).
- [ ] Move mobile application(s).
- [ ] Move application-specific Dockerfiles with their applications.

## Phase 2 — Local Runtime

- [ ] Establish `infra/local/`.
- [ ] Move Compose orchestration.
- [ ] Move local Kubernetes.
- [ ] Remove obsolete `infra/runtime/containers/` ownership.
- [ ] Reconcile local Kubernetes duplication.

## Phase 3 — Delivery

- [ ] Establish canonical workload manifests.
- [ ] Establish bases.
- [ ] Establish only required overlays.
- [ ] Consolidate GitOps definitions.
- [ ] Remove duplicate workload manifests.

## Phase 4 — Platform

- [ ] Separate controllers from workloads.
- [ ] Separate networking capabilities.
- [ ] Separate security capabilities.
- [ ] Separate observability/telemetry.
- [ ] Validate ownership of Argo CD, ingress, cert-manager, external-dns, etc.

## Phase 5 — Provisioning

- [ ] Review Terraform module boundaries.
- [ ] Separate reusable modules from compositions.
- [ ] Validate `nonprod` vs `prod` grouping.
- [ ] Keep cloud provisioning independent from workload delivery.

## Phase 6 — Configuration & Environments

- [ ] Inventory every `.env`.
- [ ] Inventory every secret.
- [ ] Inventory every configuration value.
- [ ] Classify each as:
  - [ ] safe default
  - [ ] committed environment config
  - [ ] secret reference
  - [ ] actual secret
- [ ] Remove actual secrets from repository-managed structures.
- [ ] Define external secret ownership.
- [ ] Define environment composition.
- [ ] Remove duplicated environment configuration.

## Phase 7 — Tooling

- [ ] Consolidate scripts.
- [ ] Establish root developer interface.
- [ ] Simplify Makefile.
- [ ] Remove obsolete scripts.
- [ ] Document operational commands.

## Phase 8 — Documentation

- [ ] Update architecture docs.
- [ ] Create/update ADRs.
- [ ] Update root README.
- [ ] Document application boundaries.
- [ ] Document deployment lifecycle.
- [ ] Document environment model.
- [ ] Document secret-management model.

---

# 51. Final Architecture Validation

Before considering the migration complete, answer YES to these questions.

## Applications

- [ ] Can I identify every executable application from `apps/`?
- [ ] Can I understand its target without knowing its programming language?
- [ ] Are product capabilities separated from execution categories?
- [ ] Are domain boundaries independent from deployment boundaries?

## Packaging

- [ ] Does each application own its packaging recipe?
- [ ] Can the same built artifact be promoted across environments?
- [ ] Are images free from environment-specific secrets?

## Infrastructure

- [ ] Is provisioning clearly separated from delivery?
- [ ] Is platform infrastructure clearly separated from user workloads?
- [ ] Is local orchestration clearly separated from production delivery?
- [ ] Is Kubernetes configuration canonical rather than duplicated?

## Environments

- [ ] Can I explain the difference between local, development, test, CI, QA, staging, and production?
- [ ] Are only actually required environments represented?
- [ ] Are environment differences configuration-driven rather than source-code-driven?

## Secrets

- [ ] Are actual secrets external to Git?
- [ ] Is ownership clear?
- [ ] Is consumption controlled through least privilege?
- [ ] Can credentials rotate without rebuilding application artifacts?

## Repository Strategy

- [ ] Does the monorepo currently improve atomicity and developer experience?
- [ ] Have submodules been avoided unless source composition is explicitly required?
- [ ] Can future independent products be extracted without redefining the entire taxonomy?
- [ ] Can platform composition eventually pin released artifacts rather than source commits?

## Operations

- [ ] Can a new developer discover how to run the system?
- [ ] Can a QA engineer discover how to configure the QA environment without receiving secrets through Git?
- [ ] Can an operator identify what version of every application is deployed?
- [ ] Can the platform reproduce a known-good composition?

---

# 52. Architecture Invariants

These rules should remain true after the migration.

- [ ] **Architecture before technology.**
- [ ] **Responsibility before framework.**
- [ ] **Domain boundary != deployment boundary.**
- [ ] **Service != HTTP API.**
- [ ] **Microservice != small service.**
- [ ] **Local != development.**
- [ ] **Test != permanent environment.**
- [ ] **CI != deployment environment.**
- [ ] **Environment promotion != deployment strategy.**
- [ ] **Application packaging != infrastructure provisioning.**
- [ ] **Platform capability != application workload.**
- [ ] **Secret reference != secret value.**
- [ ] **Repository boundary != deployment boundary.**
- [ ] **Monorepo != monolith.**
- [ ] **Multiple deployables do not require multiple repositories.**
- [ ] **Git submodules are a source-composition mechanism, not the default modularity mechanism.**
- [ ] **Runtime composition should prefer immutable versioned artifacts.**
- [ ] **Build once, configure at runtime, promote the same artifact.**
- [ ] **External execution does not eliminate internal accountability.**
- [ ] **DRY should reduce divergence, not reduce clarity.**
- [ ] **Directories should express intent, not implementation accidents.**

---

# 53. North Star

The repository should be capable of evolving from:

    one repository
    one product
    several applications
    shared infrastructure

into:

    multiple products
    independently versioned artifacts
    shared platform capabilities
    controlled environments
    reproducible deployments

without requiring the conceptual architecture to be rewritten.

Target relationship:

                         PLATFORM
                            │
          ┌─────────────────┼─────────────────┐
          │                 │                 │
        APPS             PACKAGES          DATA
          │
          ▼
    VERSIONED ARTIFACTS
          │
          ▼
        DELIVERY
          │
          ├────────────── CONFIGURATION
          │
          ├────────────── SECRETS
          │
          ▼
       PLATFORM
      CAPABILITIES
          │
          ▼
      PROVISIONED
    INFRASTRUCTURE

while:

    TOOLING
       │
       └── provides the developer/operator interface

    DOCUMENTATION
       │
       └── explains architecture, decisions, and operation

And the central rule remains:

    APPLICATIONS define what the product does.

    PACKAGING defines how application source becomes an artifact.

    CONFIGURATION defines how that artifact behaves in an environment.

    DELIVERY defines how that artifact reaches an environment.

    PLATFORM defines the shared capabilities available to workloads.

    PROVISIONING defines the infrastructure on which the platform exists.

    TOOLING defines how humans and automation operate the system.
