FROM ubuntu:latest

RUN apt-get update

RUN apt-get -y install vim && \
    apt-get -y install build-essential && \
    apt-get -y install cmake && \
    apt-get -y install python3-dev && \
    apt-get -y install python3-pip

RUN apt-get -y install wget checkinstall && \
    cd /usr/src && \
    wget https://www.python.org/ftp/python/3.8.15/Python-3.8.15.tgz && \
    tar xzf Python-3.8.15.tgz && \
    cd /usr/src/Python-3.8.15 && \
    ./configure --enable-optimizations && \
    make altinstall

RUN apt update

RUN apt -y install meson cmake fuse3 libfuse3-dev libglib2.0-dev && \
    apt -y install libzip-dev

RUN useradd -ms /bin/bash caos_master
USER caos_master

RUN pip install numpy
