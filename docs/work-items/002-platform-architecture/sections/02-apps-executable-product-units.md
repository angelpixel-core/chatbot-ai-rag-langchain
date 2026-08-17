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
