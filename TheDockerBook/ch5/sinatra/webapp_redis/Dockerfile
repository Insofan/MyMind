FROM ubuntu:latest
MAINTAINER Insomnia "insofan3156@gmail.com"
ENV REFRESHED_AT 2019-01-27

RUN apt-get update && apt-get -yqq install redis-server redis-tools
EXPOSE 6739
ENTRYPOINT ["/usr/bin/redis-server"]
CMD []
