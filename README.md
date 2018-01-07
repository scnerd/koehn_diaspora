# diaspora-docker

This project allows you to quickly and easily set up a Diaspora pod running inside a 
collection of Docker containers. It allows users to run
Diaspora with a minimum of system administration, and a minimum of knowledge
of Unix, databases, web servers, etc. 

# To use this project

1. Install Docker and (optionally) install Docker Compose. 

3. Run `docker pull koehn/diaspora:latest` to use an image pre-built from the latest Diaspora source code. 

4. Set up a database, redis, etc (see the [compose directory](https://gitlab.koehn.com/bkoehn/diaspora-docker/tree/master/compose) for an easy way to do this). 

5. Configure diaspora to use the database, redis, etc you set up above. Again, the [docker-compose configuration](https://gitlab.koehn.com/bkoehn/diaspora-docker/tree/master/compose) file does this all for you. 

# What this project does

This project builds an image that follows the [official wiki instructions](https://wiki.diasporafoundation.org/Installation/Debian/Jessie)
for installing Diaspora on Debian. By default, it uses the [current Diaspora code](https://github.com/diaspora/diaspora/tree/master)
to drive the installation process, but you can build an image based off of another 
repository/branch; see below for more information about building custom images. 

The resulting image will include all the diaspora code, RVM, Postgres Driver, package dependencies, 
Ruby Gems, etc. It creates and uses a `diaspora` user in the image, under which the
code is actually run. All you need to supply is a database and redis server (again,
using the files supplied in the [compose directory](https://gitlab.koehn.com/bkoehn/diaspora-docker/tree/master/compose)
is the simplest way to go about this). 

# Upgrading

When a new version of Diaspora is released, I publish a new image to [Docker Hub](https://hub.docker.com/r/koehn/diaspora/).
You can pull the latest version into your machine using `docker pull koehn/diaspora`. 
The next time you start your application you'll get the latest build, and the latest set
of database migrations will be installed automatically.

# Customizing your own image

The Dockerfile accepts several build arguments to customize the build:

`GIT_URL`
: Specifies the repository from which the Diaspora code should be cloned. Defaults to
the official Diaspora Git Repository (https://github.com/diaspora/diaspora.git)

`GIT_BRANCH`
: Specifies the branch or tag to be checked out from the above repository. Defaults to
`master`

`RUBY_VERSION`
: The version of Ruby to be installed by RVM. Defaults to `2.4.1` per the installation
instructions. 

`GEM_VERSION`
: The version of Gem to be installed. Defaults to `2.6.14` per the installation instructions. 

These arguments allow you to use your own version of Diaspora and its tooling to make
your own images. When building your image with `docker build`, simply specify the values
you want with `--build-arg [argument]=[value]` e.g., 
`docker build --build-arg GIT_BRANCH=develop .`. 

# How "official" images are produced

When a new version of Diaspora is released, I run this build and specify a `GIT_BRANCH` 
corresponding to the tag of the release. I then publish the build into my own personal
repository on Docker Hub, tagged with that version and `latest`. There's currently no 
automation behind this; I just notice that a new build was released and create a corresponding
new image. 
