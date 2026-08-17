# 33. Kustomize Model

Prefer:

```text
base
└── overlays
    ├── local
    ├── development
    ├── qa
    ├── staging
    └── production
```

when each overlay is actually required.

Alternatively, infrastructure-level grouping may use:

```text
base
└── overlays
    ├── local
    ├── nonprod
    └── prod
```

only when differences genuinely exist at that grouping level.

- [ ] Do not create overlays merely to mirror environment names.
- [ ] Create overlays because configuration/resource topology differs.
- [ ] Prefer patches over copied manifests.
- [ ] Keep canonical definitions DRY.
- [ ] Avoid over-abstracting Kustomize solely to eliminate a few repeated lines.

DRY is subordinate to clarity.
