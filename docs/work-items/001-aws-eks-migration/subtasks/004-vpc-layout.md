---
id: 004-vpc-layout
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

## Exact Terraform Resource Map

### Module Files

| File | Resources |
| --- | --- |
| `versions.tf` | provider and Terraform version constraints |
| `variables.tf` | module inputs only |
| `locals.tf` | name prefixes, tag merging, subnet maps, and route names |
| `vpc.tf` | `aws_vpc.this`, `aws_internet_gateway.this` |
| `subnets.tf` | `aws_subnet.public`, `aws_subnet.private_app`, `aws_subnet.private_data` |
| `routing.tf` | `aws_route_table.public`, `aws_route_table.private_app`, `aws_route_table.private_data`, `aws_route.*`, `aws_route_table_association.*` |
| `nat.tf` | `aws_eip.nat`, `aws_nat_gateway.this` |
| `dns.tf` | optional Route53 private zone hooks if the network owns DNS |
| `outputs.tf` | VPC and subnet IDs, route table IDs, IGW and NAT IDs |

### Root Files

| Root | File | Responsibility |
| --- | --- | --- |
| `shared/platform` | `main.tf` | instantiate the VPC module for shared/platform |
| `nonprod` | `main.tf` | instantiate the VPC module for nonprod |
| `prod` | `main.tf` | instantiate the VPC module for prod |

### Suggested Module Inputs

- `name`
- `region`
- `cidr_block`
- `azs`
- `public_subnet_cidrs`
- `private_app_subnet_cidrs`
- `private_data_subnet_cidrs`
- `enable_nat`
- `tags`

### Suggested Outputs

- `vpc_id`
- `public_subnet_ids`
- `private_app_subnet_ids`
- `private_data_subnet_ids`
- `route_table_ids`
- `internet_gateway_id`
- `nat_gateway_id`

## Execution Checklist

- [x] Define the per-account VPC layout.
- [x] Define the subnet split per VPC.
- [x] Define the route table and NAT structure.
- [x] Define the module/file split for Terraform.
- [x] Define the root layout per account.
- [x] Define the exact Terraform resource map.
- [x] Implement the module in Terraform.
- [x] Instantiate the module in each account root.
- [ ] Validate the VPC layout against the reserved CIDR ranges.

## Notes

- This document describes the concrete VPC layout, not the live VPCs.
- Live AWS creation stays pending until credentials are available.
