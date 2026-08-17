---
id: 07-apps-cli
title: Apps CLI
aliases: []
tags: []
work_item: 002-platform-architecture
status: draft
placeholder: true
---

# 7. `apps/cli/`

- [ ] Treat CLI programs as first-class executable applications when they have meaningful independent behavior.
- [ ] Do not hide substantial CLI products inside generic `scripts/`.
- [ ] Keep small operational helpers under `tooling/scripts/`.
- [ ] Distinguish product CLI from repository automation.

Rule of thumb:

```text
product-facing executable     -> apps/cli/
repository/platform helper    -> tooling/scripts/
```


## Verification Checklist

- [x] No CLI product subtree exists yet.
- [x] Small operational helpers remain under `tooling/scripts/`.
- [ ] Treat CLI programs as first-class executable applications when they have meaningful independent behavior.
- [ ] Do not hide substantial CLI products inside generic `scripts/`.
- [ ] Distinguish product CLI from repository automation.

## Criteria

- Apply with [0. Core Principles](./00-core-principles.md) and [1. Target Repository Model](./01-target-repository-model.md).
