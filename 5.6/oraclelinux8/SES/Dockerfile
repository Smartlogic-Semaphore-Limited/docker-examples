FROM oraclelinux:8

LABEL maintainer="Progress Software"
LABEL sem5-version="5.6.3"

# Copy local RPMs and licence file to image
RUN mkdir /local-rpms/
COPY *.rpm /local-rpms/

# Get CentOS updates and install rpms, and clean up.
RUN yum -y --setopt=tsflags=nodocs update && \
    yum install -y --setopt=tsflags=nodocs patch && \
    yum install -y util-linux-user && \
    yum install -y --setopt=tsflags=nodocs /local-rpms/java-11-amazon-corretto-devel-11.0.*.*.rpm && \
    yum install -y /local-rpms/Semaphore-SES-5.6.3-1.noarch.rpm && \
    yum clean all

# Copy license file from local dir to image.
COPY ./licence /opt/semaphore/licence

# copy the patch into place to increase Java heap and patch solr.in.sh
COPY solr.in.sh.patch /opt/semaphore/SES/solr/bin/solr.in.sh.patch
RUN patch --directory /opt/semaphore/SES/solr/bin --ignore-whitespace < /opt/semaphore/SES/solr/bin/solr.in.sh.patch

# Set the license directory environment variable.
ENV SEMAPHORE_LICENCE_DIR /opt/semaphore

#Copy in the daemon creation script and start script
COPY start-ses.sh /opt/semaphore
COPY SESservice.sh /opt/semaphore/SES/bin/SESservice.sh

# make scripts executable
RUN chmod 777 /opt/semaphore/start-ses.sh
RUN chmod 777 /opt/semaphore/SES/bin/SESservice.sh

# web.xml with CORS headers enabled
COPY web.xml /opt/semaphore/SES/solr/server/ses-webapp/webapp/WEB-INF/web.xml

# set path environment variable
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/semaphore

# external volume off union filesystem
VOLUME ["/var/opt/semaphore"]

WORKDIR /opt/semaphore

EXPOSE 8983 9983

CMD ["/opt/semaphore/start-ses.sh"]
