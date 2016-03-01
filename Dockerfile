FROM beresfordt/alpine-java8

MAINTAINER Tom Beresford

# Create dirs
RUN mkdir -p /opt/liquibase
RUN mkdir -p /opt/jdbc_drivers
RUN mkdir -p /home/duser

# Download liquibase
ADD http://repo1.maven.org/maven2/org/liquibase/liquibase-core/3.3.0/liquibase-core-3.3.0-bin.tar.gz /opt/liquibase/liquibase-core-3.3.0-bin.tar.gz

# Untar
WORKDIR /opt/liquibase
RUN tar -xzf liquibase-core-3.3.0-bin.tar.gz

# Tidy
RUN rm liquibase-core-3.3.0-bin.tar.gz

WORKDIR /

# Make liquibase executable
RUN chmod +x /opt/liquibase/liquibase

# Symlink to liquibase to be on the path
RUN ln -s /opt/liquibase/liquibase /usr/local/bin/

# Add postgres driver
ADD http://central.maven.org/maven2/org/postgresql/postgresql/9.3-1102-jdbc41/postgresql-9.3-1102-jdbc41.jar /opt/jdbc_drivers/postgresql-9.3-1102-jdbc41.jar
RUN chmod 644 /opt/jdbc_drivers/postgresql-9.3-1102-jdbc41.jar

# Add user
RUN addgroup -S -g 433 duser && \
  adduser -u 431 -S -G duser -H -s /sbin/nologin duser && \
  chown -R duser:duser /home/duser

# Add script
RUN mkdir /scripts
COPY update.sh /scripts/
RUN chmod +x /scripts/update.sh

VOLUME ["/changelogs"]

WORKDIR /home/duser

USER duser

CMD ["/scripts/update.sh"]
