FROM oraclelinux:9

LABEL maintainer="Progress Software"
LABEL sem5-version="5.8.0"

# Copy local RPMs and licence file to image
RUN mkdir /local-rpms/
COPY *.rpm /local-rpms/

# Get CentOS updates and install rpms, and clean up.
RUN yum -y --setopt=tsflags=nodocs update && \
    yum install -y --setopt=tsflags=nodocs patch && \
    yum install -y util-linux-user && \
    yum install -y --setopt=tsflags=nodocs /local-rpms/java-11-amazon-corretto-devel-11.0.*.*.rpm && \
    yum install -y /local-rpms/Semaphore-ConceptsServer-5.8.0.noarch.rpm && \
    yum clean all

# Copy license file from local dir to image.
COPY ./licence /opt/semaphore/licence

# Copy marklogic.properties config to image
COPY ./marklogic.properties /opt/semaphore/concepts/conf/

# Set the license directory environment variable.
ENV SEMAPHORE_LICENCE_DIR /opt/semaphore

#Copy in the daemon creation script and start script
COPY start-cons.sh /opt/semaphore

# make scripts executable
RUN chmod 777 /opt/semaphore/start-cons.sh

# set path environment variable
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/semaphore

# external volume off union filesystem
VOLUME ["/var/opt/semaphore"]

WORKDIR /opt/semaphore

EXPOSE 5092

CMD ["/opt/semaphore/start-cons.sh"]

