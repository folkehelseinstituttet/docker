ARG RVERSION=RVERSION
FROM fhix/dbase:${RVERSION}
MAINTAINER "Carl Boettiger and Dirk Eddelbuettel" rocker-maintainers@eddelbuettel.com

#TEMPORARY
RUN sed -i "/s/mran.microsoft.com/cran.microsoft.com/g" /usr/local/lib/R/etc/Rprofile.site
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

# TEMPORARY SOLUTIONS UNTIL THE PACKAGE MAKES ITS WAY TO CRAN
RUN R -e 'devtools::install_github("hughjonesd/huxtable", ref="114c8ff")'
RUN R -e 'devtools::install_github("thlytras/FluMoDL")'
RUN R -e 'devtools::install_github("HenrikBengtsson/progressr")'

# NEWER STUFF, TEMPORARILY INSTALLED
RUN R -e 'install.packages(c("globals","listenv","future","foreach","doFuture", "pinp", "EpiEstim", "lemon"), repos = "https://cran.rstudio.com")'

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

RUN touch /etc/xxx

# RUN R -e 'install.packages("data.table", type = "source", repos = "https://Rdatatable.gitlab.io/data.table")'
