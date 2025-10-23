# Caddy reverse proxy config

This is configuration project for caddy reverse proxy at home

## Docker image

At home caddy is running through docker and the docker image was rebuilt in order to installed
some caddy modules.
The Dockerfile used to build the image is at `./Dockerfile`. Modify the Dockerfile to install more [caddy modules](https://caddyserver.com/docs/modules/).
The docker image can be found on docker hub https://hub.docker.com/r/tomneo2004/caddyx

## Modules

Installed modules for caddy.

- [caddy-json-schema](https://github.com/abiosoft/caddy-json-schema): for easy fast configuring caddy Json file with intellisense. `.vscode` folder is the setting files for visual studio code to enable intellisense when configuring caddy Json file.

- [caddy-l4](https://github.com/mholt/caddy-l4): support tcp/udp communication

### [caddy-json-schema](https://github.com/abiosoft/caddy-json-schema)

**Do not remove .vscode** folder as it is settings to enable intellisense for caddy Json configuration file in visual studio code.

## Usage

Open directory in editor [visual studio code](https://code.visualstudio.com/) is recommend becasue [caddy-json-schema](https://github.com/abiosoft/caddy-json-schema) module support configuring Json file with intellisense.

Pick an supported configuration file.

1. Modify configuration file.
2. Run shell script to tell caddy to reload configuration file through caddy admin api. **Make sure your caddy had exposed port 2019**, which is for caddy REST api.

### Configuration files

- Json confiugration file: `./config/caddy_config.json`
- Caddyfile configuration file: `./config/Caddyfile`

### Tell caddy to reload configuration file

Script using `curl` command so modify ip address in script accoding to remote caddy host

Run shell script to tell caddy to reload config file. Script will make a REST request to [caddy's api](https://caddyserver.com/docs/api)
to tell caddy to load the configuration.

- Script that use Json configuration: `./caddy-load-caddyjson.sh`
- Script that use Caddyfile configuration: `./caddy-load-caddyfile.sh`
