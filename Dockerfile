FROM debian:jessie-backports

ARG GIT_URL=https://github.com/diaspora/diaspora.git

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
	libffi-dev

RUN adduser --gecos "" --disabled-login --home /home/diaspora diaspora
	
COPY run_as_diaspora.sh /run_as_diaspora.sh
COPY install_diaspora.sh /install_diaspora.sh

USER diaspora

RUN cd /home/diaspora && \
    /run_as_diaspora.sh

RUN cd /home/diaspora && \
    /install_diaspora.sh

USER root

RUN chown -R diaspora:diaspora /home/diaspora/diaspora && \
#    apt-get remove -y -qq \
#    cmake \
#    build-essential \
#    git \
#    autoconf ** && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists /tmp/* /var/tmp/*

USER diaspora

copy startup.sh /home/diaspora/startup.sh
