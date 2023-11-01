#!/bin/bash

docker run -d --name cs564-1 -p 5058:5058 -p 5059:5059 --mount src=sem5_cs_volume,target=/var/opt/semaphore,type=volume progress/cs564
 
