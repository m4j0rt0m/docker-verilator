FROM ubuntu:18.04

MAINTAINER m4j0rt0m

# install prerequisite software
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git make autoconf g++ flex bison \
    perl python3 zlibc zlib1g zlib1g-dev \
    libfl2 libfl-dev gdb && \
    apt-get clean

ENV DOCK /opt/docker
ENV VERILATOR_VERSION v4.108
ENV VERILATOR_ROOT /opt/verilator

RUN mkdir $DOCK
RUN mkdir $VERILATOR_ROOT

WORKDIR $DOCK

# install verilator
RUN cd $DOCK && \
    git clone https://github.com/verilator/verilator verilator && \
    cd verilator && \
    git checkout $VERILATOR_VERSION && \
    autoconf && \
    ./configure --prefix=$VERILATOR_ROOT && \
    make -j$(nproc) && \
    make install

# remove downloaded stuff
RUN cd $DOCK && \
    rm -rf verilator

# symlinks to verilator stuff
RUN ln -s $VERILATOR_ROOT/share/verilator/include $VERILATOR_ROOT/include && \
    ln -s $VERILATOR_ROOT/share/verilator/bin/verilator_includer $VERILATOR_ROOT/bin/verilator_includer

ENV PATH $PATH:$VERILATOR_ROOT/bin

# force the use of bash
RUN ln -sf /bin/bash /bin/sh

WORKDIR /root
