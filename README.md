Dockerized Radiant
=======================

> The repo is adapted from Flavio Barros' excellent [shiny-wordclould](https://github.com/flaviobarros/shiny-wordcloud) example

This repo contains information to setup a dockerized instance of [radiant](https://radiant-rstats/radiant). The radiant docker image is available from [Docker Hub](https://hub.docker.com/r/vnijs/radiant/).

## Install docker

* For Mac: https://docs.docker.com/docker-for-mac/
* For Windows: https://docs.docker.com/docker-for-windows/
* For Linux: https://docs.docker.com/engine/installation/

After installing Docker check that that it is running by typing `docker` in a terminal.

## Run from the Docker Hub image

To run and install the dockerized radiant app on your computer use:

```sh
docker run --rm -p 80:80 vnijs/radiant
```

The app will be avaliable at <a href="http://127.0.0.1/" target="_blank">http://127.0.0.1/</a>

Alternatively, you can clone and run dockerized radiant using the steps below:

## Cloning the repo

The first step is to clone the docker-radiant repo:

```sh
git clone https://github.com/radiant-rstats/docker-radiant.git
```

By default, file uploads are limited to 10MB and R-code in _R > Report_ and _R > Code_ will not be evaluated for security reasons. If you have appropriate security in place you can change these settings by editing `.Rprofile` in the `docker-radiant` repo you cloned. See example changes below:  

```bash
options(radiant.maxRequestSize = -1)  ## no file size limit
options(radiant.report = TRUE)
```

## Building the container

Use the terminal to change the working directory to the location where you cloned the repo. Then build the docker image using:

```sh
docker build -t yourname/radiant .
```

<!-- sudo docker login to login to docker hub and then ... -->
<!-- docker push <hub-user>/<repo-name> to push to docker hub -->

If you need to update your container, e.g., to get the latest version of radiant, just rerun the command above. 

Note that creating the container will take some time as it has to pull and install ubuntu, R, shiny-server, etc. as well as all required R-packages

If the build fails for some reason you can remove it using:

```sh
docker rmi yourname/radiant
```

## Run the app

To run the dockerized radiant app on your computer use:

```sh
docker run --rm -p 80:80 yourname/radiant
```

The app will be avaliable at <a href="http://127.0.0.1/" target="_blank">http://127.0.0.1/</a>

To run the container on another port, e.g., 3838, you can use:

```sh
docker run --rm -p 3838:80 yourname/radiant
```

## Trouble shooting

If something went wrong you can access the container through the bash shell using:

```sh
docker run -t -i yourname/radiant /bin/bash
```
