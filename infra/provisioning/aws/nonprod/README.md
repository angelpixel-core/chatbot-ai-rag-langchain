# Nonprod

AWS provisioning for QA and staging.

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
