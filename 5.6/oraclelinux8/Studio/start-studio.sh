#!/bin/bash

function shutdown {
  cd /opt/semaphore/kmm
  export CATALINA_BASE=/opt/semaphore/kmm
  /opt/semaphore/tomcat/bin/shutdown.sh
  sleep 100 
  pkill java
  sleep 10 
  exit
}

echo
echo "Starting Semaphore Studio"
echo

trap shutdown SIGHUP SIGINT SIGTERM

# Unpack the tarball under /var/opt/semaphore if studio folder does not exist (for bind mounts).
[ ! -d "/var/opt/semaphore/studio/" ] && tar xvzf /sem_var_opt_sem.tgz
# Unpack the tarball under /etc/opt/semaphore if studio folder does not exist (for bind mounts).
[ ! -d "/etc/opt/semaphore/studio/" ] && tar xvzf /sem_etc_opt_sem.tgz

# Start services
cd /opt/semaphore/da
JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto /opt/semaphore/da/bin/start.sh &

cd /opt/semaphore/rm
JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto /opt/semaphore/rm/bin/start.sh &

cd /opt/semaphore/sm
JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto /opt/semaphore/sm/bin/start.sh &

export CATALINA_HOME=/opt/semaphore/tomcat
export JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto

cd /opt/semaphore/kmm
SEMAPHORE_WORKBENCH_HOME=/var/opt/semaphore/kmm/data JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto CATALINA_BASE=/opt/semaphore/kmm /opt/semaphore/tomcat/bin/startup.sh

cd /opt/semaphore/studio
JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto /opt/semaphore/studio/bin/start.sh &

cd /opt/semaphore

if [ ! -f ".env_configured" ]; then
  sleep 30
  /opt/semaphore/upload-license.sh &> upload-license.log
  /opt/semaphore/create-ses-service.sh &> create-ses-service.log
  /opt/semaphore/create-cs-service.sh &> create-cs-service.log
  /opt/semaphore/add-superadmin-publish-permission.sh &> add-superadmin-publish-permission.log
  touch ".env_configured"
fi

while true
do
  sleep 1
done
