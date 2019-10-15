---
title: Lab 7 - Using the OpenStack CLI(s)
workshops: rhosp_101
workshop_weight: 17
layout: lab
---

# Okay. UIs Are Cool and All, But Can't I Just Use the CLI?

Absolutely! There are 3 ways to interact with OpenStack.  

- API  
- CLI  
- GUI

In this lab, we are going to walk through some of the activities that we did in the previous labs via the CLI.

{{% alert info %}}
When you see a CLI command starting with **openstack**, the command is part of the Unified CLI.

When you see a CLI command that starts with a project name like **nova**, these are the individual CLIs.

You can read more about the OpenStack CLIs at:  
https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/13/html-single/command_line_interface_reference/index
{{% /alert %}}

## First, We Need Access to a System with the CLIs Installed

{{% alert warning %}}
In order to complete this lab, you will need an SSH client.

On Linux or Mac, you can just use your favorite terminal.

On Windows, you will need to download [putty](http://192.168.0.8/repos/putty.exe) if you don't already have it. This is an exe file that does not need to be installed. It will just run directly.
{{% /alert %}}

> On Linux or Mac, in your terminal, ssh to 192.168.1.90 on port 22

```
$ ssh {{< student "" "@192.168.1.90" >}}
```

If on Windows, run putty, enter **192.168.1.90** as the host and **22** as the port.

You will get asked if you are sure you want to connect. Type **yes** and hit enter.

Login with your **{{< student "" "" >}}** credentials.

## Let's Autenticate to the OpenStack Cloud

> Source your {{< student "" "rc" >}} file

```
$ source {{< student "" "rc" >}}
```

> Verify that you are connected by running openstack server list

```
$ openstack server list
```

You should see the two instances you created in the previous lab.

```
(overcloud) [student1@bastion ~]$ openstack server list
+--------------------------------------+-------------------+--------+-------------------------------------+-----------------+---------+
| ID                                   | Name              | Status | Networks                            | Image           | Flavor  |
+--------------------------------------+-------------------+--------+-------------------------------------+-----------------+---------+
| 45a45a6e-6e51-4858-b5d0-9e16a9308c33 | student1-cirros-1 | ACTIVE | private-a=172.16.0.6, 192.168.1.106 | student1-cirros | m1.tiny |
| cbd781be-cc64-4302-b15c-5a7ae805a917 | student1-cirros-2 | ACTIVE | private-a=172.16.0.14               | student1-cirros | m1.tiny |
+--------------------------------------+-------------------+--------+-------------------------------------+-----------------+---------+
```

## Now Let's Upload Another Cirros Image for Fun

> First we'll download the image using curl

```
$ curl -o ~/cirros.img http://192.168.0.8/images/cirros.img
```

```
(overcloud) [student1@bastion ~]$ curl -o ~/cirros.img http://192.168.0.8/images/cirros.img
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 44.0M  100 44.0M    0     0   103M      0 --:--:-- --:--:-- --:--:--  103M
```

> Upload the cirros test image to glance

```

$ openstack image create --disk-format raw --container-format bare --private --min-disk 1 --min-ram 64 --file ~/cirros.img {{< student "" "-cirros-cli" >}}
```

```
(overcloud) [student1@bastion ~]$ openstack image create --disk-format raw --container-format bare --private --min-disk 1 --min-ram 64 --file ~/cirros.img student1-cirros-cli
+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Field            | Value                                                                                                                                                                                                                                             |
+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| checksum         | ba3cd24377dde5dfdd58728894004abb                                                                                                                                                                                                                  |
| container_format | bare                                                                                                                                                                                                                                              |
| created_at       | 2019-07-13T20:22:50Z                                                                                                                                                                                                                              |
| disk_format      | raw                                                                                                                                                                                                                                               |
| file             | /v2/images/8ac9ad11-8de3-477c-96f7-184f784ed629/file                                                                                                                                                                                              |
| id               | 8ac9ad11-8de3-477c-96f7-184f784ed629                                                                                                                                                                                                              |
| min_disk         | 1                                                                                                                                                                                                                                                 |
| min_ram          | 64                                                                                                                                                                                                                                                |
| name             | student1-cirros-cli                                                                                                                                                                                                                               |
| owner            | b32431890c454e55920e7bc50b6ddba3                                                                                                                                                                                                                  |
| properties       | direct_url='rbd://fcd7abfc-9f3e-11e9-8480-52540035d3ce/images/8ac9ad11-8de3-477c-96f7-184f784ed629/snap', locations='[{u'url': u'rbd://fcd7abfc-9f3e-11e9-8480-52540035d3ce/images/8ac9ad11-8de3-477c-96f7-184f784ed629/snap', u'metadata': {}}]' |
| protected        | False                                                                                                                                                                                                                                             |
| schema           | /v2/schemas/image                                                                                                                                                                                                                                 |
| size             | 46137344                                                                                                                                                                                                                                          |
| status           | active                                                                                                                                                                                                                                            |
| tags             |                                                                                                                                                                                                                                                   |
| updated_at       | 2019-07-13T20:22:53Z                                                                                                                                                                                                                              |
| virtual_size     | None                                                                                                                                                                                                                                              |
| visibility       | private                                                                                                                                                                                                                                           |
+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
```

You will now see two images in your openstack image list prefixed with {{< student "" "" >}} in their name.

> Run openstack image list to see the available images

```
$ openstack image list
```

```
(overcloud) [student1@bastion ~]$ openstack image list
+--------------------------------------+---------------------+--------+
| ID                                   | Name                | Status |
+--------------------------------------+---------------------+--------+
| f04b16d2-cd9e-4c03-947b-20383282009b | centos7             | active |
| 663a45fa-a947-45a2-9dbe-4ac25803d85b | cirros              | active |
| 57f3da04-f33b-40d5-8851-ee9ddfe708f1 | rhel76              | active |
| ed758583-0a2f-4cbd-b85e-bda14837e199 | student1-cirros     | active |
| 8ac9ad11-8de3-477c-96f7-184f784ed629 | student1-cirros-cli | active |
| 03352bdc-142e-47b3-b42f-75364f6aa7ae | ubuntu1604          | active |
| 96d74563-846b-43a2-a18e-070a537d52ab | win2012r2           | active |
+--------------------------------------+---------------------+--------+
```

## Let's List the Available Instance Flavors Now

> Run the following command to see the existing flavors

```
$ openstack flavor list
```

```
(overcloud) [student1@bastion ~]$ openstack flavor list
+----+-------------+-------+------+-----------+-------+-----------+
| ID | Name        |   RAM | Disk | Ephemeral | VCPUs | Is Public |
+----+-------------+-------+------+-----------+-------+-----------+
| 1  | m1.tiny     |   256 |    1 |         0 |     1 | True      |
| 2  | m1.small    |  1024 |   10 |         0 |     1 | True      |
| 3  | m1.medium   |  2048 |   20 |         0 |     2 | True      |
| 4  | m1.large    |  4096 |   40 |         0 |     4 | True      |
| 5  | m1.xlarge   |  8192 |   80 |         0 |     8 | True      |
| 6  | cf.min      | 12288 |   80 |         0 |     4 | True      |
| 7  | ocp1.master | 16384 |   80 |         0 |     8 | True      |
| 8  | ocp1.node   | 32768 |   80 |         0 |     8 | True      |
| 9  | sat6.min    | 12288 |   80 |         0 |     4 | True      |
+----+-------------+-------+------+-----------+-------+-----------+
```

## Now We Will List Our Project's Floating IP Addresses

> List the existing floating IP addresses

```
$ openstack floating ip list
```

```
(overcloud) [student1@bastion ~]$ openstack floating ip list
+--------------------------------------+---------------------+------------------+--------------------------------------+--------------------------------------+----------------------------------+
| ID                                   | Floating IP Address | Fixed IP Address | Port                                 | Floating Network                     | Project                          |
+--------------------------------------+---------------------+------------------+--------------------------------------+--------------------------------------+----------------------------------+
| 3179f0b8-64f2-4959-b7a3-2a32f5852552 | 192.168.1.106       | 172.16.0.6       | 6ff12e22-4d1f-4473-95d5-c5254a2b6391 | a9995d51-dd08-4837-b6b7-8b565bf989bc | b32431890c454e55920e7bc50b6ddba3 |
| 92599c17-dfdc-4b1b-b295-17c28be76eca | 192.168.1.75        | None             | None                                 | a9995d51-dd08-4837-b6b7-8b565bf989bc | b32431890c454e55920e7bc50b6ddba3 |
| fcdbc24b-8b67-45fe-92d8-c3fa3287f778 | 192.168.1.113       | None             | None                                 | a9995d51-dd08-4837-b6b7-8b565bf989bc | b32431890c454e55920e7bc50b6ddba3 |
+--------------------------------------+---------------------+------------------+--------------------------------------+--------------------------------------+----------------------------------+
```

## Let's Now Create a Second Private Network

> First create the network

```
$ openstack network create private-b
```

```
(overcloud) [student1@bastion ~]$ openstack network create private-b
+---------------------------+--------------------------------------+
| Field                     | Value                                |
+---------------------------+--------------------------------------+
| admin_state_up            | UP                                   |
| availability_zone_hints   |                                      |
| availability_zones        |                                      |
| created_at                | 2019-07-13T20:30:30Z                 |
| description               |                                      |
| dns_domain                | None                                 |
| id                        | 797fe261-340a-41a0-bb21-4171326cd70d |
| ipv4_address_scope        | None                                 |
| ipv6_address_scope        | None                                 |
| is_default                | False                                |
| is_vlan_transparent       | None                                 |
| mtu                       | 1450                                 |
| name                      | private-b                            |
| port_security_enabled     | True                                 |
| project_id                | b32431890c454e55920e7bc50b6ddba3     |
| provider:network_type     | None                                 |
| provider:physical_network | None                                 |
| provider:segmentation_id  | None                                 |
| qos_policy_id             | None                                 |
| revision_number           | 3                                    |
| router:external           | Internal                             |
| segments                  | None                                 |
| shared                    | False                                |
| status                    | ACTIVE                               |
| subnets                   |                                      |
| tags                      |                                      |
| updated_at                | 2019-07-13T20:30:30Z                 |
+---------------------------+--------------------------------------+
```

> Then let's create the private-b subnet

```
$ openstack subnet create --network private-b --subnet-range 172.16.1.0/24 --dns-nameserver 192.168.0.4 private-b-subnet
```

```
(overcloud) [student1@bastion ~]$ openstack subnet create --network private-b --subnet-range 172.16.1.0/24 --dns-nameserver 192.168.0.4 private-b-subnet
+-------------------+--------------------------------------+
| Field             | Value                                |
+-------------------+--------------------------------------+
| allocation_pools  | 172.16.1.2-172.16.1.254              |
| cidr              | 172.16.1.0/24                        |
| created_at        | 2019-07-13T20:31:14Z                 |
| description       |                                      |
| dns_nameservers   | 192.168.0.4                          |
| enable_dhcp       | True                                 |
| gateway_ip        | 172.16.1.1                           |
| host_routes       |                                      |
| id                | 24a033df-7707-44ac-88b6-87bdde2d522f |
| ip_version        | 4                                    |
| ipv6_address_mode | None                                 |
| ipv6_ra_mode      | None                                 |
| name              | private-b-subnet                     |
| network_id        | 797fe261-340a-41a0-bb21-4171326cd70d |
| project_id        | b32431890c454e55920e7bc50b6ddba3     |
| revision_number   | 0                                    |
| segment_id        | None                                 |
| service_types     |                                      |
| subnetpool_id     | None                                 |
| tags              |                                      |
| updated_at        | 2019-07-13T20:31:14Z                 |
+-------------------+--------------------------------------+
```

> List the Neutron Networks and Subnets

```
$ openstack network list && openstack subnet list
```

```
(overcloud) [student1@bastion ~]$ openstack network list && openstack subnet list
+--------------------------------------+-----------+--------------------------------------+
| ID                                   | Name      | Subnets                              |
+--------------------------------------+-----------+--------------------------------------+
| 797fe261-340a-41a0-bb21-4171326cd70d | private-b | 24a033df-7707-44ac-88b6-87bdde2d522f |
| a9995d51-dd08-4837-b6b7-8b565bf989bc | public    | c8e9c906-63cb-4937-8ba6-529b3a25316d |
| f6a47e55-b213-4a40-8265-dc249a56741b | private-a | 00debc08-d555-4d3c-ab51-7b0b34a571b1 |
+--------------------------------------+-----------+--------------------------------------+
+--------------------------------------+------------------+--------------------------------------+----------------+
| ID                                   | Name             | Network                              | Subnet         |
+--------------------------------------+------------------+--------------------------------------+----------------+
| 00debc08-d555-4d3c-ab51-7b0b34a571b1 | private-a-sub    | f6a47e55-b213-4a40-8265-dc249a56741b | 172.16.0.0/24  |
| 24a033df-7707-44ac-88b6-87bdde2d522f | private-b-subnet | 797fe261-340a-41a0-bb21-4171326cd70d | 172.16.1.0/24  |
| c8e9c906-63cb-4937-8ba6-529b3a25316d | public-sub       | a9995d51-dd08-4837-b6b7-8b565bf989bc | 192.168.0.0/23 |
+--------------------------------------+------------------+--------------------------------------+----------------+
```

## Lastly, Let's Create an Instance Using the CLI

> Run the following command to boot a nova instance using the m1.tiny flavor, and the newest cirros image that we uploaded earlier in this lab.  
> We will also attach it to the new **private-b** network

```
$ openstack server create --image {{< student "" "-cirros-cli" >}} --flavor m1.tiny --key-name {{< student "" "" >}} --network private-b {{< student "" "-cirros-cli-1" >}}
```

```
(overcloud) [student1@bastion ~]$ openstack server create --image student1-cirros-cli --flavor m1.tiny --key-name student1 --network private-b student1-cirros-cli-1
+-----------------------------+------------------------------------------------------------+
| Field                       | Value                                                      |
+-----------------------------+------------------------------------------------------------+
| OS-DCF:diskConfig           | MANUAL                                                     |
| OS-EXT-AZ:availability_zone |                                                            |
| OS-EXT-STS:power_state      | NOSTATE                                                    |
| OS-EXT-STS:task_state       | scheduling                                                 |
| OS-EXT-STS:vm_state         | building                                                   |
| OS-SRV-USG:launched_at      | None                                                       |
| OS-SRV-USG:terminated_at    | None                                                       |
| accessIPv4                  |                                                            |
| accessIPv6                  |                                                            |
| addresses                   |                                                            |
| adminPass                   | GYr35n7VsrLf                                               |
| config_drive                |                                                            |
| created                     | 2019-07-13T20:33:27Z                                       |
| flavor                      | m1.tiny (1)                                                |
| hostId                      |                                                            |
| id                          | e0c0187f-e437-48fc-a415-36bfcb5fc2e6                       |
| image                       | student1-cirros-cli (8ac9ad11-8de3-477c-96f7-184f784ed629) |
| key_name                    | student1                                                   |
| name                        | student1-cirros-cli-1                                      |
| progress                    | 0                                                          |
| project_id                  | b32431890c454e55920e7bc50b6ddba3                           |
| properties                  |                                                            |
| security_groups             | name='default'                                             |
| status                      | BUILD                                                      |
| updated                     | 2019-07-13T20:33:27Z                                       |
| user_id                     | 1ae2f6781ade4af384fe770c135847b3                           |
| volumes_attached            |                                                            |
+-----------------------------+------------------------------------------------------------+
```

> You can watch openstack server list to see it go through the provisioning process and become active

```
$ watch openstack server list
```

```
Every 2.0s: openstack server list                                                                                                                                                                                      Sat Jul 13 16:39:03 2019

+--------------------------------------+-----------------------+--------+-------------------------------------+---------------------+---------+
| ID                                   | Name                  | Status | Networks                            | Image               | Flavor  |
+--------------------------------------+-----------------------+--------+-------------------------------------+---------------------+---------+
| e0c0187f-e437-48fc-a415-36bfcb5fc2e6 | student1-cirros-cli-1 | ACTIVE | private-b=172.16.1.6                | student1-cirros-cli | m1.tiny |
| 45a45a6e-6e51-4858-b5d0-9e16a9308c33 | student1-cirros-1     | ACTIVE | private-a=172.16.0.6, 192.168.1.106 | student1-cirros     | m1.tiny |
| cbd781be-cc64-4302-b15c-5a7ae805a917 | student1-cirros-2     | ACTIVE | private-a=172.16.0.14               | student1-cirros     | m1.tiny |
+--------------------------------------+-----------------------+--------+-------------------------------------+---------------------+---------+
```

# Summary

We have now gone through some of the same excercises that we accomplished in Horizon, using strictly the CLI. The flexibility with which we can interact with OpenStack is a tremendous benefit.

What if we could now take all of these manual steps we have gone through and put them into a template that does them all for us, the same way, every time?

We can do this with Heat. That will be our next lab.

{{< importPartial "footer/footer-hattrick.html" >}}
