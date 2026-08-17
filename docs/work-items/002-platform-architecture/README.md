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
