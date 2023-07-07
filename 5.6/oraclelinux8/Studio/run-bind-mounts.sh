#!/bin/bash

docker run -d --name studio563-1 -p 5080:5080 \
  --mount src="$(pwd)/var_opt_sem",target=/var/opt/semaphore,type=bind \
  --mount src="$(pwd)/etc_opt_sem",target=/etc/opt/semaphore,type=bind \
  progress/studio563
