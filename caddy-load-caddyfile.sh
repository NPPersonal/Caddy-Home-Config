#!/bin/bash

response=$(curl -vsS http://192.168.1.226:2019/load -H "Content-Type: text/caddyfile" --data-binary @configs/Caddyfile)
echo $response