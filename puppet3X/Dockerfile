FROM centos:6.8
MAINTAINER George Svachulay "george.svachulay@opsforge.io"

LABEL name="puppet3x" \
      version="0.5.0"

RUN yum clean all && \
    yum install wget telnet curl ping nc -y && \
    rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm && \
    yum install puppetserver -y && \
    puppet resource package puppetdb ensure=latest && \
    puppet resource package puppetdb-terminus ensure=latest && \
    puppet module install puppetlabs-apache --version 1.11.0 && \
    rm -rf /etc/hiera.yaml /etc/puppetdb/conf.d/database.ini && \
    cd /tmp && \
    rpm -ivh https://github.com/dalen/puppetexplorer/releases/download/1.5.0/puppetexplorer-1.5.0-1.noarch.rpm && \
    wget https://github.com/dalen/puppet-puppetexplorer/archive/0.5.1.tar.gz && \
    puppet module install ./0.5.1.tar.gz && \
    yum clean all && \
    rm -rf /tmp/*

COPY manifest.pp /tmp/

RUN puppet apply --modulepath=/etc/puppet/modules /tmp/manifest.pp && \
    rm -rf /tmp/*

COPY puppet /etc/puppet
COPY puppetdb /etc/puppetdb/conf.d/
COPY entrypoint.sh /

RUN chmod 0755 /entrypoint.sh

VOLUME /var/lib/puppet/ssl
#VOLUME /etc/puppetdb/ssl
VOLUME /etc/puppet/environments

EXPOSE 443
EXPOSE 8140
EXPOSE 8080 8081

SHELL ["/bin/bash","-c"]
CMD ["/entrypoint.sh" ]
