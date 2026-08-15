# Work Items

Index of tracked work-item docs.

## Migration Work Items

- `001-aws-eks-migration/`
  - `proposal.md` - migration intent, scope, and non-goals.
  - `design.md` - target architecture, decisions, and open questions.
  - `implementation-plan.md` - ordered phases and exit criteria for delivery.
  - `subtasks/account-strategy.md` - AWS account boundaries, ownership, and naming model.
  - `subtasks/network-layout.md` - VPC, subnet, CIDR, NAT, and DNS layout per account.
  - `subtasks/vpc-layout.md` - concrete VPC layout and Terraform shape per account.
  - `subtasks/prepare-iam-cluster-access.md` - human, CI/CD, workload, and cluster access model.
  - `subtasks/provision-eks-base.md` - initial nonprod EKS cluster baseline and rollout plan.
  - `subtasks/deployment-service-ingress.md` - Kubernetes runtime/service/ingress boundary.
  - `subtasks/rds-postgresql.md` - AWS-managed PostgreSQL contract and migration path.
  - `subtasks/background-jobs.md` - async worker and media pipeline boundary.
  - `subtasks/environment-layout.md` - QA/staging/prod account and promotion layout.
  - `subtasks/aws-bootstrap-inputs.md` - required inputs and placeholder convention for AWS bootstrap.
  - `subtasks/aws-organizations-iam.md` - AWS Organizations, access, and guardrails.
  - `subtasks/identity-layer.md` - abstract identity model implemented with IAM Identity Center.
  - `subtasks/remocion-de-render.md` - Render reuse/adaptation/retirement matrix.
