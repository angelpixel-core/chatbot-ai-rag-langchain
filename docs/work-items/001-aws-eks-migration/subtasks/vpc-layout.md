---
id: vpc-layout
aliases: []
tags: []
created_at: 2026-08-14T00:00:00Z
status: draft
updated_at: 2026-08-14T00:00:00Z
---

# Subtask: VPC Layout

## Goal

Define the concrete AWS VPC layout per account before creating the actual VPCs.

## Recommendation

- Create one VPC per account.
- Keep `shared/platform`, `nonprod`, and `prod` fully isolated at the network boundary.
- Use public subnets for ingress and NAT.
- Use private app subnets for workloads.
- Use private data subnets for databases and stateful services.
- Keep Route53/DNS ownership explicit in the account that owns the network.

## Concrete VPC Layout

| Account | VPC CIDR | Public Subnets | Private App Subnets | Private Data Subnets |
| --- | --- | --- | --- | --- |
| `shared/platform` | `10.40.0.0/16` | `10.40.0.0/20`, `10.40.16.0/20` | `10.40.32.0/20`, `10.40.48.0/20` | `10.40.64.0/20`, `10.40.80.0/20` |
| `nonprod` | `10.41.0.0/16` | `10.41.0.0/20`, `10.41.16.0/20` | `10.41.32.0/20`, `10.41.48.0/20` | `10.41.64.0/20`, `10.41.80.0/20` |
| `prod` | `10.42.0.0/16` | `10.42.0.0/20`, `10.42.16.0/20` | `10.42.32.0/20`, `10.42.48.0/20` | `10.42.64.0/20`, `10.42.80.0/20` |

## Planned Resources

- one `aws_vpc` per account
- one `aws_internet_gateway` per account
- one `aws_eip` and `aws_nat_gateway` per account
- one public route table per account
- one private app route table per account
- one private data route table per account
- subnet associations for each route table
- tags for account, environment, and ownership

## Terraform Shape

- The reusable module should live at `infra/provisioning/aws/modules/network/vpc/`.
- Each account root should instantiate that module once.
- Each root should pass the account CIDR, subnet CIDRs, AZs, and tags.

## Module Responsibilities

| File | Responsibility |
| --- | --- |
| `versions.tf` | Terraform and provider constraints |
| `variables.tf` | Inputs for account, CIDR, AZs, subnet ranges, NAT, and tags |
| `locals.tf` | Naming, merged tags, and subnet maps |
| `vpc.tf` | `aws_vpc` and `aws_internet_gateway` |
| `subnets.tf` | Public, private app, and private data subnets |
| `routing.tf` | Route tables, routes, and associations |
| `nat.tf` | NAT gateway and private egress routing |
| `dns.tf` | DNS hooks or placeholders for future Route53 management |
| `outputs.tf` | VPC, subnet, route table, and NAT outputs |

## Root Responsibilities

- `shared/platform` instantiates the module for the shared bootstrap account.
- `nonprod` instantiates the module for QA/staging.
- `prod` instantiates the module for production.
- Each root passes the account CIDR, subnet CIDRs, region, and tags.

## Execution Checklist

- [x] Define the per-account VPC layout.
- [x] Define the subnet split per VPC.
- [x] Define the route table and NAT structure.
- [x] Define the module/file split for Terraform.
- [x] Define the root layout per account.
- [ ] Implement the module in Terraform.
- [ ] Instantiate the module in each account root.
- [ ] Validate the VPC layout against the reserved CIDR ranges.

## Notes

- This document describes the concrete VPC layout, not the live VPCs.
- Live AWS creation stays pending until credentials are available.
