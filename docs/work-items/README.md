# Work Items

Index of tracked work-item docs.

## Migration Work Items

- `001-aws-eks-migration/`
  - `proposal.md` - migration intent, scope, and non-goals.
  - `design.md` - target architecture, decisions, and open questions.
  - `implementation-plan.md` - ordered phases and exit criteria for delivery.
  - `subtasks/001-aws-bootstrap-inputs.md` - required inputs and placeholder convention for AWS bootstrap.
  - `subtasks/002-account-strategy.md` - AWS account boundaries, ownership, and naming model.
  - `subtasks/003-network-layout.md` - VPC, subnet, CIDR, NAT, and DNS layout per account.
  - `subtasks/004-vpc-layout.md` - concrete VPC layout and Terraform shape per account.
  - `subtasks/005-identity-layer.md` - abstract identity model implemented with IAM Identity Center.
  - `subtasks/006-aws-organizations-iam.md` - AWS Organizations, access, and guardrails.
  - `subtasks/007-prepare-iam-cluster-access.md` - human, CI/CD, workload, and cluster access model.
  - `subtasks/008-provision-eks-base.md` - initial nonprod EKS cluster baseline and rollout plan.
  - `subtasks/009-environment-layout.md` - QA/staging/prod account and promotion layout.
  - `subtasks/010-deployment-service-ingress.md` - Kubernetes runtime/service/ingress boundary.
  - `subtasks/011-rds-postgresql.md` - AWS-managed PostgreSQL contract and migration path.
  - `subtasks/012-background-jobs.md` - async worker and media pipeline boundary.
  - `subtasks/013-legacy-provisioning-retirement.md` - legacy provider reuse/adaptation/retirement matrix.
