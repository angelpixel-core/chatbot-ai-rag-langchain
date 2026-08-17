# 13. Configuration

## Principle

Application configuration comes from the execution environment.

- [ ] Keep environment-independent defaults in application source where appropriate.
- [ ] Inject environment-specific values externally.
- [ ] Avoid environment branching scattered throughout application source.
- [ ] Avoid excessive `if production?`, `if staging?`, etc.
- [ ] Prefer explicit configuration inputs.
- [ ] Document every required configuration key.

Example committed artifact:

```text
config/
├── schema/
├── defaults/
└── examples/
```

Exact organization may evolve.
