# Policies

Policy documents used by the shared platform bootstrap.

## Layout

- `scp/` - AWS Organizations service control policies.
- `iam/` - IAM permissions policies for roles.
- `trust/` - role trust policies for `sts:AssumeRole`.

## Notes

- Keep the JSON files as the source of truth for policy text.
- Terraform modules read these files directly with `file(...)`.
- Future environment-specific trust files can live here without changing the module wiring.
