FROM ubuntu:latest
MAINTAINER Insomnia "insofan3156@gmail.com"
ENV REFRESHED_AT 2019-01-27
RUN apt-get -yqq update && apt-get -yqq install nginx
RUN mkdir -p /var/www/html/website
ADD nginx/global.conf /etc/nginx/conf.d/
ADD nginx/nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
