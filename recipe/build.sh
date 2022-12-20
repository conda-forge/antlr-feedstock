#!/bin/bash

./configure --prefix=$PREFIX \
            --enable-cxx \
            --disable-python \
            --enable-csharp \
            --disable-java \

make
# No make check :-(
make install
