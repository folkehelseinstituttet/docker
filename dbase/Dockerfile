ARG RVERSION=RVERSION
FROM rocker/geospatial:${RVERSION}
#FROM rocker/verse:${RVERSION}
MAINTAINER "Carl Boettiger and Dirk Eddelbuettel" rocker-maintainers@eddelbuettel.com

# soft link to site library
RUN ln -s /usr/local/lib/R/site-library/ /r

# allow 'rstudio' as password
# RUN sed -i '/exit 1/d' /etc/cont-init.d/userconf

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

# timezone
# echo "TZ='Europe/Oslo'" >> /usr/local/lib/R/etc/Renviron
RUN apt-get install -y tzdata
RUN echo "TZ='Europe/Oslo'" >> /etc/environment
RUN echo "TZ='Europe/Oslo'" >> /usr/local/lib/R/etc/Renviron

# tinytex
#RUN Rscript -e "tinytex::install_tinytex()"
#RUN chmod -R 777 /root/.TinyTeX
#RUN ln -s /root/.TinyTeX/bin/x86_64-linux/* /usr/local/bin && ls -l /usr/local/bin

#RUN echo PATH="/root/.TinyTeX/bin:$PATH" >> /etc/profile

# bcp
RUN echo PATH="$PATH:/opt/mssql-tools/bin" >> /etc/profile
RUN echo export PATH >> /etc/profile
RUN echo Sys.setenv\(PATH=\"$PATH:/opt/mssql-tools/bin\"\) >> /usr/local/lib/R/etc/Rprofile.site

# FONTS
COPY fonts-ubuntu_0.83-4_all.deb /tmp/fonts-ubuntu_0.83-4_all.deb
RUN dpkg -i /tmp/fonts-ubuntu_0.83-4_all.deb

# tinytex needed packages
#RUN tlmgr option repository http://ctan.uib.no/systems/texlive/tlnet
#COPY update-tlmgr-latest.sh /tmp/update-tlmgr-latest.sh
#RUN chmod 777 /tmp/update-tlmgr-latest.sh
#RUN sudo /tmp/update-tlmgr-latest.sh -- --upgrade

#RUN apt-get install -y xzdec
#RUN tlmgr init-usertree

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
  #collection-latexextra
RUN tlmgr update --all

RUN texhash

# include new repo
RUN sed -i "s/mran.microsoft.com/cran.microsoft.com/g" /usr/local/lib/R/etc/Rprofile.site
RUN sed -i "s/CRAN/folkehelseinstituttet=\'https:\\/\\/folkehelseinstituttet.github.io\\/drat\\/\',euromomo=\'https:\\/\\/euromomonetwork.github.io\\/drat\\/\',raubreywhite=\'https:\\/\\/raubreywhite.github.io\\/drat\\/\',CRAN/" /usr/local/lib/R/etc/Rprofile.site
RUN sed -i "1s/^/dratRepo=\'\\/git\\/drat\\/\'\n/" /usr/local/lib/R/etc/Rprofile.site

RUN apt-get update && apt-get install -y \
  libgdal-dev \
  libgeos-c1v5 \
  libproj-dev \
  libgsl0-dev \
  libprotobuf-dev \
  protobuf-compiler \
  ncftp \
  ftp \
  cron \
  sshpass \
  libglu1-mesa-dev \
  freeglut3-dev \
  mesa-common-dev \
  libudunits2-dev \
  libjq-dev \
  libssl-dev \
  libomp-dev \
  tk \
  dvipng \
  tk-dev \
  cargo \
  libnetcdf-dev \
  netcdf-bin \
  libsodium-dev \
  libglpk-dev

# libreoffice
RUN apt-get update && apt-get install -y libreoffice
RUN sudo echo /usr/lib/libreoffice/program/ >> /etc/ld.so.conf.d/local.conf
RUN /sbin/ldconfig

# data.table doesn't like clang
RUN . /etc/environment \
  && install2.r --error --skipinstalled -d TRUE -r $CRAN -n 6 \
    data.table \
    influenceR \
    gower \
    ggrepel \
    lme4 \
    arm \
    gmailr \
    pander \
    httpuv \
    ggpubr \
    rio \
    foreach

#  INLA
RUN R -e "install.packages('INLA', repos=c(getOption('repos'), INLA='https://inla.r-inla-download.org/R/stable'), dep=FALSE)"

RUN apt-get install -y jags

RUN . /etc/environment \
  && install2.r --error --skipinstalled -d TRUE -r $CRAN -n 6 \
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
  && install2.r --error --skipinstalled -d TRUE -r $CRAN -n 6 \
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
    pbapply \
    ncdf4 \
    huxtable \
    svglite \
    shinydashboard \
    rsvg \
    missRanger \
    drc \
    EnvStats \
    RcppRoll \
    mclust \
    mem

RUN . /etc/environment \
  && install2.r --error --skipinstalled -d FALSE -r $CRAN -n 6 \
    DescTools \
    ppcor \
    corpcor \
    GeneNet \
    ggpubr

RUN . /etc/environment \
  && install2.r --error --skipinstalled -d TRUE -r $CRAN -n 6 \
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
    epitrix \
    shinycssloaders \
    globals \
    listenv \
    learnr \
    FluMoDL \
    RODBC

RUN R -e "blogdown::install_hugo()"

env LANG=C.UTF-8 DEBIAN_FRONTEND=noninteractive

# rclone
RUN apt-get update && apt-get install -y \
        curl man-db
RUN curl https://rclone.org/install.sh | sudo bash

RUN mkdir /analyses
RUN mkdir /dropbox
RUN chmod 777 /analyses /dropbox

# preferences to stop timing out
COPY rsession.conf /etc/rstudio/rsession.conf

# miniconda
RUN echo "RETICULATE_MINICONDA_PATH='/miniconda'" >> /usr/local/lib/R/etc/Renviron
#RUN echo "RETICULATE_PYTHON = '/miniconda/bin/python3'" >> /usr/local/lib/R/etc/Renviron
RUN Rscript -e 'reticulate::install_miniconda()'
RUN Rscript -e 'reticulate::conda_remove("r-reticulate")'
RUN Rscript -e 'reticulate::conda_create("r-reticulate",packages=c("python=3.8","numpy"))'
RUN chmod -R 0777 /miniconda
RUN Rscript -e 'reticulate::py_install("marrow.mailer",pip=T)'
# https://github.com/marrow/mailer/issues/87
# RUN source /miniconda/etc/profile.d/conda.sh && conda activate r-reticulate && python -m pip install --upgrade git+https://github.com/LexMachinaInc/mailer.git && python -m pip install --upgrade git+https://github.com/LexMachinaInc/util.git && conda deactivate
# RUN source /miniconda/etc/profile.d/conda.sh && conda activate r-reticulate && conda remove email && conda deactivate
RUN chmod -R 0777 /miniconda

# ssh
RUN mkdir ~/.ssh/
RUN ssh-keyscan github.com >> ~/.ssh/known_hosts

## ADD IN SHINY
RUN sed -i '/^\./d' /rocker_scripts/install_shiny_server.sh
RUN sed -i 's/rstudio}}/rstudio}/g' /rocker_scripts/install_shiny_server.sh
# RUN cat /rocker_scripts/install_shiny_server.sh
RUN /rocker_scripts/install_shiny_server.sh
COPY shiny-server.conf /etc/shiny-server/shiny-server.conf

# shiny for norwegian characters
RUN echo "LANG=en_US.UTF-8" >> /home/shiny/.Renviron


# https://stackoverflow.com/questions/57265913/error-tcp-provider-error-code-0x2746-during-the-sql-setup-in-linux-through-te
# https://askubuntu.com/questions/1233186/ubuntu-20-04-how-to-set-lower-ssl-security-level
RUN sed -i '1 i\openssl_conf = default_conf' /etc/ssl/openssl.cnf
RUN echo "[ default_conf ]" >> /etc/ssl/openssl.cnf
RUN echo "ssl_conf = ssl_sect" >> /etc/ssl/openssl.cnf
RUN echo "[ssl_sect]" >> /etc/ssl/openssl.cnf
RUN echo "system_default = ssl_default_sect" >> /etc/ssl/openssl.cnf
RUN echo "[ssl_default_sect]" >> /etc/ssl/openssl.cnf
RUN echo "MinProtocol = TLSv1.2" >> /etc/ssl/openssl.cnf
RUN echo "CipherString = DEFAULT:@SECLEVEL=1" >> /etc/ssl/openssl.cnf


RUN echo "rstudio ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# need this for tinytex
RUN chmod -R 777 /root

RUN rm -rf /tmp/downloaded_packages

# node & mapshaper
# RUN curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
# RUN sudo apt-get install -y nodejs
# RUN npm update -g mapshaper
