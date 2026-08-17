# Sections

One file per architecture section.

- Keep the section order aligned with `migration-checklist.md`.
- Add links from the checklist only after a section has been extracted.
- Every section file should include a criteria reference to `00-core-principles.md` and `01-target-repository-model.md`.
- Every section file should also include a `## Verification Checklist` that is used to confirm the section is still aligned with the repo state.

## Section Template

```md
# N. Section Title

## Definition

...section content...

## Verification Checklist

- [ ] Aligned with [0. Core Principles](./00-core-principles.md).
- [ ] Aligned with [1. Target Repository Model](./01-target-repository-model.md).
- [ ] Confirmed against the current repository state.

## Criteria

- Apply with [0. Core Principles](./00-core-principles.md) and [1. Target Repository Model](./01-target-repository-model.md).
```
