---
id: 012-background-jobs
aliases: []
tags: []
created_at: 2026-08-14T00:00:00Z
status: draft
updated_at: 2026-08-14T00:00:00Z
---

# Subtask: Background Jobs and Media Pipeline

## Goal

Define how asynchronous jobs and media processing work in the AWS/EKS architecture.

## Source Material Extracted From Legacy Provider

- `name` becomes the worker naming convention.
- `start_command` becomes the worker container command/entrypoint.
- `env_vars` becomes the worker runtime config.
- `build_command` belongs in CI, not in the worker runtime layer.

## Recommendation

- Use a dedicated Kubernetes `Deployment` for long-running background workers.
- Use `CronJob` for scheduled tasks.
- Keep request-bound work inside the main application services.
- Store media in AWS-managed object storage rather than inside the cluster.
- Push image/audio/document processing through the worker pipeline asynchronously.

## Execution Checklist

- [ ] Define the async job boundary.
  - [ ] List which chat events create jobs.
  - [ ] List which jobs stay inline.
  - [ ] Define job retry and timeout policy.
- [ ] Define the worker runtime.
  - [ ] Choose the worker image and command.
  - [ ] Define worker resources and autoscaling posture.
  - [ ] Define worker environment variables and secrets.
- [ ] Define the media pipeline.
  - [ ] Choose object storage for uploads and processed assets.
  - [ ] Define how uploads are accepted, stored, and referenced.
  - [ ] Define thumbnail, preview, and validation steps if needed.
  - [ ] Define how audio/image/document processing jobs are queued and retried.
- [ ] Define operational safety.
  - [ ] Define dead-letter or failure handling if needed.
  - [ ] Define observability for job health and media processing.
  - [ ] Define cleanup rules for temporary artifacts.
- [ ] Remove legacy provider-specific worker artifacts from the active migration path.
  - [ ] Retire the legacy background worker as an active resource.
  - [ ] Remove the legacy worker component tree.

## Notes

- This document covers both workers and the media pipeline because they are coupled in the chat use case.
- If the workload becomes mostly scheduled rather than event-driven, split out a separate `CronJob`-focused subtask later.
