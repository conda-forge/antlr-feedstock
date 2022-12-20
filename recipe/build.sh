#!/bin/bash

./configure --prefix=$PREFIX \
            --enable-cxx \
            --disable-python \
            --disable-csharp \
            --disable-shared \
            --disable-java \

make
# No make check :-(
make install
