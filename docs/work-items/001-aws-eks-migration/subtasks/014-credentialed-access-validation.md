---
id: 014-credentialed-access-validation
aliases: []
tags: []
created_at: 2026-08-17T00:00:00Z
status: draft
updated_at: 2026-08-17T00:00:00Z
---

# Subtask: Credentialed Access Validation

## Goal

Obtain real AWS and cluster credentials and use them to validate the access model end to end.

## Recommendation

- Treat this as the prerequisite for every remaining cloud-side validation step.
- Validate the account, role, and cluster access path before changing any infrastructure.
- Keep the first pass read-only where possible.

## Execution Checklist

- [ ] Obtain real AWS/cluster credentials.
- [ ] Create the AWS accounts in Organizations ([006-aws-organizations-iam](./006-aws-organizations-iam.md)).
- [ ] Validate the bootstrap model ([006-aws-organizations-iam](./006-aws-organizations-iam.md)).
- [ ] Confirm human access to the cluster ([008-provision-eks-base](./008-provision-eks-base.md)).
- [ ] Validate access from the local environment ([008-provision-eks-base](./008-provision-eks-base.md)).
- [ ] Confirm network connectivity is functional ([008-provision-eks-base](./008-provision-eks-base.md)).
- [ ] Confirm roles are isolated by account ([005-identity-layer](./005-identity-layer.md), [006-aws-organizations-iam](./006-aws-organizations-iam.md), [007-prepare-iam-cluster-access](./007-prepare-iam-cluster-access.md)).

## Notes

- This subtask should remain open until real credentials are available and the access path has been proven.
