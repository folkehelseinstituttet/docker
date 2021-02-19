#!/bin/bash
export NOCACHE=--no-cache
source $WORKSPACE/bin/env.sh

sudo podman rmi fhix/dbase2:$RVERSION

sudo podman build \
--pull \
--no-cache \
--squash-all \
--tag=fhix/dbase2:$RVERSION \
--build-arg RVERSION=$RVERSION \
--build-arg CRAN_CHECKPOINT=$CRAN_CHECKPOINT \
$WORKSPACE/dbase
