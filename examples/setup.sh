#!/bin/bash

# setup infra-cli
echo "deb http://10.47.2.22:80/repos/infra-cli/3 /" > /etc/apt/sources.list.d/infra-cli-svc.list

# install infra-cli (contains repo-service cli)
sudo apt-get update
sudo apt-get install --yes --allow-unauthenticated infra-cli

#Include your repo in sources.list
reposervice --host repo-svc-app-0001.nm.flipkart.com --port 8080 env --name pricing_aerospike_3.9.1.1_env --appkey dummykey > /etc/apt/sources.list.d/aerospike.list

#Adding a bucket keyspace in the environment.
export AEROSPIKE_CONF_BUCKET="BUCKET_NAME"

#Update
sudo apt-get update

sudo apt-get install --yes --allow-unauthenticated lvm2
sudo pvcreate /dev/vdb
sudo vgcreate vgroot /dev/vdb
sudo lvcreate -L+250G -n lv_aerospike vgroot
sudo mkfs.ext4 /dev/mapper/vgroot-lv_aerospike
sudo mkdir -p /storage/aerospike
sudo mount /dev/mapper/vgroot-lv_aerospike /storage/aerospike
bash -c "echo '/dev/mapper/vgroot-aerospike        /storage/aerospike        ext4        default        0        0' >> /etc/fstab"
sudo rm -rf /storage/aerospike/lost+found/

#Install aerospike
sudo apt-get install --yes --allow-unauthenticated fk-3p-aerospike-server-enterprise-3.9.1.1