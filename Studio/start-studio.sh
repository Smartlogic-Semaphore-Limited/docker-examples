#!/bin/bash

function shutdown {
  cd /opt/semaphore/kmm
  export CATALINA_BASE=/opt/semaphore/kmm
  /opt/semaphore/tomcat/bin/shutdown.sh
  cd /opt/semaphore/studio
  export CATALINA_BASE=/opt/semaphore/studio
  /opt/semaphore/tomcat/bin/shutdown.sh
  sleep 100
  exit
}

echo
echo "Starting Semaphore Studio"
echo

trap shutdown SIGHUP SIGINT SIGTERM

cd /opt/semaphore/da
JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto /opt/semaphore/da/bin/start.sh &

export CATALINA_HOME=/opt/semaphore/tomcat

export JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto
cd /opt/semaphore/kmm
SEMAPHORE_WORKBENCH_HOME=/var/opt/semaphore/kmm/data JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto CATALINA_BASE=/opt/semaphore/kmm /opt/semaphore/tomcat/bin/startup.sh

cd /opt/semaphore/studio
JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto CATALINA_BASE=/opt/semaphore/studio /opt/semaphore/tomcat/bin/startup.sh

while true
do
  sleep 1
done
