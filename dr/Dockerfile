ARG RVERSION=RVERSION
FROM fhix/dbase:${RVERSION}
MAINTAINER "Carl Boettiger and Dirk Eddelbuettel" rocker-maintainers@eddelbuettel.com

#TEMPORARY
RUN R -e 'devtools::install_github("thlytras/FluMoDL")'

# DRAT PACKAGES FROM EUROMOMO
RUN . /etc/environment \ 
  && install2.r --error \
  MOMO 

## DRAT PACKAGES FROM RICHARD
RUN . /etc/environment \ 
  && install2.r --error \
  RAWmisc \
  org

## DRAT PACKAGES FROM FHI
RUN . /etc/environment \ 
  && install2.r --error \
  fhidata \
  fhiplot \
  fhi \
  spread \
  attrib \
  fd \
  sykdomspuls \
  normomo \
  sykdomspulslog \
  noispiah \
  brain \
  ui \
  smhb
 

# TEMPORARY SOLUTIONS UNTIL THE PACKAGE MAKES ITS WAY TO CRAN
RUN R -e 'devtools::install_github("hughjonesd/huxtable", ref="114c8ff")'
RUN R -e 'devtools::install_github("thlytras/FluMoDL")'

