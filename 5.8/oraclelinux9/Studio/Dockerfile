FROM oraclelinux:9

LABEL maintainer="Smartlogic Semaphore Ltd"
LABEL sem5-version="5.8.0"

# Copy local RPMs and licence file to image
RUN mkdir /local-rpms/
COPY *.rpm /local-rpms/

# Get CentOS updates and install rpms, and clean up.
RUN yum -y --setopt=tsflags=nodocs update && \
    yum install -y --setopt=tsflags=nodocs patch && \
    yum install -y util-linux-user && \
    yum install -y jq && \
    yum install -y less && \
    yum install -y --setopt=tsflags=nodocs /local-rpms/java-11-amazon-corretto-devel-11.*.*.rpm && \
    yum install -y /local-rpms/Semaphore-Studio-5.8.0-1.noarch.rpm && \
    yum install -y tar && \
    yum clean all

# Default authentication file
COPY --chown=semaphore studio-authentication.properties /opt/semaphore/studio/conf/studio-authentication.properties

#Copy in the daemon creation script and start script
COPY --chown=semaphore start-studio.sh /opt/semaphore

#Copy the studio configuration scripts and licence file to image
COPY --chown=semaphore create-ses-service.sh /opt/semaphore
COPY --chown=semaphore create-ml-service.sh /opt/semaphore
COPY --chown=semaphore create-cons-service.sh /opt/semaphore
COPY --chown=semaphore create-cs-service.sh /opt/semaphore
COPY --chown=semaphore add-superadmin-publish-permission.sh /opt/semaphore
COPY --chown=semaphore upload-license.sh /opt/semaphore
COPY --chown=semaphore login-get-cookie.sh /opt/semaphore
COPY licence /opt/semaphore

# make scripts executable
RUN chmod 777 /opt/semaphore/start-studio.sh
RUN chmod 777 /opt/semaphore/create-ses-service.sh
RUN chmod 777 /opt/semaphore/create-ml-service.sh
RUN chmod 777 /opt/semaphore/create-cons-service.sh
RUN chmod 777 /opt/semaphore/create-cs-service.sh
RUN chmod 777 /opt/semaphore/upload-license.sh
RUN chmod 777 /opt/semaphore/login-get-cookie.sh
RUN chmod 777 /opt/semaphore/add-superadmin-publish-permission.sh

# TAR the directories and files under /var/opt/semaphore and /etc/opt/semaphore
# so we can initialize bind mounts if necessary. Still works with docker volumes.
RUN cd / && tar cvzf sem_var_opt_sem.tgz /var/opt/semaphore/ && tar cvzf sem_etc_opt_sem.tgz /etc/opt/semaphore/

# set path environment variable
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/semaphore

# external volumes off union filesystem
VOLUME ["/var/opt/semaphore"]
VOLUME ["/etc/opt/semaphore"]

# Export Studio port 5080
EXPOSE 5080
CMD ["/opt/semaphore/start-studio.sh"]
