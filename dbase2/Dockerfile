#FROM registry.access.redhat.com/ubi8/ubi-init:latest
FROM quay.io/centos/centos:stream8
ARG R_VERSION=4.0.4
ARG CRAN_CHECKPOINT=https://packagemanager.rstudio.com/all/766976

ENV R_HOME="/opt/R/${R_VERSION}/lib/R"

# Locale configuration --------------------------------------------------------#
RUN dnf -y install glibc-locale-source
RUN localedef -i en_US -f UTF-8 en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Set default timezone
ENV TZ UTC

RUN dnf install -y epel-release
RUN dnf config-manager --set-enabled powertools
RUN dnf install -y --disableplugin=subscription-manager sudo

RUN dnf -y update && \
    dnf -y install \
    fontconfig \
    glibc-langpack-en \
    perl-Digest-MD5 \
    perl-Getopt-Long \
    sudo \
    vim \
    wget && \
    dnf clean all

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
RUN wget https://cdn.rstudio.com/r/centos-8/pkgs/R-${R_VERSION}-1-1.x86_64.rpm && \
    dnf -y install ./R-${R_VERSION}-1-1.x86_64.rpm && \
    ln -s /opt/R/${R_VERSION}/bin/R /usr/bin/R && \
    ln -s /opt/R/${R_VERSION}/bin/Rscript /usr/bin/Rscript && \
    ln -s /opt/R/${R_VERSION}/lib/R /usr/lib/R && \
    rm R-${R_VERSION}-1-1.x86_64.rpm && \
    dnf clean all
RUN  ln -s /opt/R/${R_VERSION}/lib/R/lib/libRblas.so /usr/lib64/

# Install stuff
RUN dnf -y update && \
    dnf -y install \
    openssl-devel \
    libxml2-devel \
    fontconfig-devel \
    libgit2-devel \
    harfbuzz-devel \
    fribidi-devel \
    freetype-devel \
    libpng-devel \
    libtiff-devel \
    libjpeg-turbo-devel \
    unixODBC-devel \
    cairo-devel \
    libsodium-devel \
    xz \
    bzip2 \
    ca-certificates \
    git \
    openssl-devel \
    libuser \
    rrdtool \
    git \
    # gdal-dev \
    geos \
    proj-devel \
    protobuf-compiler \
    ncftp \
    ftp \
    sshpass \
    udunits2-devel \
    tk \
    dvipng \
    tk-devel \
    cargo \
    netcdf-devel \
    netcdf \
    glpk-devel \
    && \
    dnf clean all

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

CMD ["R"]
