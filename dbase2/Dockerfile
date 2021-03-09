#FROM registry.access.redhat.com/ubi8/ubi-init:latest
FROM quay.io/centos/centos:stream8
ARG R_VERSION=4.0.4
ARG CRAN_CHECKPOINT=https://packagemanager.rstudio.com/all/766976

ENV R_HOME="/opt/R/${R_VERSION}/lib/R"
# Set default locale
ENV LANG en_US.UTF-8

# Set default timezone
ENV TZ UTC

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

CMD ["R"]
