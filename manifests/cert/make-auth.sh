#!/bin/bash

# Get username and password from input
USER=$1
PASS=$2

if [ -z "$USER" ] || [ -z "$PASS" ]; then
  echo "Usage: $0 <username> <password>"
  exit 1
fi

# Check if htpasswd is installed
if ! command -v htpasswd &> /dev/null; then
  echo "htpasswd command not found. Install it first (apache2-utils or httpd-tools)."
  exit 1
fi

# Generate htpasswd line in memory (bcrypt by default)
LINE=$(htpasswd -nbB "$USER" "$PASS")

# Output base64 encoded string
echo -n "$LINE" | base64
