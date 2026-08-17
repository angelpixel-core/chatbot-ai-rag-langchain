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

## Criteria

- Apply with [1. Target Repository Model](./01-target-repository-model.md) as the migration target.
