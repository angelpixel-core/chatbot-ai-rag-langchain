# Shared Platform

Shared AWS bootstrap and platform tooling.

## Purpose

- Hold resources shared across nonprod and prod.
- Centralize common platform concerns that are not tied to one environment.

## Typical Contents

- Org/account bootstrap helpers.
- Shared IAM patterns.
- Shared DNS or platform-wide routing pieces.
- Common observability or GitOps bootstrap resources.

## Notes

- Do not place environment-specific application resources here.
- Keep this folder small and explicit.
