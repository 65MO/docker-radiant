FROM r-base:latest

MAINTAINER Vincent Nijs "radiant@rady.ucsd.edu"

RUN apt-get update && apt-get install -y \
    sudo \
    git \
    gdebi-core \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev/unstable \
    libxt-dev \
    libssl-dev \
    libxml2-dev \
    libnlopt-dev

# Download and install shiny server
RUN wget --no-verbose https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/VERSION -O "version.txt" && \
    VERSION=$(cat version.txt)  && \
    wget --no-verbose "https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/shiny-server-$VERSION-amd64.deb" -O ss-latest.deb && \
    gdebi -n ss-latest.deb && \
    rm -f version.txt ss-latest.deb

RUN R -e "install.packages('radiant', repos = c('https://radiant-rstats.github.io/minicran/', 'https://cloud.r-project.org', 'https://cran.r-project.org'))"

COPY shiny-server.conf  /etc/shiny-server/shiny-server.conf
RUN git clone https://github.com/radiant-rstats/radiant.git /srv/shiny-server/radiant/

EXPOSE 80

COPY shiny-server.sh /usr/bin/shiny-server.sh

CMD ["/usr/bin/shiny-server.sh"]
