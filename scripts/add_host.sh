#!/usr/bin/env bash
set -euo pipefail

NAME="${1:-}"
ADDR="${2:-}"

if [[ -z "$NAME" || -z "$ADDR" ]]; then
  echo "Usage: $0 <host_name> <ipv4_address>" >&2
  exit 2
fi

if [[ ! "$NAME" =~ ^[A-Za-z0-9._-]+$ ]]; then
  echo "Invalid host name" >&2
  exit 2
fi

if [[ ! "$ADDR" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
  echo "Invalid IPv4 address" >&2
  exit 2
fi

IFS=. read -r a b c d <<< "$ADDR"
for octet in "$a" "$b" "$c" "$d"; do
  ((octet <= 255)) || { echo "Invalid IPv4 address" >&2; exit 2; }
done

cat >> nagios/objects/hosts.cfg <<EOF

define host {
  use                     linux-server
  host_name               $NAME
  alias                   $NAME
  address                 $ADDR
}
EOF

echo "Added host $NAME at $ADDR. Validate Nagios configuration before reload."
