# diaspora-docker

This project allows you to quickly and easily set up a Diaspora pod on a local
node running inside a collection of Docker containers. It allows users to run
Diaspora with a minimum of system administration, and a minimum of knowledge
of Unix, databases, web servers, etc. 

# To use this project:

1. Install Docker (Note: on macOS, do *not* use Docker Toolbox, but 
instead use [Docker for Mac](https://docs.docker.com/docker-for-mac/docker-toolbox/#/the-docker-for-mac-environment)).

2. Install Docker Compose. 

3. Run `docker pull koehn/diaspora:latest` to use an image pre-built from the latest Diaspora source code. You can build your own

4. Set up a database, redis, etc (see the [compose directory](https://gitlab.koehn.com/bkoehn/diaspora-docker/tree/master/compose) for an easy way to do this). 

5. Configure diaspora to use the database, redis, etc you set up above. Again, the [docker-compose configuration](https://gitlab.koehn.com/bkoehn/diaspora-docker/tree/master/compose) file does this all for you. 
