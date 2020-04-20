#!/bin/bash

winpty docker build ./ -t hiroyuking/docker-comskip:latest # >&/dev/null

if test $# -ne 1; then
    echo "usage: comskip.sh [TS file]" 1>&2
    exit 1
fi

echo "TS file: ${1}"

winpty docker run                        \
       --log-driver=none                 \
       -a stdin -a stdout -a stderr      \
       hiroyuking/docker-comskip:latest  \
       bash comskip/misc/comskip_wrapper.sh comskip/misc/comskip.ini ${1}
