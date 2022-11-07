Dcycle Docker Broken Link Checker
-----

[![CircleCI](https://circleci.com/gh/dcycle/docker-broken-link-checker/tree/master.svg?style=svg)](https://circleci.com/gh/dcycle/docker-broken-link-checker/tree/master)

Check for broken links with [Link Checker](https://github.com/linkchecker/linkchecker).

For example:

    docker run --rm dcycle/broken-link-checker:3 --help
    docker run --rm dcycle/broken-link-checker:3 http://example.com > ~/Desktop/result.csv

Checking against a site running on a docker container:

    docker run --rm --link my_container_name:site dcycle/broken-link-checker:3 http://site

You will now have access to the csv file of broken links at ~/Desktop/result.csv.

What are the differences between this project and the official Docker image?
-----

The [project has a Dockerfile](https://github.com/linkchecker/linkchecker/blob/master/Dockerfile), and there is an [official project on the Docker hub](https://hub.docker.com/r/linkchecker/linkchecker).

* The project's Docker does not seem to work, as it gives an error about Python 2 being end of life. See [this pull request on the linkchecker project](https://github.com/linkchecker/linkchecker/pull/379).
* This project is automatically rebuilt using the latest version weekly; the project's Dockerfile has not been updated since Summer 2019.
* This project automatically outputs as CSV.

See [this project on the Docker Hub](https://hub.docker.com/r/dcycle/broken-link-checker/).
