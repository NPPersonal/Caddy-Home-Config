#!/bin/bash

# Create directory data
mkdir -p ./data

# Move json-schema generated output .vscode directory under data directory
cp .vscode ./data/

# Change privileage of folder to read only for `group` and `other`
chmod -R 744 ./data

# Run caddy with config file
caddy run --config /app/configs/caddy_config.json