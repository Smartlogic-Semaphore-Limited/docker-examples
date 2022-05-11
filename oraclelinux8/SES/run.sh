#!/bin/bash

docker run -d --name ses540-1 -p 8983:8983 -p 9983:9983 --mount src=sem5_ses_volume,target=/var/opt/semaphore,type=volume ses540
 
