# diaspora-docker

This project allows you to quickly and easily set up a Diaspora pod on a local
node running inside a collection of Docker containers. It allows users to run
Diaspora with a minimum of system administration, and a minimum of knowledge
of Unix, databases, web servers, etc. 

# To use this project:

1. Install Docker (Note: on macOS, do *not* use Docker Toolbox, but 
instead use [Docker for Mac](https://docs.docker.com/docker-for-mac/docker-toolbox/#/the-docker-for-mac-environment)).

2. Install Docker Compose. 

2. Install Git. Future versions of this application will come in downloadable 
form, but for now this is a must. (**Note:** you can download the [latest 
release](https://gitlab.koehn.com/bkoehn/diaspora-docker/repository/archive.zip?ref=master)
of Diaspora Docker without using Git. But upgrades are much, much harder.)

3. Clone this repository (https://gitlab.koehn.com/bkoehn/diaspora-docker.git).

4. Run `docker build .` from the project's main directory.

5. Download (or preferably, fork) your own copy of diaspora to a local directory.

6. Set up a database, redis, etc (see the `docker-compose.yml` for an easy way to do this).

7. Configure diaspora to use the database, redis, etc you set up above.
