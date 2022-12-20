#!/bin/bash

set -xe

# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* .

./configure --prefix=$PREFIX \
            --host="${HOST}" \
            --build="${BUILD}" \
            --enable-cxx \
            --disable-python \
            --disable-csharp \
            --disable-shared \
            --disable-java \

make
# No make check :-(
make install
