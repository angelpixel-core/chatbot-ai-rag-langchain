# Platform Architecture

## Goal

Track the staged repository architecture migration for the platform repo.

## What Stays in the Mother Document

- `49. Migration-Specific Checks`
- `50. Migration Order`
- `51. Final Architecture Validation`
- `52. Architecture Invariants`
- `53. North Star`

## Extracted First

- `0. Core Principles` -> `sections/00-core-principles.md`
- `1. Target Repository Model` -> `sections/01-target-repository-model.md`

## Suggested Attack Order

1. Close the structural framing first: `0`, `1`.
2. Close the migration control rails: `49`, `50`, `51`, `52`, `53`.
3. Move through infrastructure boundaries: `16` to `21`.
4. Then validate duplication and environment modeling: `22` to `48`.
5. Leave application taxonomy details for last: `2` to `15`.

## Notes

- The root checklist is the working index.
- Individual sections will receive links later, after they are extracted into `sections/`.
- The appendix holds the target directory reference.
