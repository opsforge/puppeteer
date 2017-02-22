#!/bin/bash

echo -n " ************* Changing folder ownership..."
chown -R puppet:puppet /var/lib/puppet/ssl/
#chown -R puppetdb:puppetdb /var/lib/puppetdb/ssl
chown -R puppet:puppet /etc/puppet/
chown -R puppetdb:puppetdb /etc/puppetdb/
echo "Done"

echo " ************* Initialising PuppetDB certificates and local certificates..."
puppetserver foreground &

if [ ! -d "/etc/puppetdb/ssl" ]; then
  while ! nc -z puppet 8140; do
    sleep 1
  done
  echo " ************* Puppet Server online, requesting PuppetDB certs..."
  puppet agent --verbose --onetime --no-daemonize --waitforcert 120
  puppetdb ssl-setup -f
  pkill -f puppet
fi

echo " ************* Configuring server..."
puppet config set autosign true --section master
puppet config set storeconfigs_backend puppetdb --section main
puppet config set storeconfigs true --section main
puppet config set reports puppetdb --section main

echo " ************* Starting services..."
service puppetdb restart
service puppetserver restart &

tail -f /var/log/puppetdb/puppetdb.log &
tail -f /var/log/puppetserver/puppetserver.log &

if ps aux | grep puppetserver &>/dev/null; then
  while ! nc -z puppet 8140; do
    sleep 1
  done
  echo " ************* Executing puppet agent run..."
  puppet agent -t
fi

echo " ************* Starting dashboard..."
service httpd restart
tail -f /var/log/httpd/puppet_access_ssl.log
