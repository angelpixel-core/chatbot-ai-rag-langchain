---
id: 002-account-strategy
aliases: []
tags: []
created_at: 2026-08-14T00:00:00Z
status: draft
updated_at: 2026-08-14T00:00:00Z
---

# Subtask: AWS Account Strategy

## Goal

Define the AWS account boundaries and ownership model before network, cluster, and application provisioning.

## Recommendation

- Use `shared/platform` for central bootstrap, shared tooling, and platform-wide services.
- Use `nonprod` for QA and staging workloads.
- Use `prod` for production workloads only.
- Keep human access separate from CI/CD access.
- Keep `prod` the smallest and most restricted account.

## Account Boundaries

| Account | Purpose | Typical Contents | Access Scope |
| --- | --- | --- | --- |
| `shared/platform` | Bootstrap and shared platform services | Organizations bootstrap, IAM, DNS, audit, shared keys, shared tooling | Platform operators and controlled automation |
| `nonprod` | QA and staging | Non-production EKS, non-prod ECR usage, test data, preview workloads | Developers, deployers, platform operators |
| `prod` | Production | Production EKS, production data, production secrets, production ingress | Platform operators and tightly controlled deploy access |

## CI/CD Roles

- CI/CD deploy roles should be account-scoped.
- CI/CD should assume the minimum role needed in each account.
- Shared bootstrap roles belong in `shared/platform`.
- Workload deploy roles belong in `nonprod` and `prod` as separate targets.

## Naming Conventions

- Keep account names stable and environment-aligned.
- Use `shared/platform`, `nonprod`, and `prod` consistently in docs, Terraform, and runtime config.
- Keep resource names prefixed or tagged with the account boundary when ambiguity is possible.

## Execution Checklist

- [x] Define the account split.
- [x] Define what belongs in `shared/platform`.
- [x] Define what belongs in `nonprod`.
- [x] Define what belongs in `prod`.
- [x] Define the CI/CD role model per account.
- [x] Define naming conventions for accounts and resources.
- [ ] Create the AWS accounts in Organizations.
- [ ] Validate the account strategy against live AWS credentials.

## Notes

- This subtask stays design-first until credentials are available.
- The account split is the foundation for the network and environment layout work that follows.
