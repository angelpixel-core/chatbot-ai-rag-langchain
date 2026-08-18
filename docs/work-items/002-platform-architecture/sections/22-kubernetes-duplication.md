# 22. Kubernetes Duplication

Current migration must explicitly inspect:

```text
infra/delivery/user-apps/...
infra/local/kubernetes/...
```

- [ ] Determine whether manifests represent the same workloads.
- [ ] Identify duplicated:
  - [ ] namespaces
  - [ ] deployments
  - [ ] services
  - [ ] ingress
  - [ ] configuration
  - [ ] labels
  - [ ] resource definitions
- [ ] Establish one canonical workload definition where practical.
- [ ] Use overlays/patches rather than copying complete manifests.
- [ ] Keep local differences as overlays.
- [ ] Keep non-production differences as overlays.
- [ ] Keep production differences as overlays.
- [ ] Avoid divergent copies of the same workload definition.

## Conceptual Goal

```text
canonical workload
        │
  ┌────┼────┐
  ▼    ▼    ▼
local QA   prod
   overlays/config
```

rather than:

```text
local-copy/
qa-copy/
staging-copy/
production-copy/
```


## Criteria

- Apply with [0. Core Principles](./00-core-principles.md) and [1. Target Repository Model](./01-target-repository-model.md).
