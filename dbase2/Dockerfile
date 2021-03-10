FROM ubuntu:focal
ARG R_VERSION=4.0.4
ARG CRAN_CHECKPOINT=https://packagemanager.rstudio.com/all/766976

ENV R_HOME="/opt/R/${R_VERSION}/lib/R"
ENV OS_IDENTIFIER=ubuntu-2004
ENV DEBIAN_FRONTEND noninteractive

# Locale configuration --------------------------------------------------------#
RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    glibc-locale-source
#RUN localedef -i en_US -f UTF-8 en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Set default timezone
ENV TZ UTC

RUN dnf install -y dnf-plugins-core
RUN dnf install -y epel-release
RUN dnf module -y enable nodejs:13
RUN dnf config-manager --set-enabled powertools
RUN dnf install -y --disableplugin=subscription-manager sudo

RUN apt-get install -y \
    apt-transport-https \
    curl \
    fontconfig \
    libcurl4-openssl-dev \
    locales \
    perl \
    sudo \
    tzdata \
    wget \
    vim && \
    rm -rf /var/lib/apt/lists/*

# Install TinyTeX
RUN wget -qO- "https://yihui.org/tinytex/install-bin-unix.sh" | sh && \
    /root/.TinyTeX/bin/*/tlmgr path remove && \
    mv /root/.TinyTeX/ /opt/TinyTeX && \
    /opt/TinyTeX/bin/*/tlmgr option sys_bin /usr/local/bin && \
    /opt/TinyTeX/bin/*/tlmgr path add

# Install pandoc
RUN mkdir -p /opt/pandoc && \
    wget -O /opt/pandoc/pandoc.gz https://files.r-hub.io/pandoc/linux-64/pandoc.gz && \
    gzip -d /opt/pandoc/pandoc.gz && \
    chmod +x /opt/pandoc/pandoc && \
    ln -s /opt/pandoc/pandoc /usr/bin/pandoc && \
    wget -O /opt/pandoc/pandoc-citeproc.gz https://files.r-hub.io/pandoc/linux-64/pandoc-citeproc.gz && \
    gzip -d /opt/pandoc/pandoc-citeproc.gz && \
    chmod +x /opt/pandoc/pandoc-citeproc && \
    ln -s /opt/pandoc/pandoc-citeproc /usr/bin/pandoc-citeproc

# Install R
RUN wget https://cdn.rstudio.com/r/${OS_IDENTIFIER}/pkgs/r-${R_VERSION}_1_amd64.deb && \
    apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -f -y ./r-${R_VERSION}_1_amd64.deb && \
    ln -s /opt/R/${R_VERSION}/bin/R /usr/bin/R && \
    ln -s /opt/R/${R_VERSION}/bin/Rscript /usr/bin/Rscript && \
    ln -s /opt/R/${R_VERSION}/lib/R /usr/lib/R && \
    rm r-${R_VERSION}_1_amd64.deb && \
    rm -rf /var/lib/apt/lists/*
#RUN  ln -s /opt/R/${R_VERSION}/lib/R/lib/libRblas.so /usr/lib64/

# Install stuff
RUN apt-get update && apt-get install -y \
  git \
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

# install2.r
COPY install2.r /usr/local/bin/install2.r

# Rprofile.site - change the repos from default
# Add drat repo on first line
RUN echo 'dratRepo="/git/drat/"' >> $R_HOME/etc/Rprofile.site
# Add our repo list on second line
RUN echo "options(repos = c(folkehelseinstituttet='https://folkehelseinstituttet.github.io/drat/',euromomo='https://euromomonetwork.github.io/drat/',raubreywhite='https://raubreywhite.github.io/drat/',CRAN = '$CRAN_CHECKPOINT'), download.file.method = 'libcurl')" >> $R_HOME/etc/Rprofile.site

RUN Rscript -e "install.packages(c('littler','docopt'))"
RUN ln -s $R_HOME/library/littler/bin/r /usr/local/bin/r

RUN install2.r --error --skipinstalled -d TRUE -n 6 \
    tinytex \
    devtools

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

# data.table doesn't like clang
RUN install2.r --error --skipinstalled -d TRUE -n 6 \
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

RUN install2.r --error --skipinstalled -d TRUE -n 6 \
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

RUN install2.r --error --skipinstalled -d TRUE -n 6 \
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

RUN install2.r --error --skipinstalled -d FALSE -n 6 \
    DescTools \
    ppcor \
    corpcor \
    GeneNet \
    ggpubr

RUN install2.r --error --skipinstalled -d TRUE -n 6 \
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
    RODBC \
    tableHTML \
    htmlTable \
    qs \
    distill \
    testthat \
    progressr \
    XML \
    encryptr

#RUN install2.r --error --skipinstalled -d TRUE -n 6 \
#    rstan \
#    shinystan \

#  INLA
# RUN R -e "install.packages('INLA', repos=c(getOption('repos'), INLA='https://inla.r-inla-download.org/R/stable'), dep=FALSE)"

CMD ["R"]
