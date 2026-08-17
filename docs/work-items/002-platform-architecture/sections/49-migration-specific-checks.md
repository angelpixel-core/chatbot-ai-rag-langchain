# 49. Migration-Specific Checks

Before moving any file:

- [ ] Identify its responsibility.
- [ ] Identify its owner.
- [ ] Determine whether it is source, packaging, configuration, provisioning, delivery, tooling, data, or documentation.
- [ ] Search for another artifact with the same responsibility.
- [ ] Determine whether duplication is intentional.
- [ ] Determine the canonical source before deleting anything.

During migration:

- [ ] Move one responsibility at a time.
- [ ] Preserve runnable states where practical.
- [ ] Update references immediately.
- [ ] Update Make targets.
- [ ] Update CI paths.
- [ ] Update Docker build contexts.
- [ ] Update Kustomize references.
- [ ] Update Terraform references.
- [ ] Update GitOps paths.
- [ ] Update documentation.

After each migration unit:

- [ ] Local development works.
- [ ] Tests work.
- [ ] Images build.
- [ ] Compose works.
- [ ] Local Kubernetes works where required.
- [ ] CI works.
- [ ] Kustomize builds successfully.
- [ ] Terraform/Pulumi validation works.
- [ ] No secret has entered Git history.
- [ ] No stale path remains.
- [ ] Documentation matches reality.
