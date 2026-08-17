# AWS EKS Migration

## Goal

Track the AWS/EKS migration work for the platform repo.

## Status

- Most structure and design work is complete.
- The remaining work is grouped under credentialed validation and stays blocked until real AWS and cluster credentials are available.

## Open Work

### Credentialed Validation

This is the only active batch that still depends on real cloud credentials.

- [ ] Obtain real AWS/cluster credentials ([014-credentialed-access-validation](./subtasks/014-credentialed-access-validation.md))
- [ ] Create the AWS accounts in Organizations ([006-aws-organizations-iam](./subtasks/006-aws-organizations-iam.md), [014-credentialed-access-validation](./subtasks/014-credentialed-access-validation.md))
- [ ] Validate the account strategy against live AWS credentials ([002-account-strategy](./subtasks/002-account-strategy.md), [014-credentialed-access-validation](./subtasks/014-credentialed-access-validation.md))
- [ ] Validate the bootstrap model ([006-aws-organizations-iam](./subtasks/006-aws-organizations-iam.md), [014-credentialed-access-validation](./subtasks/014-credentialed-access-validation.md))
- [ ] Confirm human access to the cluster ([008-provision-eks-base](./subtasks/008-provision-eks-base.md), [014-credentialed-access-validation](./subtasks/014-credentialed-access-validation.md))
- [ ] Validate access from the local environment ([008-provision-eks-base](./subtasks/008-provision-eks-base.md), [014-credentialed-access-validation](./subtasks/014-credentialed-access-validation.md))
- [ ] Confirm network connectivity is functional ([008-provision-eks-base](./subtasks/008-provision-eks-base.md), [014-credentialed-access-validation](./subtasks/014-credentialed-access-validation.md))
- [ ] Confirm roles are isolated by account ([005-identity-layer](./subtasks/005-identity-layer.md), [006-aws-organizations-iam](./subtasks/006-aws-organizations-iam.md), [007-prepare-iam-cluster-access](./subtasks/007-prepare-iam-cluster-access.md), [014-credentialed-access-validation](./subtasks/014-credentialed-access-validation.md))
- [ ] Confirm image build and push flow into ECR ([015-ecr-provisioning-and-validation](./subtasks/015-ecr-provisioning-and-validation.md))
- [ ] Confirm CI/CD can publish images ([015-ecr-provisioning-and-validation](./subtasks/015-ecr-provisioning-and-validation.md))
- [ ] Validate push and pull from CI/CD ([015-ecr-provisioning-and-validation](./subtasks/015-ecr-provisioning-and-validation.md))
- [ ] Move PostgreSQL to RDS ([016-rds-secrets-cutover](./subtasks/016-rds-secrets-cutover.md), [011-rds-postgresql](./subtasks/011-rds-postgresql.md))
- [ ] Inject secrets from Secrets Manager and config from SSM Parameter Store ([016-rds-secrets-cutover](./subtasks/016-rds-secrets-cutover.md))
- [ ] Validate in QA, then staging, then production ([017-rollout-validation](./subtasks/017-rollout-validation.md))

## Reference

- [Implementation Plan](./implementation-plan.md)
- [Proposal](./proposal.md)
- [Design](./design.md)

## Notes

- `002-platform-architecture` has already been split into extracted sections.
- The cloud-side validation batch should be treated as blocked until real credentials are available.
