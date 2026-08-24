#!/usr/bin/env bash
set -euo pipefail

STATE="${1:-OK}"
case "$STATE" in
  OK) echo "OK - dummy"; exit 0 ;;
  WARNING) echo "WARNING - dummy"; exit 1 ;;
  CRITICAL) echo "CRITICAL - dummy"; exit 2 ;;
  UNKNOWN) echo "UNKNOWN - dummy"; exit 3 ;;
  *) echo "UNKNOWN - usage: $0 {OK|WARNING|CRITICAL|UNKNOWN}"; exit 3 ;;
esac
