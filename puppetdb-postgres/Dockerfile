FROM postgres:9.5.3
MAINTAINER Gareth Rushgrove "gareth@puppet.com"

LABEL org.label-schema.vendor="Puppet" \
      org.label-schema.name="PostgreSQL instance for PuppetDB" \
      org.label-schema.license="Apache-2.0" \
      com.puppet.dockerfile="/Dockerfile" \
      name="puppetdb-psql" \
      version="1.0.0"

COPY docker-entrypoint-initdb.d /docker-entrypoint-initdb.d

COPY Dockerfile /
