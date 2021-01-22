#!/bin/bash

# Jan 21, 2021 1:00 AM GMT+1 for Ubuntu 20.04
export CRAN_CHECKPOINT=https://packagemanager.rstudio.com/all/__linux__/focal/926967 

# get checkpoint IDs here:
# https://packagemanager.rstudio.com/client/#/repos/1/overview
# click on any date
# below the date picker, see the generated URl - press "change" and choose FOCAL20 from the dropdown
# grab the number from the link
# place it into this file as the variable CRAN_CHECKPOINT
