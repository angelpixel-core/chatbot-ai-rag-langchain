---
id: 003-network-layout
aliases: []
tags: []
created_at: 2026-08-14T00:00:00Z
status: draft
updated_at: 2026-08-14T00:00:00Z
---

# Subtask: Base Network Layout

## Goal

Define the base AWS network per account before EKS, RDS, and ingress provisioning.

## Recommendation

- Create one VPC per account.
- Keep `shared/platform`, `nonprod`, and `prod` network boundaries separate.
- Use public subnets for ingress and NAT, private subnets for workloads and databases.
- Reserve non-overlapping CIDR ranges up front.
- Keep DNS and naming aligned with the account boundary.

## Network Model

| Account | Network Role | Typical Use |
| --- | --- | --- |
| `shared/platform` | shared bootstrap network | platform tooling, shared services, audit and admin access paths |
| `nonprod` | non-production network | QA/staging EKS, test services, non-prod databases |
| `prod` | production network | production EKS, production databases, production ingress |

## CIDR Strategy

- Reserve one non-overlapping CIDR block per account.
- Prefer a simple, predictable split that leaves room for future subnets and expansion.
- Keep the chosen ranges documented before any VPC is created.

### Proposed CIDR Blocks

| Account | CIDR Block |
| --- | --- |
| `shared/platform` | `10.40.0.0/16` |
| `nonprod` | `10.41.0.0/16` |
| `prod` | `10.42.0.0/16` |

### Suggested Subnet Split per VPC

| Subnet Type | Example Range Pattern |
| --- | --- |
| public | `10.x.0.0/20`, `10.x.16.0/20` |
| private app | `10.x.32.0/20`, `10.x.48.0/20` |
| private data | `10.x.64.0/20`, `10.x.80.0/20` |

- This keeps enough space for EKS, RDS, and future expansion.
- If a later AWS boundary requires a different split, update the reserved ranges before creating the VPCs.

## DNS and Routing

- Public DNS should map to the ingress entrypoint for the correct account.
- Private DNS should stay account-scoped for internal services.
- Keep hostnames stable so promotion does not require renaming the application.

## Execution Checklist

- [x] Define one VPC per account.
- [x] Define public and private subnets.
- [x] Define NAT and egress paths.
- [x] Reserve non-overlapping CIDR ranges.
- [x] Define DNS and naming conventions.
- [ ] Create the VPCs in AWS.
- [ ] Validate routing and connectivity in live AWS.

## Notes

- This subtask is the foundation for EKS, RDS, and ingress routing.
- The actual VPC creation stays pending until AWS credentials are available.
