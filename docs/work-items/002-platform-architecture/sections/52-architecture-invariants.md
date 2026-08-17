# 52. Architecture Invariants

These rules should remain true after the migration.

- [ ] **Architecture before technology.**
- [ ] **Responsibility before framework.**
- [ ] **Domain boundary != deployment boundary.**
- [ ] **Service != HTTP API.**
- [ ] **Microservice != small service.**
- [ ] **Local != development.**
- [ ] **Test != permanent environment.**
- [ ] **CI != deployment environment.**
- [ ] **Environment promotion != deployment strategy.**
- [ ] **Application packaging != infrastructure provisioning.**
- [ ] **Platform capability != application workload.**
- [ ] **Secret reference != secret value.**
- [ ] **Repository boundary != deployment boundary.**
- [ ] **Monorepo != monolith.**
- [ ] **Multiple deployables do not require multiple repositories.**
- [ ] **Git submodules are a source-composition mechanism, not the default modularity mechanism.**
- [ ] **Runtime composition should prefer immutable versioned artifacts.**
- [ ] **Build once, configure at runtime, promote the same artifact.**
- [ ] **External execution does not eliminate internal accountability.**
- [ ] **DRY should reduce divergence, not reduce clarity.**
- [ ] **Directories should express intent, not implementation accidents.**
