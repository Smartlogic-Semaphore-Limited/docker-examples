#!/bin/bash

docker run -d --name studio505-1 -p 5080:5080 --mount src=sem5_studio_volume,target=/var/opt/semaphore,type=volume studio505 
 
