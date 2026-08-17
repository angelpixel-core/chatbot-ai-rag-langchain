# 19. `infra/delivery/`

## Responsibility

Defines how application workloads are deployed/promoted.

## Potential Structure

```text
infra/delivery/
├── workloads/
└── environments/
```

- [ ] Application Kubernetes manifests belong to the delivery responsibility.
- [ ] GitOps definitions belong here.
- [ ] Argo CD application definitions belong here when used for delivery.
- [ ] Keep workload delivery separate from platform controllers.
- [ ] Avoid maintaining an independent second copy of the same Kubernetes workload under another directory.
