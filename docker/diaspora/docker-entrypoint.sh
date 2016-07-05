#!/bin/bash --login 

USER_ID=${HOST_UID:=1000}
GROUP_ID=${HOST_GID:=1000}
echo "Starting with UID : $USER_ID"
echo "Starting with GID : $GROUP_ID"

addgroup --gid "$GROUP_ID" diaspora
adduser --gecos "" --disabled-login --uid "$USER_ID" --gid "$GROUP_ID" --home /home/diaspora diaspora

function do_as_diaspora {
	su -l -c "cd /home/diaspora/diaspora && RAILS_ENV=production DB=postgres $1" diaspora
}

function setup {
	su -l diaspora -c "/run_as_diaspora.sh"
}

function run {
	echo "Staring Diaspora"
	do_as_diaspora "./script/server"
}

function bundle {
	do_as_diaspora "gem install bundler"
	do_as_diaspora "bin/bundle install --without test development" ||	do_as_diaspora "bin/bundle install --without test development"
}

function init_db {
	do_as_diaspora "bin/rake db:create db:schema:load" && \
	  precompile_assets
}

function precompile_assets {
	do_as_diaspora "bin/rake assets:precompile"
}

function cat {
	if [ ! -z "$1" ]; then
		cat > $1
	fi
}

echo "Starting docker-entrypoint with argument '$1'"

if [ "$1" = 'run' ]; then
	run
elif [ "$1" = 'bundle' ]; then
	bundle
elif [ "$1" = 'cat' ]; then
	cat $2
elif [ "$1" = 'setup' ]; then
	setup
elif [ "$1" = 'init-db' ]; then
	init_db
elif [ "$1" = 'precompile' ]; then
	precompile_assets
elif [ "$1" = 'upgrade' ]; then
	do_as_diaspora "rvm update"
	do_as_diaspora "git checkout Gemfile.lock db/schema.rb && git pull && cd .. && cd - && gem install bundler && bin/bundle && bin/rake db:migrate "
	precompile_assets
else
	echo "Not sure what to do; here have a shell"
	/bin/bash
fi

