#!/bin/bash --login

cd $HOME && \
  umask 000 && \
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
  curl -L https://s.diaspora.software/1t | bash && \
  echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"' >> $HOME/.bashrc && \
  source "/home/diaspora/.rvm/scripts/rvm" && \
  rvm autolibs read-fail && \
  rvm install 2.2 && \
  git clone https://github.com/diaspora/diaspora.git && \
  cd diaspora && \
  git checkout master
