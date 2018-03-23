#!/bin/bash --login

set -e

cd /home/diaspora

umask 000

curl -sSL https://rvm.io/mpapis.asc | gpg --import -

curl -L https://s.diaspora.software/1t | bash

echo '[[ -s "/home/diaspora/.rvm/scripts/rvm" ]] && source "/home/diaspora/.rvm/scripts/rvm"' >> /home/diaspora/.bashrc
source "/home/diaspora/.rvm/scripts/rvm"
rvm autolibs read-fail
rvm install ${RUBY_VERSION} 

git clone --branch ${GIT_BRANCH} --single-branch ${GIT_URL}
cd diaspora

mkdir -p public/uploads/images

gem update --system ${GEM_VERSION}
gem install bundler
bin/bundle config --local build.sigar '--with-cppflags="-fgnu89-inline"'
gem uninstall sigar
RAILS_ENV=production bin/bundle install --no-cache --deployment --without test development --with postgresql
rvm cleanup all

tar czf public/source.tar.gz  $(git ls-tree -r ${GIT_BRANCH} | awk '{print $4}')

cp /diaspora.yml config/
cp config/database.yml.example config/database.yml
RAILS_ENV=production bin/rake assets:precompile
rm config/diaspora.yml config/database.yml

rm -rf /home/diaspora/diaspora/tmp

ln -s /tmp /home/diaspora/.eye
ln -s /tmp /home/diaspora/diaspora/tmp
