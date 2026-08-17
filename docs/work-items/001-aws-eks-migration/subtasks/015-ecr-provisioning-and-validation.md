---
id: 015-ecr-provisioning-and-validation
aliases: []
tags: []
created_at: 2026-08-17T00:00:00Z
status: draft
updated_at: 2026-08-17T00:00:00Z
---

# Subtask: ECR Provisioning and Validation

## Goal

Provision ECR for the app images and validate the CI/CD publish and pull path with real AWS access.

## Recommendation

- Keep the repo layout aligned with the Django and Next.js image split.
- Validate the full image path: build, push, and pull.
- Confirm the CI/CD principal can publish without overbroad permissions.

## Execution Checklist

- [ ] Confirm the ECR repositories exist for `django` and `nextjs`.
- [ ] Define lifecycle and permission policies.
- [ ] Confirm image build and push flow into ECR.
- [ ] Confirm CI/CD can publish images.
- [ ] Validate push and pull from CI/CD.

## Notes

- If push or pull fails, check IAM permissions, repository policy, and tag naming first.
