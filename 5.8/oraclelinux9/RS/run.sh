#!/bin/bash

docker run -d --name rs580-1 -p 5090:5090 --mount src=sem5_rs_volume,target=/var/opt/semaphore,type=volume progress/rs580
 
