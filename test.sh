set -e
docker pull node
docker pull dcycle/broken-link-checker:2
docker build -t local-dcycle-broken-link-checker-image .

docker run -v $(pwd)/example:/app/code dcycle/broken-link-checker:2 --help
docker run -v $(pwd)/example:/app/code local-dcycle-broken-link-checker-image --help
