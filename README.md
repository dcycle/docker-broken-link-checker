[![CircleCI](https://circleci.com/gh/dcycle/docker-broken-link-checker.svg?style=svg)](https://circleci.com/gh/dcycle/docker-broken-link-checker)

Check for broken links with [Link Checker](https://github.com/linkchecker/linkchecker).

For example:

    docker run --rm dcycle/broken-link-checker:2 --help
    docker run --rm dcycle/broken-link-checker:2 http://example.com > ~/Desktop/result.csv

Checking against a site running on a docker container:

    docker run --rm --link my_container_name:site dcycle/broken-link-checker:2 http://site

You will now have access to the csv file of broken links at ~/Desktop/result.csv.

See [this project on the Docker Hub](https://hub.docker.com/r/dcycle/broken-link-checker/).
