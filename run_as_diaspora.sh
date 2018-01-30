#!/bin/bash --login

cd /home/diaspora && \
  umask 000 && \
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
  curl -L https://s.diaspora.software/1t | bash && \
  echo '[[ -s "/home/diaspora/.rvm/scripts/rvm" ]] && source "/home/diaspora/.rvm/scripts/rvm"' >> /home/diaspora/.bashrc && \
  source "/home/diaspora/.rvm/scripts/rvm" && \
  rvm autolibs read-fail && \
  rvm install ${RUBY_VERSION} -j $(nproc) && \
  git clone --branch ${GIT_BRANCH} ${GIT_URL} && \
  cd diaspora && \
  mkdir -p public/uploads/images && \
  gem update --system ${GEM_VERSION} && \
  gem install bundler && \
  bin/bundle config --local build.sigar '--with-cppflags="-fgnu89-inline"' && \
  gem uninstall sigar && \
  RAILS_ENV=production bin/bundle install --jobs $(nproc) --deployment --without test development --with postgresql && \
  rvm cleanup all && \
  tar czf public/source.tar.gz  $(git ls-tree -r ${GIT_BRANCH} | awk '{print $4}') && \
  cp /diaspora.yml config/ && \
  cp config/database.yml.example config/database.yml && \
  RAILS_ENV=production bin/rake assets:precompile && \
  rm config/diaspora.yml config/database.yml
