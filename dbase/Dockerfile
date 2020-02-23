ARG RVERSION=RVERSION
FROM rocker/verse:${RVERSION}
MAINTAINER "Carl Boettiger and Dirk Eddelbuettel" rocker-maintainers@eddelbuettel.com

# soft link to site library
RUN ln -s /usr/local/lib/R/site-library/ /r

# allow 'rstudio' as password
RUN sed -i '/exit 1/d' /etc/cont-init.d/userconf

# update
RUN apt-get update -y

## Kerberos for SQL server auth
RUN apt-get install --yes apt-transport-https curl gnupg
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
  && curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list \
  && apt-get update \
  && ACCEPT_EULA=Y apt-get install --yes --no-install-recommends msodbcsql17 \
  && DEBIAN_FRONTEND=noninteractive apt-get -yqq install krb5-user libpam-krb5

# other database stuff
RUN apt-get install -y unixodbc unixodbc-dev
RUN mkdir -p /usr/lib/x86_64-linux-gnu/odbc/
COPY mysql-connector-odbc-8.0.16-linux-debian9-x86-64bit.tar.gz /tmp/mysql-connector-odbc-8.0.16-linux-debian9-x86-64bit.tar.gz
RUN cd /tmp; tar -xvf /tmp/mysql-connector-odbc-8.0.16-linux-debian9-x86-64bit.tar.gz
RUN cd /tmp; sudo cp mysql-connector-odbc-8.0.16-linux-debian9-x86-64bit/lib/libmyodbc8* /usr/lib/x86_64-linux-gnu/odbc/
RUN sudo /tmp/mysql-connector-odbc-8.0.16-linux-debian9-x86-64bit/bin/myodbc-installer -d -a -n "MySQL" -t "DRIVER=/usr/lib/x86_64-linux-gnu/odbc/libmyodbc8w.so;Setup=/usr/lib/x86_64-linux-gnu/odbc/libmyodbc8S.so;"

# bcp for copying data directly to MSSQL
RUN ACCEPT_EULA=Y DEBIAN_FRONTEND=noninteractive apt-get install --yes mssql-tools

# timezone
# echo "TZ='Europe/Oslo'" >> /usr/local/lib/R/etc/Renviron
RUN apt-get install -y tzdata
RUN echo "TZ='Europe/Oslo'" >> /etc/profile
RUN echo "TZ='Europe/Oslo'" >> /usr/local/lib/R/etc/Renviron

# tinytex  and bcp
RUN echo PATH="$PATH:/opt/mssql-tools/bin" >> /etc/profile
RUN echo export PATH >> /etc/profile
RUN echo Sys.setenv\(PATH=\"$PATH:/opt/mssql-tools/bin\"\) >> /usr/local/lib/R/etc/Rprofile.site

# FONTS
COPY fonts-ubuntu_0.83-4_all.deb /tmp/fonts-ubuntu_0.83-4_all.deb
RUN dpkg -i /tmp/fonts-ubuntu_0.83-4_all.deb

# tinytex needed packages
RUN tlmgr option repository http://ctan.uib.no/systems/texlive/tlnet
COPY update-tlmgr-latest.sh /tmp/update-tlmgr-latest.sh
RUN chmod 777 /tmp/update-tlmgr-latest.sh
RUN sudo /tmp/update-tlmgr-latest.sh -- --upgrade
# RUN tlmgr update --self
# RUN wget --no-verbose http://mirror.ctan.org/systems/texlive/tlnet/update-tlmgr-latest.sh -O /tmp/update-tlmgr-latest.sh
# RUN sudo /tmp/update-tlmgr-latest.sh --update

RUN apt-get install -y xzdec
RUN tlmgr init-usertree
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
  collection-latexextra \
  palatino \
  mathpazo \
  fpl \
  babel-norsk \
  hyphen-norwegian \
  siunitx \
  pgf \
  algorithms \
  algorithmicx \
  mathdesign \
  ly1 \
  charter
RUN tlmgr update --all

RUN texhash

# include new repo
RUN sed -i "s/CRAN/folkehelseinstituttet=\'https:\\/\\/folkehelseinstituttet.github.io\\/drat\\/\',euromomo=\'https:\\/\\/euromomonetwork.github.io\\/drat\\/\',raubreywhite=\'https:\\/\\/raubreywhite.github.io\\/drat\\/\',CRAN/" /usr/local/lib/R/etc/Rprofile.site
RUN sed -i "1s/^/dratRepo=\'\\/git\\/drat\\/\'\n/" /usr/local/lib/R/etc/Rprofile.site

RUN apt-get update && apt-get install -y libgdal-dev libgeos-c1v5 libproj-dev libgsl0-dev libprotobuf-dev protobuf-compiler
RUN apt-get update && apt-get install -y ncftp ftp cron sshpass
RUN apt-get update && apt-get install -y libglu1-mesa-dev freeglut3-dev mesa-common-dev libudunits2-dev
RUN apt-get update && apt-get install -y libjq-dev
RUN apt-get update && apt-get install -y libssl-dev
RUN apt-get update && apt-get install -y libomp-dev
RUN apt-get update && apt-get install -y tk dvipng
RUN apt-get update && apt-get install -y cargo libnetcdf-dev netcdf-bin libsodium-dev

# libreoffice
RUN apt-get update && apt-get install -y libreoffice
RUN sudo echo /usr/lib/libreoffice/program/ >> /etc/ld.so.conf.d/local.conf
RUN /sbin/ldconfig

# data.table doesn't like clang
RUN . /etc/environment \ 
  && install2.r --error --repos $MRAN \
    data.table \
    influenceR \
    gower

# Install clang to use as compiler
# clang seems to be more memory efficient with the templates than g++
# with g++ rstan cannot compile on docker hub due to memory issues
RUN apt-get update \ 
	&& apt-get install -y --no-install-recommends \
                   clang

# Global site-wide config
RUN mkdir -p $HOME/.R/ \
    && echo "\nCXX=clang++ -ftemplate-depth-256\n" >> $HOME/.R/Makevars \
    && echo "CC=clang\n" >> $HOME/.R/Makevars \
    && echo "CXXFLAGS += -Os\n" >> $HOME/.R/Makevars

RUN . /etc/environment \ 
  && install2.r --error --repos $MRAN --deps TRUE \
    ggrepel \
    lme4 \
    arm \
    gmailr \
    pander \
    httpuv \
    ggpubr \
    rio

#  INLA
RUN R -e "install.packages('INLA', repos=c(getOption('repos'), INLA='https://inla.r-inla-download.org/R/stable'), dep=FALSE)"

RUN apt-get install -y jags

RUN . /etc/environment \ 
  && install2.r --error --repos $MRAN --deps TRUE \
    surveillance \
    munsell \
    RColorBrewer \
    labeling \
    htmltools \
    evaluate \
    R.utils \
    openxlsx \
    splitstackshape \
    corrr \
    ggdendro \
    ClustOfVar \
    dendextend \
    plumber \
    knitcitations \
    bibtex \
    brew \
    Hmisc \
    ggvis \
    Formula \
    roxygen2 \
    packrat \
    rms \
    survey \
    miniCRAN \
    MatrixModels \
    shiny \
    flexdashboard \
    pomp \
    xgboost \
    directlabels \
    rstan \
    shinystan \
    ineq \
    lomb \
    rmarkdown \
    shinyBS \
    rgeolocate \
    glm2 \
    zip \
    doSNOW \
    drat \
    profvis \
    glmnet \
    glmnetUtils \
    pscl \
    knitr \
    bookdown \
    reticulate \
    processx

RUN . /etc/environment \ 
  && install2.r --error --repos $MRAN --deps TRUE \
    survminer \
    units \
    rgdal \
    rgeos \
    geojsonio \
    rmapshaper \
    styler \
    uuid \
    captioner \
    pkgdown \
    blastula \
    RMariaDB \
    pool \
    memoise \
    pbmcapply \
    lemon \
    GPArotation \
    xlsx \
    kableExtra \
    cowplot \
    GADMTools \
    mapproj \
    blogdown \
    RcppProgress \
    fancycut \
    odbc \
    mem \
    pbapply \
    SDMTools \
    ncdf4 \
    huxtable \
    svglite \
    shinydashboard \
    rsvg \
    missRanger \
    drc \
    DescTools \
    ppcor \
    corpcor \
    GeneNet \
    ggpubr \
    asbio \
    samplingbook \
    writexl \
    dlnm \
    mvmeta \
    pbs \
    epitrix \
    gh \
    future \
    future.callr \
    future.apply \
    pryr \
    doFuture \
    pinp \
    egg \
    EpiEstim \
    icd10


RUN R -e "blogdown::install_hugo()"

## NEWER STUFF THAT NEEDS TO BE INSTALLED FROM GITHUB
#RUN R -e "devtools::install_github('Appsilon/shiny.router',ref='7d9bc757ea31a1fe8faea6a5817c8adda97a0be0')"
#RUN R -e "devtools::install_github('stan-dev/projpred', ref='d9a59c432899d2c3086623302188eb140bee2e21')"
#RUN R -e "devtools::install_github('r-lib/testthat')"
#RUN R -e "devtools::install_github('hadley/haven', force=TRUE)"
#RUN R -e "devtools::install_github('cran/optimParallel', force=TRUE)"

env LANG=C.UTF-8 DEBIAN_FRONTEND=noninteractive

## TENSORFLOW

RUN apt-get install -y python3-pip python3-dev
RUN pip3 install --upgrade pip
RUN pip3 install tensorflow
RUN pip3 install junit-xml
RUN pip3 install virtualenv

RUN R -e "Sys.setenv(TENSORFLOW_PYTHON_VERSION=3);install.packages('tensorflow')"

# rclone
RUN apt-get update && apt-get install -y \
        curl man-db
RUN curl https://rclone.org/install.sh | sudo bash

RUN mkdir /analyses
RUN mkdir /dropbox
RUN chmod 777 /analyses /dropbox

# preferences to stop timing out
COPY rsession.conf /etc/rstudio/rsession.conf

## ADD IN SHINY
ENV ADD=shiny
RUN wget --no-verbose https://raw.githubusercontent.com/rocker-org/rocker-versioned/master/rstudio/add_shiny.sh -O "add_shiny.sh" 
RUN sed -i -e "1d" add_shiny.sh
RUN sed -i '1s/^/#!\/bin\/bash /' add_shiny.sh
RUN chmod 777 add_shiny.sh
RUN /add_shiny.sh
RUN rm /etc/cont-init.d/add
COPY shiny-server.conf /etc/shiny-server/shiny-server.conf

# shiny for norwegian characters
RUN echo "LANG=en_US.UTF-8" >> /home/shiny/.Renviron
