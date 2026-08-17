# 2. `apps/` — Executable Product Units

## Definition

`apps/` contains software units that provide executable product capabilities.

- [x] `apps/` represents executable software, not infrastructure.
- [x] Categorize applications primarily by **execution/interaction target**.
- [x] Do not categorize top-level applications primarily by programming language.
- [x] Do not use `api/` as the generic counterpart of `web/`.
- [x] Do not use `assistant/` as a top-level execution category.
- [x] Do not use `intelligence/` as a generic execution category.
- [x] Avoid using `core/` at this level unless it genuinely identifies a concrete product/application boundary.

Reason:

`API`, `assistant`, `intelligence`, and `core` describe interfaces,
capabilities, domains, or product concepts rather than where/how the
software executes.


## Criteria

- Apply with [0. Core Principles](./00-core-principles.md) and [1. Target Repository Model](./01-target-repository-model.md).
