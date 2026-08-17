---
id: 10-packages
title: Packages
aliases: []
tags: []
work_item: 002-platform-architecture
status: draft
placeholder: true
---

# 10. `packages/`

## Definition

Contains reusable software artifacts that are not independently operated applications.

Potential structure:

```text
packages/
├── contracts/
├── clients/
├── design-system/
└── shared/
```

## `contracts/`

- [ ] Place shared interface/schema definitions here when appropriate.
- [ ] Examples may include OpenAPI schemas, protobuf definitions, event schemas, or shared DTO contracts.
- [ ] Avoid duplicating integration contracts across applications.

## `clients/`

- [ ] Place reusable service/provider clients here when genuinely shared.
- [ ] Avoid extracting a client library before multiple consumers justify it.

## `design-system/`

- [ ] Use for reusable UI primitives/design artifacts shared by multiple user interfaces.
- [ ] Do not create it merely because one web application has components.

## `shared/`

- [ ] Use sparingly.
- [ ] Do not turn `shared/` into an architectural junk drawer.
- [ ] Promote artifacts into more explicit categories when a clear responsibility emerges.


## Verification Checklist

- [x] No packages subtree exists yet.
- [x] Do not create `packages/` prematurely.
- [ ] Place shared interface/schema definitions here when appropriate.
- [ ] Place reusable service/provider clients here when genuinely shared.
- [ ] Use for reusable UI primitives/design artifacts shared by multiple user interfaces.
- [ ] Use sparingly.

## Criteria

- Apply with [0. Core Principles](./00-core-principles.md) and [1. Target Repository Model](./01-target-repository-model.md).
