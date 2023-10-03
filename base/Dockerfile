FROM ubuntu:22.04

MAINTAINER m4j0rt0m

# install prerequisite software
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git help2man make autoconf g++ flex bison ccache \
    libgoogle-perftools-dev numactl perl-doc \
    perl python3 zlib1g zlib1g-dev \
    libfl2 libfl-dev gdb && \
    apt-get clean

ENV DOCK /opt/docker
ENV VERILATOR_VERSION stable
ENV VERILATOR_INSTALL_DIR /opt/verilator

RUN mkdir $DOCK
RUN mkdir $VERILATOR_INSTALL_DIR

WORKDIR $DOCK

# build verilator
RUN cd $DOCK && \
    git clone https://github.com/verilator/verilator verilator && \
    cd verilator && \
    git checkout $VERILATOR_VERSION && \
    autoconf && \
    ./configure --prefix=$VERILATOR_INSTALL_DIR && \
    make -j$(nproc)

# test verilator
RUN cd $DOCK && \
    cd verilator && \
    make test

# install verilator
RUN cd $DOCK && \
    cd verilator && \
    make install

# symlinks to verilator stuff
RUN ln -s $VERILATOR_INSTALL_DIR/share/verilator/include $VERILATOR_INSTALL_DIR/include && \
    ln -s $VERILATOR_INSTALL_DIR/share/verilator/bin/verilator_includer $VERILATOR_INSTALL_DIR/bin/verilator_includer

# remove downloaded stuff
RUN cd $DOCK && \
    rm -rf verilator

# set some environmnet variables
ENV VERILATOR_ROOT $VERILATOR_INSTALL_DIR
ENV PATH $PATH:$VERILATOR_ROOT/bin

# force the use of bash
RUN ln -sf /bin/bash /bin/sh

WORKDIR /root
