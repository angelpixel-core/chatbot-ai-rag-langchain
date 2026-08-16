# Tooling Scripts

Helpers used by the root `Makefile` and local operations.

## Convention

- Each script is a thin operational wrapper around one command family.
- The root `Makefile` should call these scripts and stay free of business logic.
- Scripts may validate env vars, derive paths, and invoke tools directly.
- Scripts should not reimplement provisioning or delivery logic.

## Adding New Commands

- Add the command to the root `Makefile` only if it is a user-facing entrypoint.
- Put the actual implementation in a script under `infra/tooling/scripts/` when it needs argument parsing or env validation.
- Keep the script focused on one tool family or one operational workflow.
- If the command needs Terraform, call Terraform in `infra/provisioning/aws/` instead of wrapping it in shell layers.
- If the command needs cluster reconciliation, put manifests in `infra/delivery/` and use shell only for bootstrap or validation.

## Commands

- `db.sh shell|logs`
- `eks.sh identity|kubeconfig|context|status|nodes|pods|verify`
- `stack.sh up|down|logs`
- `test.sh build|verify|pytest`
- `repo/create.sh`
- `secrets.sh`

## Mapping

- `db.sh` -> local database operations for Compose.
- `stack.sh` -> local Compose stack lifecycle.
- `eks.sh` -> live EKS inspection and kubeconfig helpers.
- `test.sh` -> containerized verification and pytest.
- `secrets.sh` -> secret file helpers.
- `repo/create.sh` -> repository bootstrap helpers.
