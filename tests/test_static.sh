#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

for file in \
  "$ROOT/nagios/nagios.cfg" \
  "$ROOT/nagios/objects/commands.cfg" \
  "$ROOT/nagios/objects/hosts.cfg" \
  "$ROOT/nrpe/nrpe.cfg" \
  "$ROOT/docker-compose.yml"; do
  [[ -s "$file" ]] || { echo "Missing or empty: $file" >&2; exit 1; }
done

bash -n "$ROOT/plugins/check_dummy.sh"
bash -n "$ROOT/scripts/add_host.sh"
bash -n "$ROOT/scripts/send_notify.sh"

for state in OK WARNING CRITICAL UNKNOWN; do
  set +e
  "$ROOT/plugins/check_dummy.sh" "$state" >/dev/null
  rc=$?
  set -e
  case "$state" in
    OK) [[ $rc -eq 0 ]] ;;
    WARNING) [[ $rc -eq 1 ]] ;;
    CRITICAL) [[ $rc -eq 2 ]] ;;
    UNKNOWN) [[ $rc -eq 3 ]] ;;
  esac
done

set +e
"$ROOT/scripts/add_host.sh" badname >/dev/null 2>&1
rc=$?
set -e
[[ $rc -eq 2 ]]

echo "Project 18 static tests passed."
