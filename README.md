# Smartlogic Semaphore 5 Docker Examples

This repository contains examples of building docker (or podman) images and containers for Smartlogic Semaphore 5. The required software components are not within the repository. Please read the steps below before attempting to build and run the containers.

## Basic Workflow for Containers
The basic workflow for building and running docker containers is as follows:

  1. Gather required software modules (RPMs) and related files (licenses).
  2. Build the docker image (Dockerfile)
  3. Build the container container and run.
  4. Stop container and start container in the standard way (docker stop, docker start).

### Build Docker Image
  - Gather Java and Smartlogic RPMs and license files needed to build the images. Look in each Dockerfile for requirements. These are examples intended as informational but should be modified.
  - Construct the image by running build.sh script.

### Build Docker Container and Run
  - Create a container and start the container using the run.sh script.
    The docker run command creates the container instance and starts it.
  - Use a separate docker volume to mount /var/opt/semaphore/. This will
    ensure that data is preserved when you restart containers. See the run.sh for an example of using an external volume.

### Useful Common Commands

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
