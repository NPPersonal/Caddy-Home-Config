#!/bin/bash

####
## UID GID which can be set in docker compose file in enviroment variable
## Default to 1000 for both
DEFAULT_UID=${HOST_UID:-1000}
DEFAULT_GID=${HOST_GID:-1000}

# New user's username
UNAME="appuser"

####
## Create a new user if not exists
## or modify existing user's UID and GID
if id $UNAME > /dev/null 2>&1; then
    echo "Change UID of $UNAME to $DEFAULT_UID"
    usermod -u "$DEFAULT_UID" "$UNAME"
    echo "Change GID of $UNAME to $DEFAULT_GID"
    groupmod -g "$DEFAULT_GID" "$UNAME"
else
    echo "User $UNAME not found, create a new user name:$UNAME with UID:$DEFAULT_UID and GID:$DEFAULT_GID"
    groupadd -g "$DEFAULT_GID" "$UNAME"
    useradd -m -u "$DEFAULT_UID" -g "$DEFAULT_GID" "$UNAME"
fi

# Create directory data under /app
mkdir -p ./data

# Move json-schema generated output .vscode directory under data directory
cp -rf .vscode ./data/

# Change /app directory of ownership to the new created user
chown -R appuser:appuser /app

# Make /app directory read-only and executable
chmod -R 555 /app

# Run caddy with config file
caddy run --config /app/configs/caddy_config.json