FROM debian:jessie

RUN apt-get update && \
	apt-get install -y \
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
	rm -rf /var/lib/apt/lists

COPY run_as_diaspora.sh /run_as_diaspora.sh

COPY docker-entrypoint.sh /docker-entrypoint.sh

COPY backup.sh /backup.sh

VOLUME /config

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["run"]
