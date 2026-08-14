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
