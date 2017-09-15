#!/bin/sh

WORKDIR=/tmp/barebox
ENV=/usr/share/barebox/env.tar.gz

if [ ! -d $WORKDIR ]; then
    rm -rf $WORKDIR
    mkdir -p $WORKDIR
fi

tar -xzf $ENV -C $WORKDIR
bareboxenv -s