#!/bin/bash

if [ ! -d "/etc/puppetlabs/puppetdb/ssl" ]; then
  while ! nc -z puppet 8140; do
    sleep 1
  done
  set -e
  /opt/puppetlabs/bin/puppet config certname puppetdb --section main
  /opt/puppetlabs/bin/puppet config dns_alt_names puppetdb --section main
  /opt/puppetlabs/bin/puppet agent --verbose --onetime --no-daemonize --waitforcert 120
  /opt/puppetlabs/server/bin/puppetdb ssl-setup -f
fi

exec /opt/puppetlabs/server/bin/puppetdb "$@"
