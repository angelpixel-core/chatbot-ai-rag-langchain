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


## Criteria

- Apply with [0. Core Principles](./00-core-principles.md) and [1. Target Repository Model](./01-target-repository-model.md).
