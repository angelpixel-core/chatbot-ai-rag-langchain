# 4. `apps/web/`

## Definition

Contains applications whose primary interaction target is the Web.

Example:

```text
apps/web/
├── customer-portal/
├── admin-console/
└── chatbot/
```

- [ ] Organize first by product/application.
- [ ] Put framework-specific implementation below the product boundary when useful.
- [ ] Do not require every web application to use the same framework.
- [ ] Allow Next.js, Rails, Django, Elixir, Rust, etc. where appropriate.
- [ ] Treat `web` as an execution/interaction target, not as a JavaScript synonym.

Possible structure:

```text
apps/web/
└── customer-portal/
    └── ...
```

rather than:

```text
apps/
└── nextjs/
```
