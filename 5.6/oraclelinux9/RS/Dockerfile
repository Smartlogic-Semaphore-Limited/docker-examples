FROM oraclelinux:9

LABEL maintainer="Progress Software"
LABEL sem5-version="5.6.4"

# Copy local RPMs and licence file to image
RUN mkdir /local-rpms/
COPY *.rpm /local-rpms/

# Get CentOS updates and install rpms, and clean up.
RUN yum -y --setopt=tsflags=nodocs update && \
    yum install -y --setopt=tsflags=nodocs patch && \
    yum install -y util-linux-user && \
    yum install -y --setopt=tsflags=nodocs /local-rpms/java-11-amazon-corretto-devel-11.0.*.*.rpm && \
    yum install -y /local-rpms/Semaphore-ReconciliationServer-5.6.4.noarch.rpm && \
    yum clean all

# Copy license file from local dir to image.
COPY ./licence /opt/semaphore/licence

COPY ./rs-ses-sources.properties /opt/semaphore/rs/conf/

COPY ./start-rs.sh /opt/semaphore/start-rs.sh
RUN chmod 777 /opt/semaphore/start-rs.sh

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/semaphore

EXPOSE 5090

VOLUME ["/var/opt/semaphore"]

ENTRYPOINT ["/opt/semaphore/start-rs.sh"]
