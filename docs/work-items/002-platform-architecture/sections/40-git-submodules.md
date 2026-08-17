# 40. Git Submodules

Git submodules are NOT the default architecture.

Use them only when source-level composition is intentionally required.

Potential legitimate future model:

```text
platform.git
└── apps/
    ├── product-a -> commit/tag X
    ├── product-b -> commit/tag Y
    └── product-c -> commit/tag Z
```

- [ ] Introduce submodules only when independent repositories already provide real value.
- [ ] Do not use submodules to simulate repository boundaries prematurely.
- [ ] Accept that cross-repository feature changes lose atomicity.
- [ ] Accept additional CI/developer tooling complexity.
- [ ] Document submodule update procedures if adopted.
