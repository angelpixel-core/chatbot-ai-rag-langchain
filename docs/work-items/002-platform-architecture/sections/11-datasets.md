---
id: 11-datasets
title: Datasets
aliases: []
tags: []
work_item: 002-platform-architecture
status: draft
placeholder: false
---

# 11. `datasets/`

- [x] Keep datasets separate from executable applications.
- [x] Keep AI/RAG datasets independent from a specific AI implementation when possible.
- [ ] Distinguish source/reference datasets from generated runtime data.
- [ ] Do not commit sensitive production datasets.
- [ ] Document provenance and intended usage where appropriate.

Example:

```text
datasets/
└── coffee-shop/
    ├── README.md
    └── source/
        └── coffee-shop.txt
```

rather than hiding the dataset inside:

```text
apps/services/chatbot/
```

when the data represents platform/product knowledge rather than application source.

## Verification Checklist

- [x] The dataset lives outside `apps/services/chatbot/`.
- [x] The dataset has its own subtree under `datasets/coffee-shop/`.
- [x] The canonical source file remains plain text.
- [ ] Distinguish source/reference datasets from generated runtime data.
- [ ] Do not commit sensitive production datasets.
- [ ] Document provenance and intended usage where appropriate.


## Criteria

- Apply with [0. Core Principles](./00-core-principles.md) and [1. Target Repository Model](./01-target-repository-model.md).
