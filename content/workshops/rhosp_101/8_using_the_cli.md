---
title: Lab 7 - Using the OpenStack CLI(s)
workshops: rhosp_101
workshop_weight: 17
layout: lab
---

# Okay. UIs Are Cool and All, But Can't I Just Use the CLI?

Absolutely! There are 3 ways to interact with OpenStack.  

- APIs  
- CLIs  
- Horizon

In this lab, we are going to walk through some of the activities that we did in the previous labs via the CLIs.

{{% alert info %}}
When you see a CLI command starting with **openstack**, the command is part of the Unified CLI.

When you see a CLI command that starts with a project name like **nova**, these are the individual CLIs.

You can read more about the OpenStack CLIs at:
https://docs.openstack.org/user-guide/common/cli-overview.html
{{% /alert %}}

## First, We Need Access to a System with the CLIs Installed

{{% alert warning %}}
In order to complete this lab, you will need an SSH client.

On Linux or Mac, you can just use your favorite terminal.

On Windows, you will need to download [putty](https://the.earth.li/~sgtatham/putty/latest/w64/putty.exe) if you don't already have it. This is an exe file that does not need to be installed. Just run.
{{% /alert %}}

> On Linux or Mac, in your terminal, ssh to 192.168.1.77 on port 22

```
$ ssh studentX@192.168.1.77
```

If on Windows, run putty, enter **192.168.1.77** as the host and **22** as the port.

You will get asked if you are sure you want to connect. Type **yes** and hit enter.

Login with your studentX credentials.

## Let's Autenticate to the OpenStack Cloud

> Source your studentXrc file

```
$ source studentXrc
```

> Verify that you are connected by running nova list

```
$ openstack server list
```

You should see the two instances you created in the previous lab.

```
[student1@workshop-bastion ~]$ openstack server list
+--------------------------------------+-------------------+--------+-------------------------------------+-----------------+
| ID                                   | Name              | Status | Networks                            | Image Name      |
+--------------------------------------+-------------------+--------+-------------------------------------+-----------------+
| 33d9ddda-d2d6-4021-9cf6-381d46dd8d2d | student1-cirros-2 | ACTIVE | private-a=172.16.0.11               | student1-cirros |
| dc943883-f473-49ec-8e3f-7b057bf7474c | student1-cirros-1 | ACTIVE | private-a=172.16.0.12, 192.168.1.73 | student1-cirros |
+--------------------------------------+-------------------+--------+-------------------------------------+-----------------+
```

## Now Let's Upload Another Cirros Image for Fun

> First we'll download the image using curl

```
$ curl -o ~/cirros035.qcow2 http://download.cirros-cloud.net/0.3.5/cirros-0.3.5-x86_64-disk.img
```

```
[student1@workshop-bastion ~]$ curl -o ~/cirros035.qcow2 http://download.cirros-cloud.net/0.3.5/cirros-0.3.5-x86_64-disk.img
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 12.6M  100 12.6M    0     0   832k      0  0:00:15  0:00:15 --:--:--  790k
```

> Upload the cirros test image to glance

```
$ glance image-create --name studentX-cirros035 --disk-format qcow2 --container-format bare --visibility private --file ~/cirros035.qcow2
```

```
[student1@workshop-bastion ~]$ glance image-create --name student1-cirros035 --disk-format qcow2 --container-format bare --visibility private --file ~/cirros035.qcow2
+------------------+----------------------------------------------------------------------------------+
| Property         | Value                                                                            |
+------------------+----------------------------------------------------------------------------------+
| checksum         | f8ab98ff5e73ebab884d80c9dc9c7290                                                 |
| container_format | bare                                                                             |
| created_at       | 2018-09-22T18:56:22Z                                                             |
| direct_url       | rbd://83955e7e-fc0b-                                                             |
|                  | 11e7-8961-525400af2fbc/images/76d6f851-e598-45b7-a5f1-52912977deb6/snap          |
| disk_format      | qcow2                                                                            |
| id               | 76d6f851-e598-45b7-a5f1-52912977deb6                                             |
| locations        | [{"url": "rbd://83955e7e-fc0b-                                                   |
|                  | 11e7-8961-525400af2fbc/images/76d6f851-e598-45b7-a5f1-52912977deb6/snap",        |
|                  | "metadata": {}}]                                                                 |
| min_disk         | 0                                                                                |
| min_ram          | 0                                                                                |
| name             | student1-cirros035                                                               |
| owner            | c4f6fc52a10e499e9e8d1c6ea5d5cb01                                                 |
| protected        | False                                                                            |
| size             | 13267968                                                                         |
| status           | active                                                                           |
| tags             | []                                                                               |
| updated_at       | 2018-09-22T18:56:22Z                                                             |
| virtual_size     | None                                                                             |
| visibility       | private                                                                          |
+------------------+----------------------------------------------------------------------------------+
```

You will now see two images in your glance image list prefixed with studentX-cirros in their name.

> Run openstack image list (or glance image-list) to see the available images

```
$ openstack image list
```

```
[student1@workshop-bastion ~]$ glance image-list
+--------------------------------------+--------------------+
| ID                                   | Name               |
+--------------------------------------+--------------------+
| 9ebdc5e9-d38e-48d6-9948-1a7bc692e797 | cirros035          |
| c47b2f5c-95d1-4696-961c-2267569590fc | rhel75             |
| 8b430cc3-92eb-44ac-9cfd-8ac2e7395d0b | student1-cirros    |
| 76d6f851-e598-45b7-a5f1-52912977deb6 | student1-cirros035 |
+--------------------------------------+--------------------+
```

## Let's List the Available Instance Flavors Now

> Run the following command to see the existing flavors

```
$ openstack flavor list
```

```
[student1@workshop-bastion ~]$ openstack flavor list
+--------------------------------------+---------------+-------+------+-----------+-------+-----------+
| ID                                   | Name          |   RAM | Disk | Ephemeral | VCPUs | Is Public |
+--------------------------------------+---------------+-------+------+-----------+-------+-----------+
| 1                                    | m1.tiny       |   512 |    1 |         0 |     1 | True      |
| 10                                   | m1.rhhi       | 32768 |   80 |         0 |    12 | True      |
| 2                                    | m1.small      |  1024 |   10 |         0 |     1 | True      |
| 3                                    | m1.medium     |  2048 |   20 |         0 |     2 | True      |
| 4                                    | m1.large      |  4096 |   40 |         0 |     4 | True      |
| 5                                    | m1.xlarge     |  8192 |   80 |         0 |     8 | True      |
| 6                                    | m1.cfme       | 12288 |   80 |         0 |     4 | True      |
| 7                                    | m1.satellite6 | 12288 |   80 |         0 |     8 | True      |
| a4bde805-bf1d-49e3-b14e-81259d678377 | m1.ocp-master | 16384 |   40 |        40 |     8 | True      |
| d7ab76f0-8c28-4260-afdb-3f719cf44294 | m1.ocp-node   | 16384 |   40 |       200 |     8 | True      |
+--------------------------------------+---------------+-------+------+-----------+-------+-----------+
```

## Now We Will List Our Project's Floating IP Addresses

> List the existing floating IP addresses

```
openstack floating ip list
```

```
[student1@workshop-bastion ~]$ openstack floating ip list
+--------------------------------------+---------------------+------------------+--------------------------------------+
| ID                                   | Floating IP Address | Fixed IP Address | Port                                 |
+--------------------------------------+---------------------+------------------+--------------------------------------+
| 65a23d46-4d88-4733-b97d-eea27ea30ff2 | 192.168.1.96        | None             | None                                 |
| de49190f-6e71-4f6f-a4dc-25161ab9e186 | 192.168.1.98        | None             | None                                 |
| e4fc2503-3c29-4fb0-8252-5e8153241fbd | 192.168.1.73        | 172.16.0.12      | 9e7dd027-d6b6-4795-a6a4-d64b992950e0 |
+--------------------------------------+---------------------+------------------+--------------------------------------+
```

## Let's Now Create a Second Private Network

> First create the network

```
$ openstack network create private-b
```

```
[student1@workshop-bastion ~]$ openstack network create private-b
+-------------------------+--------------------------------------+
| Field                   | Value                                |
+-------------------------+--------------------------------------+
| admin_state_up          | UP                                   |
| availability_zone_hints |                                      |
| availability_zones      |                                      |
| created_at              | 2018-09-22T19:01:33Z                 |
| description             |                                      |
| headers                 |                                      |
| id                      | 91a9031a-c3bc-4ed1-81bd-5df21b445ad7 |
| ipv4_address_scope      | None                                 |
| ipv6_address_scope      | None                                 |
| mtu                     | 1446                                 |
| name                    | private-b                            |
| port_security_enabled   | True                                 |
| project_id              | c4f6fc52a10e499e9e8d1c6ea5d5cb01     |
| project_id              | c4f6fc52a10e499e9e8d1c6ea5d5cb01     |
| qos_policy_id           | None                                 |
| revision_number         | 3                                    |
| router:external         | Internal                             |
| shared                  | False                                |
| status                  | ACTIVE                               |
| subnets                 |                                      |
| tags                    | []                                   |
| updated_at              | 2018-09-22T19:01:33Z                 |
+-------------------------+--------------------------------------+
```

> Then let's create the private-b subnet

```
$ openstack subnet create --network private-b --subnet-range 172.16.1.0/24 --dns-nameserver 192.168.0.6 private-b-subnet
```

```
[student1@workshop-bastion ~]$ openstack subnet create --network private-b --subnet-range 172.16.1.0/24 --dns-nameserver 192.168.0.6 private-b-subnet
+-------------------+--------------------------------------+
| Field             | Value                                |
+-------------------+--------------------------------------+
| allocation_pools  | 172.16.1.2-172.16.1.254              |
| cidr              | 172.16.1.0/24                        |
| created_at        | 2018-09-22T19:02:18Z                 |
| description       |                                      |
| dns_nameservers   | 192.168.0.6                          |
| enable_dhcp       | True                                 |
| gateway_ip        | 172.16.1.1                           |
| headers           |                                      |
| host_routes       |                                      |
| id                | 06033b13-c8f5-4b19-aa9d-8e965f61b336 |
| ip_version        | 4                                    |
| ipv6_address_mode | None                                 |
| ipv6_ra_mode      | None                                 |
| name              | private-b-subnet                     |
| network_id        | 91a9031a-c3bc-4ed1-81bd-5df21b445ad7 |
| project_id        | c4f6fc52a10e499e9e8d1c6ea5d5cb01     |
| project_id        | c4f6fc52a10e499e9e8d1c6ea5d5cb01     |
| revision_number   | 2                                    |
| service_types     | []                                   |
| subnetpool_id     | None                                 |
| updated_at        | 2018-09-22T19:02:18Z                 |
+-------------------+--------------------------------------+
```

> List the Neutron Networks and Subnets

```
$ openstack network list

$ openstack subnet list
```

```
[student1@workshop-bastion ~]$ openstack network list
+--------------------------------------+-----------+--------------------------------------+
| ID                                   | Name      | Subnets                              |
+--------------------------------------+-----------+--------------------------------------+
| 5cfbe80d-a60c-4280-a9ef-8d6cce36dba1 | private-a | d49cfa33-ef2e-460c-b6a9-c508153670a4 |
| 91a9031a-c3bc-4ed1-81bd-5df21b445ad7 | private-b | 06033b13-c8f5-4b19-aa9d-8e965f61b336 |
| f3d2dbeb-c377-4205-908e-d1f57e2ecafd | public    | b7311756-a4d2-4639-b8ff-8f4a6963dbf3 |
+--------------------------------------+-----------+--------------------------------------+
[student1@workshop-bastion ~]$ openstack subnet list
+--------------------------------------+------------------+--------------------------------------+----------------+
| ID                                   | Name             | Network                              | Subnet         |
+--------------------------------------+------------------+--------------------------------------+----------------+
| 06033b13-c8f5-4b19-aa9d-8e965f61b336 | private-b-subnet | 91a9031a-c3bc-4ed1-81bd-5df21b445ad7 | 172.16.1.0/24  |
| b7311756-a4d2-4639-b8ff-8f4a6963dbf3 | public-sub       | f3d2dbeb-c377-4205-908e-d1f57e2ecafd | 192.168.0.0/23 |
| d49cfa33-ef2e-460c-b6a9-c508153670a4 | private-a-sub    | 5cfbe80d-a60c-4280-a9ef-8d6cce36dba1 | 172.16.0.0/24  |
+--------------------------------------+------------------+--------------------------------------+----------------+
```

## Lastly, Let's Create an Instance Using the CLIs

> First we need to get the network UUID for private-b network

```
$ openstack network list
```

```
[student1@workshop-bastion ~]$ openstack network list
+--------------------------------------+-----------+--------------------------------------+
| ID                                   | Name      | Subnets                              |
+--------------------------------------+-----------+--------------------------------------+
| 5cfbe80d-a60c-4280-a9ef-8d6cce36dba1 | private-a | d49cfa33-ef2e-460c-b6a9-c508153670a4 |
| 91a9031a-c3bc-4ed1-81bd-5df21b445ad7 | private-b | 06033b13-c8f5-4b19-aa9d-8e965f61b336 |
| f3d2dbeb-c377-4205-908e-d1f57e2ecafd | public    | b7311756-a4d2-4639-b8ff-8f4a6963dbf3 |
+--------------------------------------+-----------+--------------------------------------+
```

{{% alert info %}}
Note that your Network UUID will be unique. In this example the value is: 91a9031a-c3bc-4ed1-81bd-5df21b445ad7
{{% /alert %}}

> Run the following command to boot a nova instance using the m1.tiny flavor, and the newest cirros image that we uploaded earlier in this lab.  
> We will also attach it to the new **private-b** network

```
$ openstack server create --image studentX-cirros035 --flavor m1.tiny --key-name studentX --nic net-id=Your-Network-UUID-Here studentX-cirros-cli-1
```

```
[student1@workshop-bastion ~]$ openstack server create --image student1-cirros035 --flavor m1.tiny --key-name student1 --nic net-id=91a9031a-c3bc-4ed1-81bd-5df21b445ad7 student1-cirros-cli-1
+--------------------------------------+-----------------------------------------------------------+
| Field                                | Value                                                     |
+--------------------------------------+-----------------------------------------------------------+
| OS-DCF:diskConfig                    | MANUAL                                                    |
| OS-EXT-AZ:availability_zone          |                                                           |
| OS-EXT-STS:power_state               | NOSTATE                                                   |
| OS-EXT-STS:task_state                | scheduling                                                |
| OS-EXT-STS:vm_state                  | building                                                  |
| OS-SRV-USG:launched_at               | None                                                      |
| OS-SRV-USG:terminated_at             | None                                                      |
| accessIPv4                           |                                                           |
| accessIPv6                           |                                                           |
| addresses                            |                                                           |
| adminPass                            | BArQJrjxc8zt                                              |
| config_drive                         |                                                           |
| created                              | 2018-09-22T19:07:40Z                                      |
| flavor                               | m1.tiny (1)                                               |
| hostId                               |                                                           |
| id                                   | 73fadc50-2d9d-42ad-b304-f02a139eaf1f                      |
| image                                | student1-cirros035 (76d6f851-e598-45b7-a5f1-52912977deb6) |
| key_name                             | student1                                                  |
| name                                 | student1-cirros-cli-1                                     |
| os-extended-volumes:volumes_attached | []                                                        |
| progress                             | 0                                                         |
| project_id                           | c4f6fc52a10e499e9e8d1c6ea5d5cb01                          |
| properties                           |                                                           |
| security_groups                      | [{u'name': u'default'}]                                   |
| status                               | BUILD                                                     |
| updated                              | 2018-09-22T19:07:40Z                                      |
| user_id                              | d8f3ac4c300d4de1a290bfad33245d1e                          |
+--------------------------------------+-----------------------------------------------------------+
```

> You can watch nova list to see it go through the provisioning process and become active

```
$ watch openstack server list
```

```
Every 2.0s: openstack server list                                                                                                  Sat Sep 22 15:08:59 2018

+--------------------------------------+-----------------------+--------+-------------------------------------+--------------------+
| ID                                   | Name                  | Status | Networks                            | Image Name         |
+--------------------------------------+-----------------------+--------+-------------------------------------+--------------------+
| 73fadc50-2d9d-42ad-b304-f02a139eaf1f | student1-cirros-cli-1 | ACTIVE | private-b=172.16.1.5                | student1-cirros035 |
| 33d9ddda-d2d6-4021-9cf6-381d46dd8d2d | student1-cirros-2     | ACTIVE | private-a=172.16.0.11               | student1-cirros    |
| dc943883-f473-49ec-8e3f-7b057bf7474c | student1-cirros-1     | ACTIVE | private-a=172.16.0.12, 192.168.1.73 | student1-cirros    |
+--------------------------------------+-----------------------+--------+-------------------------------------+--------------------+
```

# Summary

We have now gone through some of the same excercises that we accomplished in Horizon, using strictly the CLIs. The flexibility with which we can interact with OpenStack is a tremendous benefit.

What if we could now take all of these manual steps we've gone through and put them into a template that does them all for us, the same way, every time?

We can do this with Heat. That will be our next lab.
