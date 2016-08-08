#!/bin/bash

if [ $(uname) == Darwin ]; then
    export CC=clang
    export CXX=clang++
    export MACOSX_DEPLOYMENT_TARGET="10.9"
    export CXXFLAGS="-stdlib=libc++ $CXXFLAGS"
    export CXXFLAGS="$CXXFLAGS -stdlib=libc++"
fi

./configure --prefix=$PREFIX \
            --enable-cxx \
            --disable-python \
            --enable-csharp \
            --disable-java \

make
# No make check :-(
make install
