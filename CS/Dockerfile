FROM centos/systemd

LABEL maintainer="Smartlogic Semaphore Ltd"
LABEL sem5-version="5.0.5"

# Copy local RPMs and licence file to image
RUN mkdir /local-rpms/
COPY *.rpm /local-rpms/

# Get CentOS updates and install rpms, and clean up.
RUN yum -y --setopt=tsflags=nodocs update && \
    yum install -y --setopt=tsflags=nodocs patch && \
    yum install -y --setopt=tsflags=nodocs /local-rpms/java-11-amazon-corretto-devel-11.0.9.12-1.x86_64.rpm && \
    yum install -y /local-rpms/Semaphore-LanguagePack-Linux-Base-5.0.0.rpm && \
    yum install -y /local-rpms/Semaphore-LanguagePack-Linux-English-5.0.0.rpm && \
    yum install -y /local-rpms/Semaphore-ClassificationServer-5.0.5-1.x86_64.rpm && \
    yum clean all

# Patch to open 5059 admin service to all IPs
COPY config.patch /opt/semaphore/CS/conf/config.patch
RUN patch --directory /opt/semaphore/CS/conf --ignore-whitespace < /opt/semaphore/CS/conf/config.patch

# Copy license file from local dir to image.
COPY ./licence /opt/semaphore/licence

COPY ./start-cs.sh /opt/semaphore/start-cs.sh
RUN chmod 777 /opt/semaphore/start-cs.sh

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/semaphore

ENV SEMAPHORE_JVM_LIB /etc/alternatives/jre/lib/server/libjvm.so

EXPOSE 5058 5059

VOLUME ["/var/opt/semaphore"]

ENTRYPOINT ["/opt/semaphore/start-cs.sh"]
