# 1. Target Repository Model

Use this conceptual structure as the migration target:

```text
platform/
├── apps/
│   ├── services/
│   ├── web/
│   ├── mobile/
│   ├── desktop/
│   └── cli/
│
├── packages/
│   ├── contracts/
│   ├── clients/
│   ├── design-system/
│   └── shared/
│
├── datasets/
│
├── config/
│
├── infra/
│   ├── provisioning/
│   ├── platform/
│   ├── delivery/
│   └── local/
│
├── environments/
│
├── tooling/
│   ├── scripts/
│   ├── generators/
│   └── hooks/
│
├── docs/
│   ├── architecture/
│   ├── adr/
│   └── ...
│
├── Makefile
└── README.md
```

- [ ] Treat this tree as an architectural taxonomy rather than a mandatory list of directories.
- [ ] Create only directories currently justified by actual artifacts.
- [ ] Keep empty future categories out of the repository unless they improve navigation or communicate an imminent boundary.
