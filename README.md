Docker CI Status:
[ ![Codeship Status for opsforgeio/puppeteer](https://app.codeship.com/projects/eace0cd0-bf27-0134-a521-0ef15c5d34cb/status?branch=master)](https://app.codeship.com/projects/196534)
Image States on Hub:

 - Puppet Server: [![](https://images.microbadger.com/badges/image/opsforge/puppetserver.svg)](https://hub.docker.com/r/opsforge/puppetserver/ "Puppet Server Image")
 - PuppetDB: [![](https://images.microbadger.com/badges/image/opsforge/puppetdb.svg)](https://hub.docker.com/r/opsforge/puppetdb/ "PuppetDB Image")
 - PuppetDB PSQL: [![](https://images.microbadger.com/badges/image/opsforge/puppetdb-psql.svg)](https://hub.docker.com/r/opsforge/puppetdb-psql/ "PuppetDB PostgreSQL Image")
 - Puppetboard: [![](https://images.microbadger.com/badges/image/opsforge/puppetboard.svg)](https://hub.docker.com/r/opsforge/puppetboard/ "Puppetboard Image")
 - Puppet 3.X: [![](https://images.microbadger.com/badges/image/opsforge/puppet3x.svg)](https://hub.docker.com/r/opsforge/puppet3x/ "Puppet3X Image")

# Puppet Docker stack

**Active versions:**

- Puppet - 4.6
- Puppet Server - 2.6
- PuppetDB - 4.2.0

**Legacy versions:**

- Puppet - 3.8.7
- Puppet Server - 1.2.1
- PuppetDB - 2.3.8
- Puppetexplorer - 1.5.0

## Disclaimer

This project is an obvious fork of https://github.com/puppetlabs/puppet-in-docker so kudos to everyone there for making this happen. Also, as such I might not be able to keep certain components up to speed with the master on that project. Take this for what it is - a turnkey solution for a dockerised Puppet stack (without the desire to keep up with master).

## Benefits

Compared to the standalone server:

 - Easier to backup and maintain / upgrade
 - It's literally a one-click deploy in Rancher and a one-command deploy in compose
 - It takes 5 minutes to come online from nothing
 - You can have multiple instances running on the same host on different ports
 - Works with a dashboard out of the box

## Description

After looking at the original project from Puppet Labs, I thought it's almost what I needed, but it was not quite easy to start up. It also had some prerequisites I wanted to remove. This project ultimately aims to be a turnkey solution for kicking off a Puppet stack and it's also intended for production use.

## How to use

There are two ways to use this stack:

1. Natively with Docker Compose
2. Natively in Rancher (as a catalog item)

### Using with docker-compose

Clone the repo to a docker host or get the docker-compose.yml file on the host. From a shell in the folder of the yaml file run:

    docker-compose up -d

Wait for the pulls to finish and afterwards 5-7 more minutes for the stack to come online. You should be able to reach the server on the host under `8140` and the dashboard under `9080`.

To get rid of the stack (again from the folder of the yaml):

    docker-compose down

*Make sure that if you don't want to keep the data you remove the data folders from the folder of the yaml.*

### Using with Rancher

Add the opsforge catalog to your rancher:
https://github.com/opsforgeio/opsforge

Open the Puppet item. Change the storage path (it's host persisted, not convoy or rancher's NFS) to your preference. You can amend this to expose only the volume if you're keen to use the Rancher storage instead. I personally recommend using a host attached NFS share to persist the data.

Fill out the required fields and press OK to launch the stack.

Once all containers are online, create a new load balancer on Rancher. Point TCP *ANY_PORT* to puppet 8140. Point HTTP *ANY_PORT* TO puppetboard 80. Save the changes. You can reach puppet on the host with agents on the LB's port and the dashboard on the other port. For the dashboard you can also use Host headers to determine the endpoint.
