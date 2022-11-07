set -e
docker pull node
docker build -t local-dcycle-broken-link-checker-image .

docker run -v $(pwd)/example:/app/code local-dcycle-broken-link-checker-image --help
