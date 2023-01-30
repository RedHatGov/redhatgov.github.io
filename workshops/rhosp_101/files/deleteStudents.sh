#!/usr/bin/bash

#Parameters
user=student
password=redhat
tenant=student

#Start as the admin user
source ~/overcloudrc

for i in {1..30}; do
  echo "Deleting student$i and all related resources";
  source ~/workshop/student${i}rc

  #Delete Object Storage containers and objects
  swift delete --all

  #Delete heat stacks
  openstack stack list | awk '$2 && $2 !="ID" {print $2}' | xargs -n1 openstack stack delete

  sleep 30

  #Delete nova instances
  nova list | awk '$2 && $2 != "ID" {print $2}' | xargs -n1 nova delete

  #Delete cinder volumes and snapshots
  openstack volume snapshot list | awk '$2 && $2 !="ID" {print $2}' | xargs -n1 openstack volume snapshot delete
  openstack volume list | awk '$2 && $2 !="ID" {print $2}' | xargs -n1 openstack volume delete

  #Delete keypairs
  openstack keypair list | awk '$2 && $2 !="Name" {print $2}' | xargs -n1 openstack keypair delete

  #Delete images
  openstack image list | grep -i student | awk '$2 && $2 !="ID" {print $2}' | xargs -n1 openstack image delete

  #Release Floating IPs
  openstack floating ip list | awk '$2 && $2 !="ID" {print $2}' | xargs -n1 openstack floating ip delete

  #Delete Routers
  router=$(openstack router list | awk '$2 && $2 !="ID" {print $2}')
  openstack router unset --external-gateway $router
  for port in $(openstack port list --format=value -c ID --router $router )
  do
    openstack router remove port $router $port
  done
  openstack router delete $router

  #Delete Networks
  openstack network list | grep -iv public | awk '$2 && $2 !="ID" {print $2}' | xargs -n1 openstack network delete

  #Delete Security Group
  openstack security group list | grep -iv default | awk '$2 && $2 !="ID" {print $2}' | xargs -n1 openstack security group delete

  #Create the student tenant and student user defined above
  source ~/overcloudrc
  openstack project delete $tenant$i
  openstack user delete $user$i
  
  rm -rf ~/workshop/student${i}rc
done
