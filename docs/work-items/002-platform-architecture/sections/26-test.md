# 26. Test

`test` primarily describes an **application/testing configuration**, not necessarily a permanently deployed infrastructure environment.

Examples:

```text
local tests
CI unit tests
CI integration tests
CI regression tests
```

- [ ] Do not automatically create a permanent `test` Kubernetes environment.
- [ ] Allow test configuration to run locally and inside CI.
- [ ] Treat ephemeral CI environments separately from persistent environments.
