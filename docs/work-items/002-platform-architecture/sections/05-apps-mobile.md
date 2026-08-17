---
id: 05-apps-mobile
title: Apps Mobile
aliases: []
tags: []
work_item: 002-platform-architecture
status: draft
---

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


## Verification Checklist

- [x] No mobile application subtree exists yet.
- [x] Do not create `ios/` or `android/` prematurely if one cross-platform application is currently sufficient.
- [ ] Organize by target platform when that distinction becomes meaningful.
- [ ] Allow multiple products under the same platform.
- [ ] Keep React Native/Kotlin/Swift/etc. as implementation choices rather than top-level architectural categories.

## Criteria

- Apply with [0. Core Principles](./00-core-principles.md) and [1. Target Repository Model](./01-target-repository-model.md).
