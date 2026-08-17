# 15. Secret Ownership

Distinguish:

```text
secret ownership
secret storage
secret consumption
```

Example:

```text
Payment credential
       │
       ▼
Security/Payments owner
       │
       ▼
     Vault
       │
       ▼
workload identity
       │
       ▼
payments service
```

- [ ] Define who owns each sensitive credential.
- [ ] Define which workload may consume it.
- [ ] Apply least privilege.
- [ ] Prefer workload identity over static global credentials.
- [ ] Allow services to read only required secrets.
- [ ] Avoid allowing applications to modify secrets unless explicitly required.
- [ ] Audit sensitive secret access where possible.
- [ ] Keep break-glass access exceptional and auditable.
