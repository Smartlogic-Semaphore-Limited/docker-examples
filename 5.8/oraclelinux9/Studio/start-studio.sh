#!/bin/bash

function shutdown {
  pkill -15 java
  sleep 10 
  exit
}

# copy over username and password (one time) before starting studio
cd /opt/semaphore
if [ ! -f ".user_configured" ]; then
  sed -i "s/SEMAPHORE_ADMIN_USERNAME/${SEMAPHORE_ADMIN_USERNAME}/g" /opt/semaphore/studio/conf/studio-authentication.properties
  sed -i "s/SEMAPHORE_ADMIN_PASSWORD/${SEMAPHORE_ADMIN_PASSWORD}/g" /opt/semaphore/studio/conf/studio-authentication.properties
  touch ".user_configured"
fi

echo
echo "Starting Semaphore Studio"
echo

trap shutdown SIGHUP SIGINT SIGTERM

cd /
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

echo "${MARKLOGIC_ADMIN_USERNAME}" >> log.txt
echo "${MARKLOGIC_ADMIN_USERNAME}:${MARKLOGIC_ADMIN_PASSWORD}@marklogic://ml11-1:8000/Documents" >> log.txt

cd /opt/semaphore/kmm
SEMAPHORE_DEFAULT_BACKEND=MARKLOGIC \
SEMAPHORE_MARKLOGIC_CONFIG="${MARKLOGIC_ADMIN_USERNAME}:${MARKLOGIC_ADMIN_PASSWORD}@marklogic://ml11-1:8000/Documents" \
SEMAPHORE_LICENCE_DIR=/opt/semaphore/studio/licenses \
SEMAPHORE_KMM_DIR=/opt/semaphore/kmm \
SEMAPHORE_LOG_DIR=/opt/semaphore/kmm/logs \
SEMAPHORE_WORKBENCH_HOME=/var/opt/semaphore/kmm/data \
JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto \
/opt/semaphore/kmm/bin/start.sh &

cd /opt/semaphore/studio
JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto /opt/semaphore/studio/bin/start.sh &

cd /opt/semaphore

if [ ! -f ".env_configured" ]; then
  sleep 30
  /opt/semaphore/login-get-cookie.sh &> login-get-cookie.log
  /opt/semaphore/upload-license.sh &> upload-license.log
  /opt/semaphore/create-ml-service.sh &> create-ml-service.log
  /opt/semaphore/create-cons-service.sh &> create-cons-service.log
  /opt/semaphore/create-ses-service.sh &> create-ses-service.log
  /opt/semaphore/create-cs-service.sh &> create-cs-service.log
  /opt/semaphore/add-superadmin-publish-permission.sh &> add-superadmin-publish-permission.log
  touch ".env_configured"
fi

while true
do
  sleep 1
done
