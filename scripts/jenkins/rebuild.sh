#!/bin/bash
set -e

# The token must be set as an environment variable
if [ -v "$DIGITALOCEAN_ACCESS_TOKEN" ]; then
  >&2 echo "Please set the DIGITALOCEAN_ACCESS_TOKEN environment variable"
  exit 1
fi
# The ssh key must be set as an environment variable
if [ -v "$DIGITALOCEAN_SSH_KEY" ]; then
  >&2 echo "Please set the DIGITALOCEAN_SSH_KEY environment variable"
  exit 1
fi

# Create a droplet
DROPLET_NAME=docker-broken-link-checker

doctl compute droplet create "$DROPLET_NAME" --size 4gb --image ubuntu-20-04-x64 --ssh-keys "$DIGITALOCEAN_SSH_KEY"

sleep 45

IP=$(doctl compute droplet get "$DROPLET_NAME" --format PublicIPv4 --no-header)
echo "Created Droplet at $IP"

sleep 45

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no \
  root@"$IP" "mkdir -p docker-docker-broken-link-checker"
scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no \
  ~/.dcycle-docker-credentials.sh \
  root@$IP:~/.dcycle-docker-credentials.sh
scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no \
  -r * root@"$IP":docker-docker-broken-link-checker
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no \
  root@"$IP" "cd docker-docker-broken-link-checker && ./scripts/install-docker-and-rebuild.sh"