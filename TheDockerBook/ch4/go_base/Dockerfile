FROM ubuntu:latest
MAINTAINER Insomnia "insofan3156@gmail.com"
RUN apt-get update
RUN apt-get install -y golang-go
RUN apt-get install -y git
RUN apt-get install -y vim
WORKDIR /go/src/
RUN go env
RUN go get -u github.com/golang/dep/cmd/dep
RUN dep



