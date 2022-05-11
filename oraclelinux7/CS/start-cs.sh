#!/bin/bash

function shutdown {
	exit
}

echo
echo "Starting Semaphore Classification Server on port 5058"
/opt/semaphore/CS/bin/ClassificationServer --daemon --nouserswap
echo

trap shutdown SIGHUP SIGINT SIGTERM

while true
do
  sleep 1
done
