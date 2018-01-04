FROM koehn/diaspora:latest

COPY database.yml /home/diaspora/diaspora/config
COPY diaspora.yml /home/diaspora/diaspora/config

WORKDIR /home/diaspora

RUN /bin/bash -lc 'cd diaspora && RAILS_ENV=production bin/rake assets:precompile'