#!/bin/bash

docker run -d -e MARKLOGIC_ADMIN_USERNAME=[[MY_ADMIN_USER]] -e MARKLOGIC_ADMIN_PASSWORD=[[MY ADMIN PASSWORD]] --name cons580-1 -p 5092:5092 --mount src=sem5_cons_volume,target=/var/opt/semaphore,type=volume progress/cons580
 
