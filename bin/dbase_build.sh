#!/bin/bash
export NOCACHE=--no-cache
source $WORKSPACE/bin/R_VERSION.sh

docker rmi fhix/dbase:$RVERSION
(echo y) | docker system prune

docker build --pull --no-cache --squash --tag=fhix/dbase:$RVERSION --build-arg RVERSION=$RVERSION $WORKSPACE/dbase
