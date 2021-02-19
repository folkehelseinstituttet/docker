#!/bin/bash

export RVERSION=4.0.2

# currently we are snapshotted to Jan 12, 2021 1:00 AM GMT+1 for Ubuntu 20.04 (Focal)
# This is very important, because R package pool 0.1.6 (released 2021-01-14) does not
# work with dbplyr, which means the shiny server can't access the database
export CRAN_CHECKPOINT=https://packagemanager.rstudio.com/all/__linux__/focal/766976

# get checkpoint IDs here:
# https://packagemanager.rstudio.com/client/#/repos/1/overview
# click on any date
# below the date picker, see the generated URl - press "change" and choose FOCAL20 from the dropdown
# grab the number from the link
# place it into this file as the variable CRAN_CHECKPOINT
