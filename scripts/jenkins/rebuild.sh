#!/bin/bash
#
# Run tests on a Docker host. Requirements:
# * https://github.com/dcycle/docker-digitalocean-php.
# * the docker-broken-link-checker droplet should be deleted in
#   "Post-build Actions".
# * DOCKERHOSTUSER, DOCKERHOSTUSER set using Jenkins's
#   /credentials/store/system/domain/_/ section.
#
set -e

if [ -z "$DOCKERHOSTUSER" ] || [ -z "$DOCKERHOST" ]; then
  >&2 echo "Please configure DOCKERHOSTUSER and DOCKERHOST using"
  >&2 echo "Jenkins secrets (credentials) and export."
  exit 1
fi

# Create a droplet
IP=$(ssh "$DOCKERHOSTUSER"@"$DOCKERHOST" \
  "./digitalocean/scripts/new-droplet.sh docker-broken-link-checker")
echo "Created Droplet at $IP"
sleep 90
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no \
  root@"$IP" "mkdir -p docker-broken-link-checker-job"
scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no \
  ~/.dcycle-docker-credentials.sh \
  root@$IP:~/.dcycle-docker-credentials.sh
scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no \
  -r * root@"$IP":docker-broken-link-checker-job
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no \
  root@"$IP" "cd docker-broken-link-checker-job && ./scripts/rebuild.sh"