# 5. `apps/mobile/`

## Definition

Contains applications targeting mobile/device ecosystems.

Potential future structure:

```text
apps/mobile/
├── ios/
│   └── <product>/
└── android/
    └── <product>/
```

- [ ] Organize by target platform when that distinction becomes meaningful.
- [ ] Allow multiple products under the same platform.
- [ ] Keep React Native/Kotlin/Swift/etc. as implementation choices rather than top-level architectural categories.
- [ ] Do not create `ios/` or `android/` prematurely if one cross-platform application is currently sufficient.


## Criteria

- Apply with [0. Core Principles](./00-core-principles.md) and [1. Target Repository Model](./01-target-repository-model.md).
