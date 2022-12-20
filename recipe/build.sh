#!/bin/bash

set -xe

# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* ./scripts/

if [ $(uname) == Darwin ]; then
    CSHARP=--disable-csharp
else
    CSHARP=--enable-csharp
fi

./configure --prefix=$PREFIX \
            --host="${HOST}" \
            --build="${BUILD}" \
            --enable-cxx \
            --disable-python \
            ${CSHARP} \
            --disable-java \

make
# No make check :-(
make install
