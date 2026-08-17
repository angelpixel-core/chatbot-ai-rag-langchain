# 14. Secrets

## Hard Rules

- [ ] Never commit real secrets.
- [ ] Never store production secrets in `.env` files tracked by Git.
- [ ] Never embed secrets into Docker images.
- [ ] Never embed secrets into Dockerfiles.
- [ ] Avoid exposing secrets through Docker build arguments.
- [ ] Never commit decrypted Rails credentials.
- [ ] Never commit cloud provider credentials.

## Repository Material

Repository may contain:

```text
.env.example
config.example
secrets.example
README instructions
secret references
```

but not secret values.

- [ ] Commit names/references/contracts for secrets.
- [ ] Keep actual values external.
