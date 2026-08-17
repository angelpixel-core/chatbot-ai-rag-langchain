# Platform Architecture

## Goal

Track the staged repository architecture migration for the platform repo.

## Extracted First

- `0. Core Principles` -> `sections/00-core-principles.md`
- `1. Target Repository Model` -> `sections/01-target-repository-model.md`
- `49. Migration-Specific Checks` -> `sections/49-migration-specific-checks.md`
- `50. Migration Order` -> `sections/50-migration-order.md`
- `51. Final Architecture Validation` -> `sections/51-final-architecture-validation.md`
- `52. Architecture Invariants` -> `sections/52-architecture-invariants.md`
- `53. North Star` -> `sections/53-north-star.md`
- `16. infra/` -> `sections/16-infra.md`
- `17. infra/provisioning/` -> `sections/17-infra-provisioning.md`
- `18. infra/platform/` -> `sections/18-infra-platform.md`
- `19. infra/delivery/` -> `sections/19-infra-delivery.md`
- `20. infra/local/` -> `sections/20-infra-local.md`
- `21. Remove / Reconsider Current infra/runtime/` -> `sections/21-reconsider-infra-runtime.md`
- `22. Kubernetes Duplication` -> `sections/22-kubernetes-duplication.md`
- `23. Environment Taxonomy` -> `sections/23-environment-taxonomy.md`
- `24. Local` -> `sections/24-local.md`
- `25. Development` -> `sections/25-development.md`
- `26. Test` -> `sections/26-test.md`
- `27. CI` -> `sections/27-ci.md`
- `28. QA` -> `sections/28-qa.md`
- `29. Staging` -> `sections/29-staging.md`
- `30. Production` -> `sections/30-production.md`
- `31. Recommended Lifecycle Model` -> `sections/31-recommended-lifecycle-model.md`
- `32. nonprod vs Concrete Environments` -> `sections/32-nonprod-vs-concrete-environments.md`
- `33. Kustomize Model` -> `sections/33-kustomize-model.md`
- `34. Deployment Strategies` -> `sections/34-deployment-strategies.md`
- `35. environments/` -> `sections/35-environments.md`
- `36. tooling/` -> `sections/36-tooling.md`
- `37. Makefile` -> `sections/37-makefile.md`
- `38. Monorepo Decision` -> `sections/38-monorepo-decision.md`
- `39. When Repository Separation Becomes Appropriate` -> `sections/39-when-repository-separation-becomes-appropriate.md`
- `40. Git Submodules` -> `sections/40-git-submodules.md`
- `41. Prefer Artifact Composition Over Source Composition` -> `sections/41-prefer-artifact-composition-over-source-composition.md`
- `42. Platform Definition` -> `sections/42-platform-definition.md`
- `43. Product Platform vs Internal Developer Platform` -> `sections/43-product-platform-vs-internal-developer-platform.md`
- `44. Application Ownership` -> `sections/44-application-ownership.md`
- `45. External Integration Ownership` -> `sections/45-external-integration-ownership.md`
- `46. Technology Placement` -> `sections/46-technology-placement.md`
- `47. Technology Independence` -> `sections/47-technology-independence.md`
- `48. Documentation` -> `sections/48-documentation.md`
- `2. apps/ — Executable Product Units` -> `sections/02-apps-executable-product-units.md`
- `3. apps/services/` -> `sections/03-apps-services.md`
- `4. apps/web/` -> `sections/04-apps-web.md`
- `5. apps/mobile/` -> `sections/05-apps-mobile.md`
- `6. apps/desktop/` -> `sections/06-apps-desktop.md`
- `7. apps/cli/` -> `sections/07-apps-cli.md`
- `8. embedded/` -> `sections/08-embedded.md`
- `9. Product Capabilities vs Execution Targets` -> `sections/09-product-capabilities-vs-execution-targets.md`
- `10. packages/` -> `sections/10-packages.md`
- `11. datasets/` -> `sections/11-datasets.md`
- `12. Dockerfile Ownership` -> `sections/12-dockerfile-ownership.md`
- `13. Configuration` -> `sections/13-configuration.md`
- `14. Secrets` -> `sections/14-secrets.md`
- `15. Secret Ownership` -> `sections/15-secret-ownership.md`

## Suggested Attack Order

1. Close the structural framing first: `0`, `1`.
2. Close the migration control rails: `49`, `50`, `51`, `52`, `53`.
3. Move through infrastructure boundaries: `16` to `21`.
4. Then validate duplication and environment modeling: `22` to `48`.
5. Leave application taxonomy details for last: `2` to `15`.

## Notes

- The root checklist is the working index.
- Individual sections receive links only after they are extracted into `sections/`.
- The appendix holds the target directory reference.
- Every extracted section should end with a criteria reference back to `0` and `1`.
