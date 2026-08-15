---
id: proposal
aliases: []
tags: []
created_at: 2026-08-13T00:00:00Z
status: draft
updated_at: 2026-08-14T00:00:00Z
---

# Proposal: AWS EKS Migration

## Document Status

- [x] Proposal file renamed to `proposal.md`.
- [x] Frontmatter metadata added.
- [x] Work-item docs live under `docs/work-items/001-aws-eks-migration/`.

## Goal

- [x] Move the platform from the current Render-oriented deployment model to an AWS-first architecture.
- [x] Standardize the runtime around Kubernetes so local and production share the same orchestration model.
- [x] Run Django and Next.js as separate containerized services.

## Scope

- [x] Replace Render-specific infrastructure planning with AWS provisioning.
- [x] Define a Kubernetes-based local workflow that mirrors production.
- [x] Keep Django as the backend domain/API runtime.
- [x] Keep Next.js as a separate Node SSR service.
- [x] Add AWS-backed database, secrets, and networking foundations.

## Related Subtasks

- [001-aws-bootstrap-inputs](./subtasks/001-aws-bootstrap-inputs.md)
- [002-account-strategy](./subtasks/002-account-strategy.md)
- [003-network-layout](./subtasks/003-network-layout.md)
- [004-vpc-layout](./subtasks/004-vpc-layout.md)
- [005-identity-layer](./subtasks/005-identity-layer.md)
- [006-aws-organizations-iam](./subtasks/006-aws-organizations-iam.md)
- [007-prepare-iam-cluster-access](./subtasks/007-prepare-iam-cluster-access.md)
- [008-provision-eks-base](./subtasks/008-provision-eks-base.md)
- [009-environment-layout](./subtasks/009-environment-layout.md)
- [010-deployment-service-ingress](./subtasks/010-deployment-service-ingress.md)
- [011-rds-postgresql](./subtasks/011-rds-postgresql.md)
- [012-background-jobs](./subtasks/012-background-jobs.md)
- [013-remocion-de-render](./subtasks/013-remocion-de-render.md)

## Non-Goals

- [ ] No application feature work.
- [ ] No immediate production cutover.
- [ ] No introduction of NestJS unless a separate Node backend concern is proven necessary.

## Outcome

- [x] The repo should end with a clear AWS target architecture.
- [x] The migration should be implementable in incremental steps.
- [x] Local Kubernetes should stay visible before production.
