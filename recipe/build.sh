#!/bin/bash

set -xe

# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* ./scripts/

./configure --prefix=$PREFIX \
            --host="${HOST}" \
            --build="${BUILD}" \
            --enable-cxx \
            --disable-python \
            --enable-csharp \
            --disable-java \

make
# No make check :-(
make install
