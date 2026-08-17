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


## Criteria

- Apply with [0. Core Principles](./00-core-principles.md) and [1. Target Repository Model](./01-target-repository-model.md).
