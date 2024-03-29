# Progress Software Semaphore 5 Docker Examples

This repository contains examples of building docker (or podman) images and containers for Progress Semaphore 5 using Oracle Enterprise Linux 7. The required software components are not within the repository. Please read the steps below before attempting to build and run the containers.

## Basic Workflow for Containers
The basic workflow for building and running docker containers is as follows:

  1. Gather required software modules (JDK, Semaphore RPMs) and related files (licenses).
     Make sure to use the correct JDK 11 to match your Docker host architecture.
  2. Build the docker image (Dockerfile) or use docker compose. A compose.yml file is provided above the separate image folders.
  3. Build the container container and run.
  4. Stop container and start container in the standard way (docker stop, docker start).

### Build Docker Image
  - Gather Java and Semaphore RPMs and license files needed to build the images. Look in each Dockerfile for requirements. These are examples intended as informational but should be modified. Make sure to use the correct architecture JDK for your images that matches your host architecture (e.g x86_64, aarch64, etc). 
    (Note that at the current time, Classification Server only has an RPM for x86_64 architecture.)
  - Construct the image by running build.sh script.

### Build Docker Container and Run
  - Create a container and start the container using the run.sh script.
    The docker run command creates the container instance and starts it.
  - Use a separate docker volume to mount /var/opt/semaphore/. This will
    ensure that data is preserved when you restart containers. See the run.sh for an example of using an external volume.

### Useful Common Commands

#### Start All Containers using Docker Compose

  - `docker compose create`
  - `docker compose start`
  - `docker compose stop`
  - `docker compose down`

#### List Running Containers
  - `docker ps`

#### List all containers
  - `docker container ls -a`

#### Stop Container
  - `docker stop *container id*`

#### Start Container
  - `docker start *container id*`

#### List all images
  - `docker image ls -a`

#### List all volumes
  - `docker volume ls`

