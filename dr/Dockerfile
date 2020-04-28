ARG RVERSION=RVERSION
FROM fhix/dbase:${RVERSION}
MAINTAINER "Carl Boettiger and Dirk Eddelbuettel" rocker-maintainers@eddelbuettel.com

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
  RAWmisc \
  org

## DRAT PACKAGES FROM FHI
RUN . /etc/environment \ 
  && install2.r --error \
  fhidata \
  plnr \
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
  smhb \
  flumomo

# minuconda
RUN echo "RETICULATE_MINICONDA_PATH='/miniconda'" >> /usr/local/lib/R/etc/Renviron
RUN Rscript -e 'reticulate::install_miniconda()'
RUN chmod -R 0777 /miniconda
RUN Rscript -e 'reticulate::py_install("marrow.mailer",pip=T)'

