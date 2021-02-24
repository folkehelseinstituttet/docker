ARG RVERSION=RVERSION
ARG CRAN_CHECKPOINT=CRAN_CHECKPOINT
FROM rstudio/r-base:${RVERSION}-focal

RUN touch /etc/profile.d/r.sh
RUN echo "export R_HOME=/opt/R/4.0.2" >> /etc/profile.d/r.sh
