# 43. Product Platform vs Internal Developer Platform

Keep the conceptual distinction.

## Product Platform

Represents:

```text
products
+ shared business capabilities
+ runtime composition
```

## Internal Developer Platform

Represents capabilities that help engineers build/run software:

```text
provisioning
delivery
observability
secrets integration
developer tooling
golden paths
environment management
```

- [ ] They may coexist in the same repository today.
- [ ] Do not assume they must become separate repositories.
- [ ] Preserve the conceptual boundary even when physically colocated.
