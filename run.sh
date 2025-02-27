#!/bin/bash

image_name="hub.yjyz.com/inf/open-webui:yjzf-20250228"
container_name="open-webui"
host_port=3000
container_port=8080

docker build --platform=linux/amd64 -t "$image_name" .
docker stop "$container_name" &>/dev/null || true
docker rm "$container_name" &>/dev/null || true

docker run -d -p "$host_port":"$container_port" \
    --add-host=host.docker.internal:host-gateway \
    -v "${image_name}:/app/backend/data" \
    --name "$container_name" \
    --restart always \
    "$image_name"

docker image prune -f

docker run -d p 1111:8080 --add-host=host.docker.internal:host-gateway -v "open-webui-data:/app/backend/data"
