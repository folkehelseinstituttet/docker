#!/bin/bash
export NOCACHE=--no-cache
source $WORKSPACE/bin/R_VERSION.sh

sudo podman rmi fhix/dbase:$RVERSION

sudo podman build --pull --no-cache --squash-all --tag=fhix/dbase:$RVERSION --build-arg RVERSION=$RVERSION $WORKSPACE/dbase
