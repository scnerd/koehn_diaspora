FROM debian:jessie-backports

ARG GIT_URL=https://github.com/diaspora/diaspora.git
ARG GIT_BRANCH=master
ARG RUBY_VERSION=2.4.1
ARG DEBIAN_FRONTEND=noninteractive

COPY run_as_diaspora.sh /run_as_diaspora.sh
COPY install_diaspora.sh /install_diaspora.sh

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
    su diaspora -c 'cd /home/diaspora && /run_as_diaspora.sh' && \
    su diaspora -c 'cd /home/diaspora && /install_diaspora.sh' && \
    chown -R diaspora:diaspora /home/diaspora/diaspora && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists /tmp/* /var/tmp/* /run_as_diaspora.sh /install_diaspora.sh
	
USER diaspora

COPY startup.sh /home/diaspora/startup.sh

WORKDIR /home/diaspora/diaspora

CMD ./startup.sh
