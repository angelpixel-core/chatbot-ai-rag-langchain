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

## Non-Goals

- [ ] No application feature work.
- [ ] No immediate production cutover.
- [ ] No introduction of NestJS unless a separate Node backend concern is proven necessary.

## Outcome

- [x] The repo should end with a clear AWS target architecture.
- [x] The migration should be implementable in incremental steps.
- [x] Local Kubernetes should stay visible before production.
