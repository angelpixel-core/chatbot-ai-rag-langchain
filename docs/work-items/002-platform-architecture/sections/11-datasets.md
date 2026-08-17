# 11. `datasets/`

- [ ] Keep datasets separate from executable applications.
- [ ] Distinguish source/reference datasets from generated runtime data.
- [ ] Do not commit sensitive production datasets.
- [ ] Document provenance and intended usage where appropriate.
- [ ] Keep AI/RAG datasets independent from a specific AI implementation when possible.

Example:

```text
datasets/
└── coffee-shop/
```

rather than hiding the dataset inside:

```text
apps/services/chatbot/
```

when the data represents platform/product knowledge rather than application source.
