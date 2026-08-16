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

## Vendor-Neutral Contract

- The queue is an abstraction, not a product decision yet.
- The queue implementation must support durable enqueue/dequeue, retries, delayed delivery, and a failure path.
- Jobs must carry an idempotency key and enough metadata to reprocess safely.
- The worker must be able to ack, nack, retry, and time out jobs without coupling the app to a specific broker API.
- Media jobs may be split into separate task classes later, but they share the same contract shape.

### Boundary Recommendation

- Keep user-facing chat responses inline for now.
- Use a single queue for content and media jobs for now.
- Split queues later only if different workloads create contention or need separate scaling.
- Move to async chat replies only if the product later needs long-running response generation or deferred delivery.

### Media Upload Recommendation

- Use presigned/direct-to-storage uploads for media.
- Keep the backend responsible for metadata, authorization, and job creation.
- Avoid proxying large binaries through Django unless a future edge case proves it necessary.

## Media Pipeline Contract

- Use AWS S3 as the target object store.
- Keep original uploads and derived artifacts in object storage, not in the cluster.
- Track every asset in the database with a stable id, owner, type, object key, checksum, size, status, and timestamps.
- Support images, audio, and documents from day one with the same lifecycle and type-specific derived outputs.
- Use `pending_upload`, `uploaded`, `processing`, `ready`, and `failed` as the asset states.
- Make processing jobs idempotent per asset and derivative.
- Treat upload completion as a separate backend confirmation before enqueuing processing.
- Validate mime type, size, and checksum before producing derivatives.
- Generate thumbnails or previews only when the asset type benefits from them.
- Store processed outputs back in object storage and update the asset record atomically.

## Operational Safety Contract

- Record terminal failure reasons on the asset/job so operators can see why processing stopped.
- Use a dead-letter or failure path for exhausted retries.
- Emit metrics for queue depth, job age, retry count, success/failure rate, and processing latency.
- Reconcile stale `pending_upload` or orphaned temporary assets with a periodic cleanup job.
- Keep temporary artifacts short-lived and purge them after a TTL.
- Make operational alerts actionable by tying them to the asset id and processing step.

## Execution Checklist

- [ ] Define the async job boundary.
  - [ ] List which chat events create jobs.
  - [ ] List which jobs stay inline.
  - [ ] Define job retry and timeout policy.
- [ ] Define the worker runtime.
  - [x] Choose the worker image and command.
  - [x] Define worker resources and autoscaling posture.
  - [x] Define worker environment variables and secrets.
- [x] Define the media pipeline.
  - [x] Choose object storage for uploads and processed assets.
  - [x] Define how uploads are accepted, stored, and referenced.
  - [x] Define thumbnail, preview, and validation steps if needed.
  - [x] Define how audio/image/document processing jobs are queued and retried.
- [x] Define operational safety.
  - [x] Define dead-letter or failure handling if needed.
  - [x] Define observability for job health and media processing.
  - [x] Define cleanup rules for temporary artifacts.
- [ ] Remove legacy provider-specific worker artifacts from the active migration path.
  - [ ] Retire the legacy background worker as an active resource.
  - [ ] Remove the legacy worker component tree.

## Notes

- This document covers both workers and the media pipeline because they are coupled in the chat use case.
- The queue choice stays open until we need a concrete broker; the contract only requires durable retries and failure handling.
- If the workload becomes mostly scheduled rather than event-driven, split out a separate `CronJob`-focused subtask later.
