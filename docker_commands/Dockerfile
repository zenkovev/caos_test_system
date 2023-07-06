FROM ubuntu:latest

RUN apt-get update && \
    apt-get -y install vim && \
    apt-get -y install build-essential && \
    apt-get -y install cmake && \
    apt-get -y install python3-dev && \
    apt-get -y install python3-pip

RUN useradd -ms /bin/bash caos_master
USER caos_master

RUN pip install numpy
