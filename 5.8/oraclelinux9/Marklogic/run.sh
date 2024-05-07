#!/bin/bash

docker run -d --platform "linux/amd64" --name ml11-1 -p 8000:8000 -p 8001:8001 -p 8002:8002 --mount src=ml11_var_volume,target=/var/opt/MarkLogic,type=volume progress/marklogicdb:latest 
 
