FROM ubuntu:latest

RUN apt-get update && \
    apt-get -y install vim && \
    apt-get -y install gcc

RUN useradd -ms /bin/bash caos_master
USER caos_master
