#!/bin/bash

chown -R puppet:puppet /etc/puppetlabs/puppet/ssl
chown -R puppet:puppet /etc/puppetlabs/code/
chown -R puppet:puppet /etc/puppetlabs/code/
chown -R puppet:puppet /etc/puppetlabs/puppet/ssl/
chown -R puppet:puppet /etc/puppetlabs/puppet/environments/
chown -R puppet:puppet /opt/puppetlabs/server/data/puppetserver/

if test -n "${PUPPETDB_SERVER_URLS}" ; then
  sed -i "s@^server_urls.*@server_urls = ${PUPPETDB_SERVER_URLS}@" /etc/puppetlabs/puppet/puppetdb.conf
fi

# Autosing DNS ALT NAME Cert 5 min after prov. for puppetdb only - wait for the DB to submit the request
/bin/bash -c 'sleep 5m && /opt/puppetlabs/bin/puppet cert --allow-dns-alt-names sign puppetdb'

exec /opt/puppetlabs/bin/puppetserver "$@"
