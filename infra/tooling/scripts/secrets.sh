#!/usr/bin/env sh
set -eu

ACTION="${1:-}"
SECRET_ENV="${ENV:-${SECRET_ENV:-${STACK_ENV:-dev}}}"
TARGET="${TARGET:-}"
SECRET_NAME="${SECRET_NAME:-}"
SECRET_VALUE="${SECRET_VALUE:-}"

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
ROOT_DIR=$(CDPATH= cd -- "${SCRIPT_DIR}/../.." && pwd)
LOCAL_SECRET_DIR="${ROOT_DIR}/env/.local"
PLACEHOLDER_VALUE="__SET_MANUALLY__"

usage() {
  cat >&2 <<'EOF'
Usage: secrets.sh {init|set|get|list|validate}

Environment:
  ENV or SECRET_ENV      Secret environment to operate on (dev, test, qa, staging, prod)
  TARGET                 Destination: github or local
  SECRET_NAME            Optional single secret name to operate on
  SECRET_VALUE           Optional single secret value for set operations
  GITHUB_REPOSITORY      Optional repo slug override for GitHub targets
EOF
  exit 1
}

die() {
  echo "$*" >&2
  exit 1
}

require_command() {
  command -v "$1" >/dev/null 2>&1 || die "${1} is required"
}

validate_environment() {
  [ -n "$SECRET_ENV" ] || die "ENV is required"
  [ -d "${ROOT_DIR}/env/${SECRET_ENV}" ] || die "Unknown secret environment: ${SECRET_ENV}"
}

secret_files() {
  printf '%s\n' \
    "${ROOT_DIR}/env/${SECRET_ENV}/app/secrets.local.env" \
    "${ROOT_DIR}/env/${SECRET_ENV}/db/secrets.local.env" \
    "${ROOT_DIR}/env/${SECRET_ENV}/stack/secrets.local.env"
}

local_secret_file() {
  printf '%s\n' "${LOCAL_SECRET_DIR}/${SECRET_ENV}.env"
}

ensure_placeholder_file() {
  file="$1"
  case "$file" in
    */app/secrets.local.env)
      cat > "$file" <<EOF
RAILS_MASTER_KEY=${PLACEHOLDER_VALUE}
EOF
      ;;
    */db/secrets.local.env)
      case "$SECRET_ENV" in
        dev|test)
          cat > "$file" <<EOF
MYSQL_PASSWORD=${PLACEHOLDER_VALUE}
EOF
          ;;
        qa|staging|prod)
          cat > "$file" <<EOF
POSTGRES_PASSWORD=${PLACEHOLDER_VALUE}
EOF
          ;;
        *)
          cat > "$file" <<EOF
DATABASE_PASSWORD=${PLACEHOLDER_VALUE}
EOF
          ;;
      esac
      ;;
    */stack/secrets.local.env)
      cat > "$file" <<'EOF'
# Add stack-level secrets here when needed.
EOF
      ;;
    *)
      die "Unsupported secret file: $file"
      ;;
  esac
}

init_files() {
  for file in $(secret_files); do
    mkdir -p "$(dirname "$file")"
    [ -f "$file" ] || ensure_placeholder_file "$file"
  done
  mkdir -p "$LOCAL_SECRET_DIR"
  [ -f "$(local_secret_file)" ] || : > "$(local_secret_file)"
  echo "Initialized secret files for ${SECRET_ENV}"
}

source_entries() {
  for file in $(secret_files); do
    [ -f "$file" ] || continue
    while IFS= read -r line || [ -n "$line" ]; do
      case "$line" in
        ''|'#'*) continue ;;
      esac
      key=${line%%=*}
      value=${line#*=}
      printf '%s\t%s\t%s\n' "$file" "$key" "$value"
    done < "$file"
  done
}

source_file_for_key() {
  key="$1"
  for file in $(secret_files); do
    [ -f "$file" ] || continue
    while IFS= read -r line || [ -n "$line" ]; do
      case "$line" in
        ''|'#'*) continue ;;
      esac
      current_key=${line%%=*}
      [ "$current_key" = "$key" ] && {
        printf '%s\n' "$file"
        return 0
      }
    done < "$file"
  done
  return 1
}

source_value_for_key() {
  key="$1"
  file=$(source_file_for_key "$key") || return 1
  while IFS= read -r line || [ -n "$line" ]; do
    case "$line" in
      ''|'#'*) continue ;;
    esac
    current_key=${line%%=*}
    current_value=${line#*=}
    [ "$current_key" = "$key" ] || continue
    printf '%s\n' "$current_value"
    return 0
  done < "$file"
  return 1
}

source_has_placeholder_value() {
  value="$1"
  [ "$value" = "$PLACEHOLDER_VALUE" ]
}

require_secret_value() {
  key="$1"
  value="$2"
  if source_has_placeholder_value "$value"; then
    die "Secret ${key} in env/${SECRET_ENV} is still a placeholder"
  fi
}

local_required_keys() {
  case "$SECRET_ENV" in
    dev|test) printf '%s\n' "RAILS_MASTER_KEY" "MYSQL_PASSWORD" ;;
    qa|staging|prod) printf '%s\n' "RAILS_MASTER_KEY" "POSTGRES_PASSWORD" ;;
    *) die "Unknown secret environment: ${SECRET_ENV}" ;;
  esac
}

local_value_for_key() {
  key="$1"
  file="$(local_secret_file)"
  [ -f "$file" ] || return 1
  while IFS= read -r line || [ -n "$line" ]; do
    case "$line" in
      ''|'#'*) continue ;;
    esac
    current_key=${line%%=*}
    current_value=${line#*=}
    [ "$current_key" = "$key" ] || continue
    printf '%s\n' "$current_value"
    return 0
  done < "$file"
  return 1
}

local_value_from_env() {
  key="$1"
  case "$key" in
    RAILS_MASTER_KEY) printf '%s\n' "${RAILS_MASTER_KEY:-}" ;;
    MYSQL_PASSWORD) printf '%s\n' "${MYSQL_PASSWORD:-}" ;;
    POSTGRES_PASSWORD) printf '%s\n' "${POSTGRES_PASSWORD:-}" ;;
    DATABASE_PASSWORD) printf '%s\n' "${DATABASE_PASSWORD:-}" ;;
    *) die "Unsupported local secret: ${key}" ;;
  esac
}

local_upsert() {
  key="$1"
  value="$2"
  file="$(local_secret_file)"
  mkdir -p "$(dirname "$file")"
  [ -f "$file" ] || : > "$file"
  tmp_file="$(mktemp)"
  found=0
  while IFS= read -r line || [ -n "$line" ]; do
    case "$line" in
      ''|'#'*)
        printf '%s\n' "$line" >> "$tmp_file"
        ;;
      "$key"=*)
        if [ "$found" -eq 0 ]; then
          printf '%s=%s\n' "$key" "$value" >> "$tmp_file"
          found=1
        fi
        ;;
      *)
        printf '%s\n' "$line" >> "$tmp_file"
        ;;
    esac
  done < "$file"
  if [ "$found" -eq 0 ]; then
    printf '%s=%s\n' "$key" "$value" >> "$tmp_file"
  fi
  mv "$tmp_file" "$file"
}

get_github_repo() {
  if [ -n "${GITHUB_REPOSITORY:-}" ]; then
    printf '%s\n' "$GITHUB_REPOSITORY"
    return 0
  fi

  origin_url=$(git -C "$ROOT_DIR" remote get-url origin 2>/dev/null || true)
  [ -n "$origin_url" ] || die "GITHUB_REPOSITORY is required when git remote origin is unavailable"

  case "$origin_url" in
    git@github.com:*)
      repo_part=${origin_url#git@github.com:}
      repo_part=${repo_part%.git}
      printf '%s\n' "$repo_part"
      ;;
    https://github.com/*)
      repo_part=${origin_url#https://github.com/}
      repo_part=${repo_part%.git}
      printf '%s\n' "$repo_part"
      ;;
    *)
      die "Unsupported origin URL for GitHub repo detection: ${origin_url}"
      ;;
  esac
}

github_list_names() {
  repo="$1"
  gh secret list --repo "$repo" --app actions --json name --jq '.[].name'
}

github_required_names() {
  printf '%s\n' \
    "RAILS_MASTER_KEY" \
    "MYSQL_PASSWORD" \
    "POSTGRES_PASSWORD" \
    "DATABASE_PASSWORD"
}

github_required_value() {
  case "$1" in
    RAILS_MASTER_KEY) printf '%s\n' "${RAILS_MASTER_KEY:-}" ;;
    MYSQL_PASSWORD) printf '%s\n' "${MYSQL_PASSWORD:-}" ;;
    POSTGRES_PASSWORD) printf '%s\n' "${POSTGRES_PASSWORD:-}" ;;
    DATABASE_PASSWORD) printf '%s\n' "${DATABASE_PASSWORD:-}" ;;
    *) die "Unsupported GitHub secret: $1" ;;
  esac
}

github_secret_exists() {
  repo="$1"
  name="$2"
  found=0
  for existing in $(github_list_names "$repo"); do
    [ "$existing" = "$name" ] && found=1
  done
  [ "$found" -eq 1 ]
}

github_set_one() {
  repo="$1"
  name="$2"
  value="$3"
  gh secret set "$name" --repo "$repo" --app actions --body "$value" >/dev/null
}

github_get_one() {
  repo="$1"
  name="$2"
  if github_secret_exists "$repo" "$name"; then
    echo "${name}: present"
  else
    echo "${name}: missing"
    return 1
  fi
}

github_validate_one() {
  repo="$1"
  name="$2"
  github_secret_exists "$repo" "$name" >/dev/null 2>&1 || die "Missing GitHub secret: ${name}"
}

set_single_secret() {
  key="$1"
  value="$2"
  case "$TARGET" in
    github)
      require_command gh
      repo="$(get_github_repo)"
      github_set_one "$repo" "$key" "$value"
      ;;
    local)
      local_upsert "$key" "$value"
      ;;
    *)
      die "Unsupported target: $TARGET"
      ;;
  esac
}

set_bulk_secrets() {
  case "$TARGET" in
    github)
      require_command gh
      repo="$(get_github_repo)"
      found=0
      for key in $(github_required_names); do
        value="$(github_required_value "$key")"
        [ -n "$value" ] || continue
        github_set_one "$repo" "$key" "$value"
        found=1
      done
      [ "$found" -eq 1 ] || die "No GitHub secret values provided; use SECRET_NAME/SECRET_VALUE or export RAILS_MASTER_KEY/MYSQL_PASSWORD/POSTGRES_PASSWORD/DATABASE_PASSWORD"
      ;;
    local)
      file="$(local_secret_file)"
      [ -f "$file" ] || die "Missing local secret file: ${file}"
      if [ -n "$SECRET_NAME" ] && [ -n "$SECRET_VALUE" ]; then
        local_upsert "$SECRET_NAME" "$SECRET_VALUE"
      else
        for key in $(local_required_keys); do
          value="$(local_value_from_env "$key")"
          [ -n "$value" ] || die "${key} is required for local secrets"
          local_upsert "$key" "$value"
        done
      fi
      ;;
    *)
      die "Unsupported target: $TARGET"
      ;;
  esac
}

get_single_secret() {
  key="$1"
  case "$TARGET" in
    github)
      require_command gh
      repo="$(get_github_repo)"
      github_get_one "$repo" "$key"
      ;;
    local)
      local_value_for_key "$key" || die "Missing local secret: ${key}"
      ;;
    *)
      die "Unsupported target: $TARGET"
      ;;
  esac
}

get_bulk_secrets() {
  case "$TARGET" in
    github)
      require_command gh
      repo="$(get_github_repo)"
      github_list_names "$repo"
      ;;
    local)
      file="$(local_secret_file)"
      [ -f "$file" ] || die "Missing local secret file: ${file}"
      while IFS= read -r line || [ -n "$line" ]; do
        case "$line" in
          ''|'#'*) continue ;;
        esac
        printf '%s\n' "$line"
      done < "$file"
      ;;
    *)
      die "Unsupported target: $TARGET"
      ;;
  esac
}

validate_single_secret() {
  key="$1"
  case "$TARGET" in
    github)
      require_command gh
      repo="$(get_github_repo)"
      github_validate_one "$repo" "$key"
      ;;
    local)
      local_value="$(local_value_for_key "$key" || true)"
      require_secret_value "$key" "$local_value"
      ;;
    *)
      die "Unsupported target: $TARGET"
      ;;
  esac
}

validate_bulk_secrets() {
  case "$TARGET" in
    github)
      require_command gh
      repo="$(get_github_repo)"
      found=0
      for key in $(github_required_names); do
        value="$(github_required_value "$key")"
        [ -n "$value" ] || continue
        github_validate_one "$repo" "$key"
        found=1
      done
      [ "$found" -eq 1 ] || die "No GitHub secret names provided; use SECRET_NAME or export RAILS_MASTER_KEY/MYSQL_PASSWORD/POSTGRES_PASSWORD/DATABASE_PASSWORD"
      ;;
    local)
      file="$(local_secret_file)"
      [ -f "$file" ] || die "Missing local secret file: ${file}"
      for key in $(local_required_keys); do
        value="$(local_value_for_key "$key" || true)"
        [ -n "$value" ] || die "Missing local secret: ${key}"
        require_secret_value "$key" "$value"
      done
      ;;
    *)
      die "Unsupported target: $TARGET"
      ;;
  esac
}

case "$ACTION" in
  init)
    validate_environment
    init_files
    ;;
  set)
    validate_environment
    [ -n "$TARGET" ] || die "TARGET is required"
    if [ -n "$SECRET_NAME" ] && [ -n "$SECRET_VALUE" ]; then
      set_single_secret "$SECRET_NAME" "$SECRET_VALUE"
    else
      set_bulk_secrets
    fi
    ;;
  get)
    validate_environment
    [ -n "$TARGET" ] || die "TARGET is required"
    if [ -n "$SECRET_NAME" ]; then
      get_single_secret "$SECRET_NAME"
    else
      get_bulk_secrets
    fi
    ;;
  list)
    validate_environment
    [ -n "$TARGET" ] || die "TARGET is required"
    if [ -n "$SECRET_NAME" ]; then
      get_single_secret "$SECRET_NAME"
    else
      get_bulk_secrets
    fi
    ;;
  validate)
    validate_environment
    [ -n "$TARGET" ] || die "TARGET is required"
    if [ -n "$SECRET_NAME" ]; then
      validate_single_secret "$SECRET_NAME"
    else
      validate_bulk_secrets
    fi
    ;;
  *)
    usage
    ;;
esac
