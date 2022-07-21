FROM oraclelinux:8

LABEL maintainer="Smartlogic Semaphore Ltd"
LABEL sem5-version="5.4.1"

# Copy local RPMs and licence file to image
RUN mkdir /local-rpms/
COPY *.rpm /local-rpms/

# Get CentOS updates and install rpms, and clean up.
RUN yum -y --setopt=tsflags=nodocs update && \
    yum install -y --setopt=tsflags=nodocs patch && \
    yum install -y util-linux-user && \
    yum install -y --setopt=tsflags=nodocs /local-rpms/java-11-amazon-corretto-devel-11.*.x86_64.rpm && \
    yum install -y /local-rpms/Semaphore-Studio-5.4.1-1.noarch.rpm && \
    yum install -y tar && \
    yum clean all

COPY tomcat-users.xml /opt/semaphore/studio/conf/tomcat-users.xml

#Copy in the daemon creation script and start script
COPY start-studio.sh /opt/semaphore

# make scripts executable
RUN chmod 777 /opt/semaphore/start-studio.sh

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
