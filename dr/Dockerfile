ARG RVERSION=RVERSION
FROM fhix/dbase:${RVERSION}
MAINTAINER "Carl Boettiger and Dirk Eddelbuettel" rocker-maintainers@eddelbuettel.com

# update
RUN apt-get clean
RUN apt-get update -y

# TEMPORARY SOLUTIONS UNTIL THE PACKAGE MAKES ITS WAY TO CRAN
RUN R -e 'devtools::install_github("HenrikBengtsson/progressr")'
RUN R -e 'devtools::install_github("rstudio/plumber")'

# DRAT PACKAGES FROM EUROMOMO
RUN . /etc/environment \
  && install2.r --error \
  MOMO

## DRAT PACKAGES FROM RICHARD
RUN . /etc/environment \
  && install2.r --error \
  RAWmisc

## DRAT PACKAGES FROM FHI
RUN . /etc/environment \
  && install2.r --error \
  org \
  plnr \
  fhidata \
  fhimaps \
  fhiplot \
  fhi \
  spread \
  attrib \
  sykdomspuls \
  flumomo
