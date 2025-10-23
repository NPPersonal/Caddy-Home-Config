#!/bin/bash

response=$(curl -vsS http://192.168.1.226:2019/load -H "Content-Type: application/json" --data @configs/caddy_config.json)
echo $response