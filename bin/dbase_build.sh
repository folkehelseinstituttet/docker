#!/bin/bash
export NOCACHE=--no-cache
source $WORKSPACE/bin/R_VERSION.sh


docker build --pull --no-cache --squash --tag=fhix/dbase:$RVERSION --build-arg RVERSION=$RVERSION $WORKSPACE/dbase
