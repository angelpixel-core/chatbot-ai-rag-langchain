# 41. Prefer Artifact Composition Over Source Composition

For runtime/platform composition, prefer:

```text
product-a:1.8.3
product-b:3.2.1
product-c:0.9.0-beta
```

rather than requiring:

```text
git submodule product-a
git submodule product-b
git submodule product-c
```

where possible.

- [ ] Version application artifacts.
- [ ] Pin deployed versions.
- [ ] Keep source development independent from deployed platform composition.
- [ ] Allow a product to continue evolving while production remains pinned to a known-good version.

Example:

```text
product-a.git
    │
    ├── 1.8.3  ──────────────┐
    ├── 1.9.0                │
    └── 2.0-beta             │
                             ▼
platform.git
    product-a.image = 1.8.3
```

This gives independent evolution without requiring source composition.
