# diaspora-docker

This project allows you to quickly and easily set up a Diaspora pod on a local
node running inside a collection of Docker containers. It allows users to run
Diaspora with a minimum of system administration, and a minimum of knowledge
of Unix, databases, web servers, etc. 

# To use this project:

1. Install Docker (Note: on macOS, do *not* use Docker Toolbox, but 
instead use [Docker for Mac](https://docs.docker.com/docker-for-mac/docker-toolbox/#/the-docker-for-mac-environment)).

2. Install Git. Future versions of this application will come in downloadable 
form, but for now this is a must. 

3. Clone this repository (https://gitlab.koehn.com/bkoehn/diaspora-docker.git).

4. Open a terminal window in the `docker-diaspora` directory you just cloned.

5. Run the following commands (Unix; a script is coming that will help you through
this on Unix and Windows):

````    rm -rf data/diaspora
    mkdir -p data/diaspora
    cd docker
    export HOST_UID=$(id -u)
    export HOST_GID=$(id -g)
    docker-compose build````

6. In the `data/diaspora` directory you'll find the Diaspora home directory. 
In the `data/diaspora/diaspora` directory you'll find the Diaspora codebase. 
There are a few files you **must** create:

* `data/diaspora/diaspora/config/database.yml`: This file must be copied from the
`docker/diaspora/test/database.yml` file. You shouldn't need to make any changes to it. 

* `data/diaspora/diaspora/config/diaspora.yml`: This file should probably be 
copied from the `docker/diaspora/test/diaspora.yml` file, but you **must** edit
it. Specifically, if you want your pod to work at all, you must set the `url`
property near the top of the file to a publically-accessible URL to your pod
**before continuing** or you will need to start over and create a new pod and
users. If you don't know how to do this, you can use the pod for testing
purposes, but it won't be able to receive communications from other pods. 

7. From the `docker` directory, run `docker-compose run diaspora setup` which
will setup your pods code. 

8. Again from the `docker` directory, run `docker-compose run diaspora bundle`
which will download and install a bunch of code diaspora needs to run. 

9. Fron the `docker` directory, run `docker-compose run diaspora init-db` which 
sets up the database based on the information you put in the `diaspora.yml` file
above. 

# To run diaspora

When all the other steps have completed successfully, you can start your pod
from the `docker` directory by running `docker-compose up`. It takes anywhere
from a few seconds to a few minutes to get running. 
