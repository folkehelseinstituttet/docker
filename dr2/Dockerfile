ARG R_VERSION=R_VERSION
FROM fhix/dbase2:${R_VERSION}
MAINTAINER "Carl Boettiger and Dirk Eddelbuettel" rocker-maintainers@eddelbuettel.com

# update
RUN apt-get update -y

# pandoc https://github.com/jgm/pandoc/releases/tag/2.13
COPY pandoc-2.13-1-amd64.deb
sudo dpkg -i pandoc-2.13-1-amd64.deb

# TEMPORARY SOLUTIONS UNTIL THE PACKAGE MAKES ITS WAY TO CRAN
# RUN R -e 'devtools::install_github("HenrikBengtsson/progressr")'
# RUN R -e 'devtools::install_github("rstudio/plumber")'

# DRAT PACKAGES FROM EUROMOMO
RUN install2.r --error \
  MOMO

## DRAT PACKAGES FROM RICHARD
#RUN install2.r --error \
#  RAWmisc

## DRAT PACKAGES FROM FHI
RUN install2.r --error \
  org \
  plnr \
  fhidata \
  fhimaps \
  fhiplot \
  fhi \
  spread \
  attrib \
  flumomo

RUN install2.r --error \
  fhidata
