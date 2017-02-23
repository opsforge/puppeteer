#!/bin/bash

echo "Initiating tests..."
chmod -R 0777 ./
echo ">>> Docker Lints:"
./specs/generic.spec.sh
if [ $? -eq 0 ]; then
  echo ">>> Docker Lints concluded and none failed."
else
  echo ">>> Tests failed."
  exit 1
fi
echo "Initiating DockerHub builds..."
#PuppetDB PSQL
curl --data build=true -X POST 'https://registry.hub.docker.com/u/opsforge/puppetdb-psql/trigger/b5a8325c-c988-45b6-a372-7c6e509e141a/'

#PuppetDB
curl --data build=true -X POST 'https://registry.hub.docker.com/u/opsforge/puppetdb/trigger/c878135f-57c9-4ee1-98d7-cc36e5e0cbfb/'

#PuppetServer
curl --data build=true -X POST 'https://registry.hub.docker.com/u/opsforge/puppetserver/trigger/e20e2360-0c34-4cb4-97f0-2e2972bd6163/'

#Puppetboard
curl --data build=true -X POST 'https://registry.hub.docker.com/u/opsforge/puppetboard/trigger/331d463d-c42d-4dec-98a7-31c375ce869b/'

#Puppet3X
curl --data build=true -X POST 'https://registry.hub.docker.com/u/opsforge/puppet3x/trigger/1a75c281-9c06-49a1-93db-77fb4217a701/'
echo "DockerHub build triggered..."
