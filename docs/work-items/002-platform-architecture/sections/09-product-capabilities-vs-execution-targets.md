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

- [ ] Keep this distinction explicit during migration.


## Criteria

- Apply with [0. Core Principles](./00-core-principles.md) and [1. Target Repository Model](./01-target-repository-model.md).
