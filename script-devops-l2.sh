#!/usr/bin/env bash

set -eu

PASSWD_FILE="${1:-/etc/passwd}"

if [[ ! -r "$PASSWD_FILE" ]]; then
  echo "Error: file '$PASSWD_FILE' not found or not readable." >&2
  exit 2
fi

printf "%-20s %-6s %-6s %-30s\n" "USERNAME" "UID" "GID" "SHELL"
printf "%-20s %-6s %-6s %-30s\n" "--------" "---" "---" "-----"

while IFS=: read -r username password uid gid gecos home shell; do
  [[ -z "$username" || "${username:0:1}" == "#" ]] && continue

  if [[ "$shell" == *bash ]]; then
    printf "%-20s %-6s %-6s %-30s\n" "$username" "$uid" "$gid" "$shell"
  fi
done < "$PASSWD_FILE"
