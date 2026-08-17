# 37. Makefile

Treat the root Makefile as a **developer/platform interface**.

Examples conceptually:

```text
make setup
make dev
make test
make lint
make build
make local-up
make local-down
make k8s-up
make k8s-down
```

- [ ] Keep implementation complexity out of the Makefile.
- [ ] Delegate complex operations to scripts/tools.
- [ ] Use Make as a discoverable façade over common operations.
- [ ] Keep commands consistent across applications where practical.
