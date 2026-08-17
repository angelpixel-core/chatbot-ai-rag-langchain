# 4. `apps/web/`

## Definition

Contains applications whose primary interaction target is the Web.

Example:

```text
apps/web/
└── chatbot/
```

- [x] Organize first by product/application.
- [x] Put framework-specific implementation below the product boundary when useful.
- [x] Do not require every web application to use the same framework.
- [x] Allow Next.js, Rails, Django, Elixir, Rust, etc. where appropriate.
- [x] Treat `web` as an execution/interaction target, not as a JavaScript synonym.

Possible structure:

```text
apps/web/
└── chatbot/
    └── ...
```

rather than:

```text
apps/
└── nextjs/
```


## Verification Checklist

- [x] The current web app is nested under a product/application boundary (`apps/web/chatbot/`).
- [x] The framework-specific implementation lives below the product boundary.
- [x] Confirmed against the current repository state.

## Criteria

- Apply with [0. Core Principles](./00-core-principles.md) and [1. Target Repository Model](./01-target-repository-model.md).
