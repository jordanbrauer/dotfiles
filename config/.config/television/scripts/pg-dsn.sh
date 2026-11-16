#!/bin/bash
# Copy full DSN for a pg_service.conf entry to clipboard
svc="$1"
host=$(yq -p ini -oy ".\"$svc\".host" ~/.pg_service.conf)
port=$(yq -p ini -oy ".\"$svc\".port" ~/.pg_service.conf)
db=$(yq -p ini -oy ".\"$svc\".dbname" ~/.pg_service.conf)
user=$(yq -p ini -oy ".\"$svc\".user" ~/.pg_service.conf)
echo -n "postgres://$user@$host:$port/$db" | pbcopy
