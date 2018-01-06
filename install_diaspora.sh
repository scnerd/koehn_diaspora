#!/bin/bash --login

cd $HOME && \
  git clone --branch ${GIT_BRANCH} ${GIT_URL} && \
  cd diaspora && \
  mkdir -p public/uploads/images && \
  gem install bundler && \
  RAILS_ENV=production bin/bundle install --jobs $(nproc) --deployment --without test development --with postgresql && \
  rvm cleanup all
