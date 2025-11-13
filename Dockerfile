FROM caddy:2.10.2-builder-alpine AS builder

# Build with modules
# Add any customized module below
RUN xcaddy build \
    --with github.com/abiosoft/caddy-json-schema \
    --with github.com/mholt/caddy-l4 \
    --with github.com/mholt/caddy-grpc-web \
    --with github.com/caddy-dns/cloudflare \
    # Comment following 3 line will disable crowdsec module
    # Only comment them for development purpose
    --with github.com/hslatman/caddy-crowdsec-bouncer/http \
    --with github.com/hslatman/caddy-crowdsec-bouncer/layer4 \
    --with github.com/hslatman/caddy-crowdsec-bouncer/appsec \
    --with github.com/WeidiDeng/caddy-cloudflare-ip

FROM caddy:2.10.2-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# Set working directory
WORKDIR /app

# Copy configuration folder 
COPY ./configs ./configs

# Generate json-schema's intellisence folder which contain config files for visual studio code
# folder name will be `.vscode`
#
# At local development can use command `scp -r <Caddy_Remote_Host>:/app/.vscode <Local_Dev_Folder>`
# to copy configuration folder after the container is up and running 
RUN caddy json-schema --no-cache --vscode

# Change privileage of folder to read only for `group` and `other`
RUN chmod 744 .vscode

# Run caddy with config file
# Modify parameter after `--config` tp specify particular config file
CMD ["caddy", "run", "--config", "./configs/caddy_config.json"]

