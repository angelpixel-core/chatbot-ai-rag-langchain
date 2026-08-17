# 53. North Star

The repository should be capable of evolving from:

```text
one repository
one product
several applications
shared infrastructure
```

into:

```text
multiple products
independently versioned artifacts
shared platform capabilities
controlled environments
reproducible deployments
```

without requiring the conceptual architecture to be rewritten.

## Target Relationship

```text
                         PLATFORM
                            │
          ┌─────────────────┼─────────────────┐
          │                 │                 │
        APPS             PACKAGES          DATA
          │
          ▼
    VERSIONED ARTIFACTS
          │
          ▼
        DELIVERY
          │
          ├────────────── CONFIGURATION
          │
          ├────────────── SECRETS
          │
          ▼
       PLATFORM
      CAPABILITIES
          │
          ▼
      PROVISIONED
    INFRASTRUCTURE
```

while:

```text
TOOLING
   │
   └── provides the developer/operator interface

DOCUMENTATION
   │
   └── explains architecture, decisions, and operation
```

## Central Rule

- APPLICATIONS define what the product does.
- PACKAGING defines how application source becomes an artifact.
- CONFIGURATION defines how that artifact behaves in an environment.
- DELIVERY defines how that artifact reaches an environment.
- PLATFORM defines the shared capabilities available to workloads.
- PROVISIONING defines the infrastructure on which the platform exists.
- TOOLING defines how humans and automation operate the system.
