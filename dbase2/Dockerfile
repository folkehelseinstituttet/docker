ARG RVERSION=RVERSION
ARG CRAN_CHECKPOINT=CRAN_CHECKPOINT
FROM rstudio/r-base:${RVERSION}-focal
ENV R_HOME="/opt/R/${RVERSION}/lib/R"

# install2.r
COPY install2.r /usr/local/bin/install2.r

# Rprofile.site - change the repos from default
# Add drat repo on first line
RUN echo 'dratRepo="/git/drat/"' >> $R_HOME/etc/Rprofile.site
# Add our repo list on second line
RUN echo "options(repos = c(folkehelseinstituttet='https://folkehelseinstituttet.github.io/drat/',euromomo='https://euromomonetwork.github.io/drat/',raubreywhite='https://raubreywhite.github.io/drat/',CRAN = '$CRAN_CHECKPOINT'), download.file.method = 'libcurl')" >> $R_HOME/etc/Rprofile.site

#RUN Rscript -e "install.packages('littler')"
