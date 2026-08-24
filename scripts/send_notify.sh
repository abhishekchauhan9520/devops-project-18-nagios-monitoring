#!/usr/bin/env bash
set -euo pipefail

SUBJECT="${1:-}"
BODY="${2:-}"

if [[ -z "$SUBJECT" || -z "$BODY" ]]; then
  echo "Usage: $0 <subject> <body>" >&2
  exit 2
fi

printf 'Notification stub: %s\n%s\n' "$SUBJECT" "$BODY"
printf '%s\n' 'Integrate a vetted mail/webhook transport separately; do not commit secrets.'
