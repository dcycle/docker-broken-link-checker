set -e
docker pull node
docker pull dcycle/broken-link-checker:1
docker build -t local-dcycle-broken-link-checker-image .

docker run -v $(pwd)/example:/app/code dcycle/broken-link-checker --help
docker run -v $(pwd)/example:/app/code dcycle/broken-link-checker .
docker run -v $(pwd)/example:/app/code local-dcycle-broken-link-checker-image --help
docker run -v $(pwd)/example:/app/code local-dcycle-broken-link-checker-image .