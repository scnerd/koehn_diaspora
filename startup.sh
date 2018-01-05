#!/bin/bash --login

cd diaspora

RAILS_ENV=production bin/rake db:migrate
script/server
