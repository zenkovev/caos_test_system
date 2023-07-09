FROM ubuntu:latest

RUN apt-get update && \
    apt-get -y install vim && \
    apt-get -y install build-essential && \
    apt-get -y install cmake && \
    apt-get -y install python3-dev && \
    apt-get -y install python3-pip

RUN apt-get update && \
    apt-get -y install wget checkinstall && \
    cd /usr/src && \
    wget https://www.python.org/ftp/python/3.8.15/Python-3.8.15.tgz && \
    tar xzf Python-3.8.15.tgz && \
    cd /usr/src/Python-3.8.15 && \
    ./configure --enable-optimizations && \
    make altinstall

RUN useradd -ms /bin/bash caos_master
USER caos_master

RUN pip install numpy
