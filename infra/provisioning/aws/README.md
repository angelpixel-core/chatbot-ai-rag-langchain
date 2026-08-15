# AWS Provisioning

AWS-first provisioning layout for the EKS migration.

## Structure

- `shared/platform/` for shared tooling and bootstrap resources.
- `nonprod/` for QA and staging.
- `prod/` for production.

## Current State

- These directories are Terraform root scaffolds for the AWS migration.
- `shared/platform` is the first bootstrap root.
- `nonprod` and `prod` currently capture the account/environment layout and will host their AWS resources next.

## Bootstrap Inputs

- AWS region
- shared/platform account ID
- nonprod account ID
- prod account ID
- owner/contact metadata
- tagging convention

Use the `terraform.tfvars.example` file in each root as the placeholder template before replacing values with real account data.

The account ID variables validate as 12-digit AWS IDs, so placeholder values are meant only for documentation until real values are available.

## Notes

- This tree replaces the legacy provisioning layout over time.
- Existing legacy provider components can be used as reference material when shaping the AWS modules and env layouts.
- Keep shared concerns in `shared/platform` and environment-specific concerns in `nonprod` or `prod`.
