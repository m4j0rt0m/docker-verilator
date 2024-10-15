FROM ubuntu:22.04

# Dockerfile with author, maintainer, collaborators, and contributors
LABEL maintainer="Abraham J. Ruiz R. <major.tom.spaceworm@gmail.com>"
LABEL contributor="Alberto Gonzalez Trejo <betbatesc@gmail.com>"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.source="https://github.com/m4j0rt0m/docker-verilator"
LABEL org.opencontainers.image.version="2.0.1"

# install prerequisite software
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git help2man make autoconf flex bison ccache \
    libgoogle-perftools-dev numactl perl-doc \
    perl python3 zlib1g zlib1g-dev \
    libfl2 libfl-dev gdb && \
    apt-get clean

# install gcc-12 & g++-12
RUN apt-get install -y \
    g++-12 gcc-12 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 10 --slave /usr/bin/g++ g++ /usr/bin/g++-12 --slave /usr/bin/gcov gcov /usr/bin/gcov-12

# some environment variables
ENV DOCK /opt/docker
ENV VERILATOR_VERSION 5.028
ENV VERILATOR_INSTALL_DIR /opt/verilator

# create directories
RUN mkdir $DOCK
RUN mkdir $VERILATOR_INSTALL_DIR

WORKDIR $DOCK

# build verilator
RUN cd $DOCK && \
    git clone https://github.com/verilator/verilator verilator && \
    cd verilator && \
    git checkout v$VERILATOR_VERSION && \
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
#ENV VERILATOR_ROOT $VERILATOR_INSTALL_DIR
ENV PATH $PATH:$VERILATOR_INSTALL_DIR/bin

# force the use of bash
RUN ln -sf /bin/bash /bin/sh

# some additional libraries
RUN apt-get install -y \
    libboost-regex-dev device-tree-compiler vim gawk libboost-all-dev

WORKDIR /root
