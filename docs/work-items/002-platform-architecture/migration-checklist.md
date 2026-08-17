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
- [ ] 2. `apps/` — Executable Product Units ([sections/02-apps-executable-product-units.md](sections/02-apps-executable-product-units.md))
- [ ] 3. `apps/services/` ([sections/03-apps-services.md](sections/03-apps-services.md))
- [ ] 4. `apps/web/` ([sections/04-apps-web.md](sections/04-apps-web.md))
- [ ] 5. `apps/mobile/` ([sections/05-apps-mobile.md](sections/05-apps-mobile.md))
- [ ] 6. `apps/desktop/` ([sections/06-apps-desktop.md](sections/06-apps-desktop.md))
- [ ] 7. `apps/cli/` ([sections/07-apps-cli.md](sections/07-apps-cli.md))
- [ ] 8. `embedded/` ([sections/08-embedded.md](sections/08-embedded.md))
- [ ] 9. Product Capabilities vs Execution Targets ([sections/09-product-capabilities-vs-execution-targets.md](sections/09-product-capabilities-vs-execution-targets.md))
- [ ] 10. `packages/` ([sections/10-packages.md](sections/10-packages.md))
- [ ] 11. `datasets/` ([sections/11-datasets.md](sections/11-datasets.md))
- [ ] 12. Dockerfile Ownership ([sections/12-dockerfile-ownership.md](sections/12-dockerfile-ownership.md))
- [ ] 13. Configuration ([sections/13-configuration.md](sections/13-configuration.md))
- [ ] 14. Secrets ([sections/14-secrets.md](sections/14-secrets.md))
- [ ] 15. Secret Ownership ([sections/15-secret-ownership.md](sections/15-secret-ownership.md))
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
- [ ] 31. Recommended Lifecycle Model ([sections/31-recommended-lifecycle-model.md](sections/31-recommended-lifecycle-model.md))
- [ ] 32. `nonprod` vs Concrete Environments ([sections/32-nonprod-vs-concrete-environments.md](sections/32-nonprod-vs-concrete-environments.md))
- [ ] 33. Kustomize Model ([sections/33-kustomize-model.md](sections/33-kustomize-model.md))
- [ ] 34. Deployment Strategies ([sections/34-deployment-strategies.md](sections/34-deployment-strategies.md))
- [ ] 35. `environments/` ([sections/35-environments.md](sections/35-environments.md))
- [ ] 36. `tooling/` ([sections/36-tooling.md](sections/36-tooling.md))
- [ ] 37. Makefile ([sections/37-makefile.md](sections/37-makefile.md))
- [ ] 38. Monorepo Decision ([sections/38-monorepo-decision.md](sections/38-monorepo-decision.md))
- [ ] 39. When Repository Separation Becomes Appropriate ([sections/39-when-repository-separation-becomes-appropriate.md](sections/39-when-repository-separation-becomes-appropriate.md))
- [ ] 40. Git Submodules ([sections/40-git-submodules.md](sections/40-git-submodules.md))
- [ ] 41. Prefer Artifact Composition Over Source Composition ([sections/41-prefer-artifact-composition-over-source-composition.md](sections/41-prefer-artifact-composition-over-source-composition.md))
- [ ] 42. Platform Definition ([sections/42-platform-definition.md](sections/42-platform-definition.md))
- [ ] 43. Product Platform vs Internal Developer Platform ([sections/43-product-platform-vs-internal-developer-platform.md](sections/43-product-platform-vs-internal-developer-platform.md))
- [ ] 44. Application Ownership ([sections/44-application-ownership.md](sections/44-application-ownership.md))
- [ ] 45. External Integration Ownership ([sections/45-external-integration-ownership.md](sections/45-external-integration-ownership.md))
- [ ] 46. Technology Placement ([sections/46-technology-placement.md](sections/46-technology-placement.md))
- [ ] 47. Technology Independence ([sections/47-technology-independence.md](sections/47-technology-independence.md))
- [ ] 48. Documentation ([sections/48-documentation.md](sections/48-documentation.md))
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

- See [`sections/02-apps-executable-product-units.md`](sections/02-apps-executable-product-units.md).

---

# 3. `apps/services/`

- See [`sections/03-apps-services.md`](sections/03-apps-services.md).

---

# 4. `apps/web/`

- See [`sections/04-apps-web.md`](sections/04-apps-web.md).

---

# 5. `apps/mobile/`

- See [`sections/05-apps-mobile.md`](sections/05-apps-mobile.md).

---

# 6. `apps/desktop/`

- See [`sections/06-apps-desktop.md`](sections/06-apps-desktop.md).

---

# 7. `apps/cli/`

- See [`sections/07-apps-cli.md`](sections/07-apps-cli.md).

---

# 8. `embedded/`

- See [`sections/08-embedded.md`](sections/08-embedded.md).

---

# 9. Product Capabilities vs Execution Targets

- See [`sections/09-product-capabilities-vs-execution-targets.md`](sections/09-product-capabilities-vs-execution-targets.md).

---

# 10. `packages/`

- See [`sections/10-packages.md`](sections/10-packages.md).

---

# 11. `datasets/`

- See [`sections/11-datasets.md`](sections/11-datasets.md).

---

# 12. Dockerfile Ownership

- See [`sections/12-dockerfile-ownership.md`](sections/12-dockerfile-ownership.md).

---

# 13. Configuration

- See [`sections/13-configuration.md`](sections/13-configuration.md).

---

# 14. Secrets

- See [`sections/14-secrets.md`](sections/14-secrets.md).

---

# 15. Secret Ownership

- See [`sections/15-secret-ownership.md`](sections/15-secret-ownership.md).

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
