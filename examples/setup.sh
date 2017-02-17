#!/bin/bash

# setup infra-cli
echo "deb http://10.47.2.22:80/repos/infra-cli/3 /" > /etc/apt/sources.list.d/infra-cli-svc.list
 
# install infra-cli (contains repo-service cli)
sudo apt-get update
sudo apt-get install --yes --allow-unauthenticated infra-cli

#Include your repo in sources.list
reposervice --host repo-svc-app-0001.nm.flipkart.com --port 8080 env --name aerospike_3.9.1.1_env --appkey dummykey > /etc/apt/sources.list.d/aerospike.list
 
#Adding a bucket keyspace in the environment.
export AEROSPIKE_CONF_BUCKET="aerospike-default"
 
#Update
sudo apt-get update
 
#Install aerospike
sudo apt-get install --yes --allow-unauthenticated fk-3p-aerospike-server-enterprise-3.9.1.1
