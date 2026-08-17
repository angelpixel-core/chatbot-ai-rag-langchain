---
id: 09-product-capabilities-vs-execution-targets
title: Product Capabilities vs Execution Targets
aliases: []
tags: []
work_item: 002-platform-architecture
status: draft
---

# 9. Product Capabilities vs Execution Targets

Avoid this:

```text
apps/
├── assistant/
├── intelligence/
├── api/
└── core/
```

when those names describe capabilities rather than execution targets.

Prefer:

```text
apps/
├── services/
│   └── chatbot/
└── web/
    └── chatbot/
```

Here:

```text
chatbot
```

is the product/capability.

While:

```text
services
web
```

describe execution/interaction categories.

- [x] Keep this distinction explicit during migration.


## Verification Checklist

- [x] The current repo structure uses `chatbot` as the product/capability name.
- [x] The current repo structure uses `services` and `web` as execution/interaction categories.
- [x] Confirmed against the current repository state.


## Criteria

- Apply with [0. Core Principles](./00-core-principles.md) and [1. Target Repository Model](./01-target-repository-model.md).
