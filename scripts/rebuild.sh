#!/bin/bash
# Rebuild script
# This is meant to be run on a regular basis to make sure everything works with
# the latest version of scripts.

set -e

# Always test before rebuilding as the API can have changed, for example at
# https://github.com/phpstan/phpstan-src/commit/3e1ce5d06e574c6da93b8fa3dcf8569f8f8fcff3#diff-c9426bbd63493f10ff3790c0f0d13f99R39
./test.sh

CREDENTIALS="$HOME/.dcycle-docker-credentials.sh"

if [ ! -f "$CREDENTIALS" ]; then
  echo "Please create $CREDENTIALS and add to it:"
  echo "DOCKERHUBUSER=xxx"
  echo "DOCKERHUBPASS=xxx"
  exit;
else
  source "$CREDENTIALS";
fi

./test.sh

PROJECT=broken-link-checker
DATE=`date '+%Y-%m-%d-%H-%M-%S-%Z'`
MAJORVERSION='3'
VERSION='3.0'

# See https://github.com/dcycle/prepare-docker-buildx, for M1 native images.
git clone https://github.com/dcycle/prepare-docker-buildx.git
cd prepare-docker-buildx
export DOCKER_CLI_EXPERIMENTAL=enabled
./scripts/run.sh
cd ..

docker buildx create --name mybuilder
docker buildx use mybuilder
docker buildx inspect --bootstrap
docker login -u"$DOCKERHUBUSER" -p"$DOCKERHUBPASS"

# Start by getting the latest version of the base image
docker pull dcycle/drupal:9php8-fpm-alpine
# Rebuild the entire thing
docker buildx build -t dcycle/"$PROJECT":"$VERSION" --platform linux/amd64,linux/arm64/v8 --push .
docker buildx build -t dcycle/"$PROJECT":"$MAJORVERSION" --platform linux/amd64,linux/arm64/v8 --push .
docker buildx build -t dcycle/"$PROJECT":"$MAJORVERSION".$DATE --platform linux/amd64,linux/arm64/v8 --push .
docker buildx build -t dcycle/"$PROJECT":"$VERSION".$DATE --platform linux/amd64,linux/arm64/v8 --push .
# No longer using the latest tag, use the major version tag instead.
