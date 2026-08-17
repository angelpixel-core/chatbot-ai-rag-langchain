# 35. `environments/`

This directory must not become a secret store.

Its purpose, if retained, should be **environment composition and configuration contracts**.

- [ ] Reassess current `infra/environments/`.
- [ ] Move environment concepts out of infrastructure subdomains when they apply across the whole platform.
- [ ] Keep only safe committed configuration.
- [ ] Keep `.example` / templates where needed.
- [ ] Keep documentation for acquiring/provisioning required secrets.
- [ ] Keep actual secret values external.

Potential conceptual form:

```text
environments/
├── development/
├── qa/
├── staging/
└── production/
```

but only if repository-level environment composition requires it.

- [ ] Avoid duplicating Kustomize overlays inside `environments/`.
- [ ] Avoid duplicating Terraform variables inside `environments/`.
- [ ] Prefer references/composition over copies.


## Criteria

- Apply with [0. Core Principles](./00-core-principles.md) and [1. Target Repository Model](./01-target-repository-model.md).
