#!/bin/bash

function shutdown {
	exit
}

echo
echo "Starting Semaphore Reconciliation Server on port 5090"
cd /opt/semaphore/rs
SEMAPHORE_LOG_DIR=/opt/semaphore/rs/logs /opt/semaphore/rs/bin/start.sh
echo

trap shutdown SIGHUP SIGINT SIGTERM

while true
do
  sleep 1
done
