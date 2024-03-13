#!/bin/bash

function shutdown {
	exit
}

echo "Starting script for Concepts Server"
# Use environment values in config file. Use sed to replace
if [ ! -f ".env-configured" ]; then
	sed -i "s/MARKLOGIC_ADMIN_USERNAME/${MARKLOGIC_ADMIN_USERNAME}/g" /opt/semaphore/concepts/conf/marklogic.properties
	sed -i "s/MARKLOGIC_ADMIN_PASSWORD/${MARKLOGIC_ADMIN_PASSWORD}/g" /opt/semaphore/concepts/conf/marklogic.properties
	touch ".env-configured"
fi

# on first start, let ML complete bootstrap, then connect. Usually about 20 seconds.
# if this doesn't work, restart Concepts Server container. Increase the sleep time
if [ ! -f ".first_start_completed" ]; then
    echo "Sleeping for 1 minutes to allow Marklogic to fully initialize"
	sleep 60
	touch ".first_start_completed"
fi

echo
echo "Starting Semaphore Concepts Server on port 5092"
cd /opt/semaphore/concepts
SEMAPHORE_LOG_DIR=/opt/semaphore/concepts/logs /opt/semaphore/concepts/bin/start.sh
echo

trap shutdown SIGHUP SIGINT SIGTERM

while true
do
  sleep 1
done
