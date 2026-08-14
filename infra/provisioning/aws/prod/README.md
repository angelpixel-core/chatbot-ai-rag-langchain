# Prod

AWS provisioning for production.

Terraform root scaffold for production AWS resources.

## Purpose

- Host the production environment in its own account.
- Keep prod isolated from nonprod by default.

## Typical Contents

- Prod VPC and networking.
- Prod EKS cluster and node groups.
- Prod ECR access and policy wiring.
- Prod-specific routing, secrets, and rollout settings.

## Notes

- Do not mix QA or staging resources into this account.
- Keep prod changes deliberate and tightly controlled.

## Inputs

- `region`
- `account_id`
- `shared_account_id`
- `tags`

Start from `terraform.tfvars.example` and replace every `REPLACE_ME_*` placeholder with real values before planning.

The account ID variables validate as 12-digit AWS IDs, so the example file is documentation until real IDs are available.
