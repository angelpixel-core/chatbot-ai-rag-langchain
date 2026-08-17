# 18. `infra/platform/`

## Responsibility

Contains shared platform capabilities installed on top of provisioned infrastructure.

## Potential Structure

```text
infra/platform/
├── networking/
├── security/
├── observability/
└── controllers/
```

Possible capabilities:

- ingress controller
- cert-manager
- external-dns
- telemetry stack
- secret integration
- policy controllers
- GitOps controller

- [ ] Distinguish platform capabilities from user workloads.
- [ ] Distinguish platform configuration from underlying cloud provisioning.
