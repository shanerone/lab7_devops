#!/usr/bin/env bash
set -euo pipefail

readonly image_name="devops/nginx-server"
readonly container_name="nginx-cont"
readonly host_port="54321"

docker rm --force "$container_name" 2>/dev/null || true
docker build --tag "$image_name" .
docker run --detach \
  --name "$container_name" \
  --publish "${host_port}:80" \
  --restart unless-stopped \
  "$image_name"

sleep 2
docker ps --filter "name=^/${container_name}$"
curl --fail --silent --show-error "http://localhost:${host_port}/"
docker logs --tail 10 "$container_name"
