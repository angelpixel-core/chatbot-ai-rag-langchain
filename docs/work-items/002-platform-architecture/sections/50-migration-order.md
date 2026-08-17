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


## Criteria

- Apply with [0. Core Principles](./00-core-principles.md) and [1. Target Repository Model](./01-target-repository-model.md).
