#!/bin/bash

# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* .

./configure --prefix=$PREFIX \
            --enable-cxx \
            --disable-python \
            --enable-csharp \
            --disable-java \

make
# No make check :-(
make install
