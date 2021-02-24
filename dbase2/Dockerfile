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

RUN Rscript -e "install.packages('littler')"
RUN ln -s $R_HOME/library/littler/bin/r /usr/local/bin/r

# update
RUN apt-get clean
RUN apt-get update -y

## Kerberos for SQL server auth and mssql drivers
RUN apt-get install --yes apt-transport-https curl gnupg
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
  && curl https://packages.microsoft.com/config/ubuntu/19.10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
  && apt-get update \
  && ACCEPT_EULA=Y apt-get install --yes --no-install-recommends msodbcsql17 \
  && DEBIAN_FRONTEND=noninteractive apt-get -yqq install krb5-user libpam-krb5

# mysql
#RUN apt-get install -y unixodbc unixodbc-dev libmyodbc
#RUN mkdir -p /usr/lib/x86_64-linux-gnu/odbc/
#COPY mysql-connector-odbc-setup_8.0.20-1ubuntu20.04_amd64.deb /tmp/
#RUN dpkg -i /tmp/mysql-connector-odbc-setup_8.0.20-1ubuntu20.04_amd64.deb sudo apt-get install -f.
#RUN cd /tmp; tar -xvf /tmp/mysql-connector-odbc-setup_8.0.20-1ubuntu20.04_amd64.tar.gz
#RUN cd /tmp; sudo cp mysql-connector-odbc-setup_8.0.20-1ubuntu20.04_amd64/lib/libmyodbc8* /usr/lib/x86_64-linux-gnu/odbc/
#RUN sudo /tmp/mysql-connector-odbc-setup_8.0.20-1ubuntu20.04_amd64/bin/myodbc-installer -d -a -n "MySQL" -t "DRIVER=/usr/lib/x86_64-linux-gnu/odbc/libmyodbc8w.so;Setup=/usr/lib/x86_64-linux-gnu/odbc/libmyodbc8S.so;"

# bcp for copying data directly to MSSQL
RUN ACCEPT_EULA=Y DEBIAN_FRONTEND=noninteractive apt-get install --yes mssql-tools

# bcp
RUN echo PATH="$PATH:/opt/mssql-tools/bin" >> /etc/profile
RUN echo export PATH >> /etc/profile
RUN echo Sys.setenv\(PATH=\"$PATH:/opt/mssql-tools/bin\"\) >> /usr/local/lib/R/etc/Rprofile.site

# timezone
# echo "TZ='Europe/Oslo'" >> /usr/local/lib/R/etc/Renviron
RUN apt-get install -y tzdata
RUN echo "TZ='Europe/Oslo'" >> /etc/environment
RUN echo "TZ='Europe/Oslo'" >> /usr/local/lib/R/etc/Renviron

# FONTS
COPY fonts-ubuntu_0.83-4_all.deb /tmp/fonts-ubuntu_0.83-4_all.deb
RUN dpkg -i /tmp/fonts-ubuntu_0.83-4_all.deb

RUN install2.r --error --skipinstalled -d TRUE -n 6 \
    tinytex

# tinytex needed packages
RUN tlmgr update --self
RUN tlmgr install \
  svg \
  koma-script \
  trimspaces \
  xcolor \
  fancyhdr \
  blindtext \
  background \
  pgf \
  everypage \
  datetime \
  fmtcount \
  float \
  tufte-latex \
  hardwrap \
  titlesec \
  textcase \
  setspace \
  units \
  ulem \
  morefloats \
  xifthen \
  ec \
  multirow \
  hyphen-norwegian \
  palatino \
  mathpazo \
  fpl \
  babel-norsk \
  siunitx \
  pgf \
  algorithms \
  algorithmicx \
  mathdesign \
  ly1 \
  charter
RUN tlmgr update --all

RUN texhash

RUN tlmgr install \
  collection-latexextra
