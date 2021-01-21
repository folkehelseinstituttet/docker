#!/bin/bash
export NOCACHE=--no-cache
source $WORKSPACE/bin/R_VERSION.sh
source $WORKSPACE/bin/CRAN_CHECKPOINT.sh

sudo podman rmi fhix/dbase:$RVERSION

sudo podman build \
--pull \
--no-cache \
--squash-all \
--tag=fhix/dbase:$RVERSION \
--build-arg RVERSION=$RVERSION \
--build-arg CRAN_CHECKPOINT=$CRAN_CHECKPOINT
$WORKSPACE/dbase
