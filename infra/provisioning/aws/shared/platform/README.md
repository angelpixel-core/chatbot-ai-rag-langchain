# Shared Platform

Shared AWS bootstrap and platform tooling.

Terraform root scaffold for shared AWS bootstrap.

## Purpose

- Hold resources shared across nonprod and prod.
- Centralize common platform concerns that are not tied to one environment.

## Typical Contents

- Org/account bootstrap helpers.
- Shared IAM patterns.
- Shared DNS or platform-wide routing pieces.
- Common observability or GitOps bootstrap resources.
- Policy JSON files for SCP, IAM, and trust relationships.

## Notes

- Do not place environment-specific application resources here.
- Keep this folder small and explicit.

## Inputs

- `region`
- `shared_account_id`
- `shared_account_email`
- `nonprod_account_id`
- `nonprod_account_email`
- `prod_account_id`
- `prod_account_email`
- `tags`

Start from `terraform.tfvars.example` and replace every `REPLACE_ME_*` placeholder with real values before planning.

The account ID variables validate as 12-digit AWS IDs, so the example file is documentation until real IDs are available.
