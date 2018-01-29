FROM debian:stretch-slim as build
 
ARG GIT_URL=https://github.com/diaspora/diaspora.git
ARG GIT_BRANCH=master
ARG RUBY_VERSION=2.4
ARG GEM_VERSION=2.6.14
ARG DEBIAN_FRONTEND=noninteractive

COPY run_as_diaspora.sh /run_as_diaspora.sh

# hack to make postgresql-client install work on slim
RUN mkdir -p /usr/share/man/man1 \
    && mkdir -p /usr/share/man/man7

RUN apt-get update && \
	apt-get install -y -qq \
	cmake \
	postgresql-client \
	build-essential \
	libgmp-dev \
	libssl-dev \
	libcurl4-openssl-dev \
	libxml2-dev \
	libxslt-dev \
	imagemagick \
	ghostscript \
	git \
	curl \
	libpq-dev \
	libmagickwand-dev \
	nodejs \
	gawk \
	libreadline6-dev \
	libyaml-dev \
	libsqlite3-dev \
	sqlite3 \
	autoconf \
	libgdbm-dev \
	libncurses5-dev \
	automake \
	bison \
	libffi-dev && \
    adduser --gecos "" --disabled-login --home /home/diaspora diaspora && \
    su diaspora -c '/run_as_diaspora.sh' && \
    rm -rf /home/diaspora/diaspora/.git && \
    chown -R diaspora:diaspora /home/diaspora
	
COPY startup.sh /home/diaspora/startup.sh

FROM debian:stretch-slim

RUN adduser --gecos "" --disabled-login --home /home/diaspora diaspora 

COPY --chown=diaspora:diaspora --from=build /home/diaspora /home/diaspora

# hack to make postgresql-client install work on slim
RUN mkdir -p /usr/share/man/man1 \
    && mkdir -p /usr/share/man/man7

RUN apt-get update && \
        apt-get install -y -qq \
        postgresql-client \
        imagemagick \
        libyaml-0-2 \
        libgmp10 \
        libssl1.0.2 \
        libxml2 \ 
        libxslt1.1 \
        libpq5 \ 
        libmagickwand-6.q16-3 \
        libreadline7 \
        libsqlite3-0 \ 
        libgdbm3 \ 
        libncurses5 \
        ghostscript \
        curl \
        nodejs \
        gawk \
        procps \
        sqlite3 && \
    rm -rf /var/lib/apt/lists /tmp/* /var/tmp/* 

USER diaspora

WORKDIR /home/diaspora/diaspora

CMD ./startup.sh

