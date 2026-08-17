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
