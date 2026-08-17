# 17. `infra/provisioning/`

## Responsibility

Provision external infrastructure/resources.

Examples:

- AWS accounts
- VPCs
- subnets
- EKS
- ECS
- RDS
- ECR
- IAM
- KMS
- DNS infrastructure
- cloud-level policies

## Potential Structure

```text
infra/provisioning/
└── aws/
    ├── modules/
    ├── shared/
    ├── nonprod/
    └── prod/
```

- [ ] Terraform/Pulumi/etc. belong here when provisioning external resources.
- [ ] Keep reusable provisioning modules separate from environment composition.
- [ ] Avoid mixing Kubernetes workload manifests with cloud provisioning.
