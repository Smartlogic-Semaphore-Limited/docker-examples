#!/bin/bash

function shutdown {
	echo
	echo "Stopping Semaphore Semantic Enhancement Server"
	/opt/semaphore/SES/bin/SESservice.sh stop -force
	echo

	exit
}

echo
echo "Starting Semaphore Semantic Enhancement Server on port 8983"
/opt/semaphore/SES/bin/SESservice.sh start -c -force
echo

trap shutdown SIGHUP SIGINT SIGTERM

while true
do
  sleep 1
done
