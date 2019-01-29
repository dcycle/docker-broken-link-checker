FROM ubuntu

RUN apt-get -y update
RUN apt-get -y install linkchecker

ENTRYPOINT [ "linkchecker", "-o", "csv" ]
