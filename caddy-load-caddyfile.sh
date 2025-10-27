#!/bin/bash

# Check if .env file exists
if [ -f ./.env ]; then
    # export all variables from .env file
    set -a
    source .env
    set +a
else
    echo "ERROR: .env file not found!"
    exit 1
fi

response=$(curl -vsS $CADDY_HOST:$CADDY_API_PORT/load -H "Content-Type: $CADDY_CONTENT_TYPE_CADDYFILE" --data-binary @$CADDY_CONFIG_DIR/Caddyfile)
echo $response