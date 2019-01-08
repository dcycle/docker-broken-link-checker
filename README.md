[![CircleCI](https://circleci.com/gh/dcycle/docker-broken-link-checker.svg?style=svg)](https://circleci.com/gh/dcycle/docker-broken-link-checker)

Check for broken links with [Broken Link Checker](https://www.npmjs.com/package/broken-link-checker).

For example:

    docker run -v "$(pwd)"/example:/app/code dcycle/broken-link-checker --help
    docker run -v "$(pwd)"/example:/app/code dcycle/broken-link-checker .

See [this project on the Docker Hub](https://hub.docker.com/r/dcycle/broken-link-checker/).