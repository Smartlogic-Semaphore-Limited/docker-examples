#!/bin/bash

docker run -d --name studio580-1 -p 5080:5080 \
	-e SEMAPHORE_ADMIN_USERNAME=[[MY USER]] \
	-e SEMAPHORE_ADMIN_PASSWORD=[[MY PWD]] \
	--mount src=sem5_studio_var_volume,target=/var/opt/semaphore,type=volume \
	--mount src=sem5_studio_etc_volume,target=/etc/opt/semaphore,type=volume \
	progress/studio580
