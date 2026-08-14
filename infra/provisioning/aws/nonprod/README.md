# Nonprod

AWS provisioning for QA and staging.

Terraform root scaffold for non-production AWS resources.

## Purpose

- Host all non-production environments.
- Keep QA and staging isolated from prod while sharing the same account boundary.

## Typical Contents

- Nonprod VPC and networking.
- Nonprod EKS cluster and node groups.
- Nonprod ECR access and policy wiring.
- QA and staging environment overlays or stacks.

## Notes

- QA and staging should remain distinguishable by namespace, stack, or environment variables.
- Production resources do not live here.

## Inputs

- `region`
- `account_id`
- `shared_account_id`
- `environment_names`
- `tags`

Start from `terraform.tfvars.example` and replace every `REPLACE_ME_*` placeholder with real values before planning.

The account ID variables validate as 12-digit AWS IDs, so the example file is documentation until real IDs are available.
