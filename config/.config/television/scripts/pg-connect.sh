#!/bin/bash
# Connect to a pg_service.conf entry in a new kitty tab
svc="$1"
host=$(yq -p ini -oy ".\"$svc\".host" ~/.pg_service.conf)
port=$(yq -p ini -oy ".\"$svc\".port" ~/.pg_service.conf)
db=$(yq -p ini -oy ".\"$svc\".dbname" ~/.pg_service.conf)
user=$(yq -p ini -oy ".\"$svc\".user" ~/.pg_service.conf)
dsn="postgres://$user:••••@$host:$port/$db"
kitty @ launch --type tab --tab-title "$dsn" --keep-focus pgcli "service=$svc" --less-chatty
