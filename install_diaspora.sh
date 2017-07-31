#!/bin/bash --login

cd $HOME && \
  git clone --branch master https://github.com/diaspora/diaspora.git && \
  cd diaspora && \
  gem install bundler && \
  RAILS_ENV=production bin/bundle install --jobs $(nproc) --deployment --without test development --with postgresql && \
  rvm cleanup all
