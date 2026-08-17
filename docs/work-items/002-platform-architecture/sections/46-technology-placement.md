# 46. Technology Placement

Technologies belong as implementation choices beneath architectural boundaries.

Good:

```text
apps/
├── services/
│   ├── core/        # Rails
│   └── chatbot/     # Python
├── web/
│   └── portal/      # Next.js
└── mobile/
    └── client/      # React Native
```

Avoid:

```text
apps/
├── ruby/
├── python/
├── typescript/
└── react/
```

- [ ] Architecture names the responsibility.
- [ ] Implementation selects the technology.
