---
title: Lab 8 - Using Heat to Describe Stacks
workshops: rhosp_101
workshop_weight: 18
layout: lab
---

# We Have Done a Ton of Stuff, But All Manually. How Do We Orchestrate?

In OpenStack, the answer to that is **Heat**.

Heat is the main project in the OpenStack Orchestration program. It implements an orchestration engine to launch multiple composite cloud applications based on templates in the form of text files that can be treated like code. A native Heat template format is evolving, but Heat also endeavours to provide compatibility with the AWS CloudFormation template format, so that many existing CloudFormation templates can be launched on OpenStack. Heat provides both an OpenStack-native ReST API and a CloudFormation-compatible Query API.

Why **Heat**? It makes the clouds rise!

In this lab, we are going to walk through instantiating a Heat stack via CLI.

## First, We Need Access to a System with the CLIs Installed

{{% alert warning %}}
In order to complete this lab, you will need an SSH client.

On Linux or Mac, you can just use your favorite terminal.

On Windows, you will need to download [putty](https://the.earth.li/~sgtatham/putty/latest/w64/putty.exe) if you don't already have it. This is an exe file that does not need to be installed. Just run.
{{% /alert %}}

> On Linux or Mac, in your terminal, ssh to rhshadowbox.hopto.org on port 22

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

You should see the instances you created in the previous labs.

```
[student1@workshop-bastion ~]$ openstack server list
+--------------------------------------+-----------------------+--------+-------------------------------------+--------------------+
| ID                                   | Name                  | Status | Networks                            | Image Name         |
+--------------------------------------+-----------------------+--------+-------------------------------------+--------------------+
| 73fadc50-2d9d-42ad-b304-f02a139eaf1f | student1-cirros-cli-1 | ACTIVE | private-b=172.16.1.5                | student1-cirros035 |
| 33d9ddda-d2d6-4021-9cf6-381d46dd8d2d | student1-cirros-2     | ACTIVE | private-a=172.16.0.11               | student1-cirros    |
| dc943883-f473-49ec-8e3f-7b057bf7474c | student1-cirros-1     | ACTIVE | private-a=172.16.0.12, 192.168.1.73 | student1-cirros    |
+--------------------------------------+-----------------------+--------+-------------------------------------+--------------------+
```

## Now Let's Examine the Heat Template

```
[student1@workshop-bastion ~]$ cat heat-example.yaml 
heat_template_version: 2014-10-16  
description: A simple server.  
parameters:
  private_network:
    type: string
    default: private-a
  public_network:
    type: string
    default: public
  image:
    type: string
    default: rhel75
  flavor:
    type: string
    default: m1.small
  keypair:
    type: string

resources:  
  server:
    type: OS::Nova::Server
    properties:
      block_device_mapping_v2:
        - device_name: vda
          delete_on_termination: true
          volume_id: { get_resource: volume }
      flavor: {get_param: flavor}
      metadata: {"metering.stack": {get_param: "OS::stack_id"}}
      key_name: {get_param: keypair}
      networks:
        - port: { get_resource: port }

  port:
    type: OS::Neutron::Port
    properties:
      network: {get_param: private_network}
      security_groups:
        - default

  floating_ip:
    type: OS::Neutron::FloatingIP
    properties:
      floating_network: {get_param: public_network}

  floating_ip_assoc:
    type: OS::Neutron::FloatingIPAssociation
    properties:
      floatingip_id: { get_resource: floating_ip }
      port_id: { get_resource: port }

  volume:
    type: OS::Cinder::Volume
    properties:
      image: {get_param: image}
      size: 10
```

> Let's Launch a Heat Stack with this Template

```
$ openstack stack create --parameter keypair=studentX --parameter image=rhel75 -t heat-example.yaml studentX-stack
```

Here is an example run.
```
[student1@workshop-bastion ~]$ openstack stack create --parameter keypair=student1 --parameter image=rhel75 -t heat-example.yaml student1-stack
+---------------------+--------------------------------------+
| Field               | Value                                |
+---------------------+--------------------------------------+
| id                  | 8ec5f05d-2b0f-4f5d-8532-e4ce43b6ad8d |
| stack_name          | student1-stack                       |
| description         | A simple server.                     |
| creation_time       | 2018-09-22T19:18:54Z                 |
| updated_time        | None                                 |
| stack_status        | CREATE_IN_PROGRESS                   |
| stack_status_reason | Stack CREATE started                 |
+---------------------+--------------------------------------+
```

> You can watch stack list to see the stack go through the provisioning process and become CREATE_COMPLETE

```
$ watch openstack stack list
```

```
Every 2.0s: openstack stack list                                                                                                   Sat Sep 22 15:19:49 2018

+--------------------------------------+----------------+-----------------+----------------------+--------------+
| ID                                   | Stack Name     | Stack Status    | Creation Time        | Updated Time |
+--------------------------------------+----------------+-----------------+----------------------+--------------+
| 8ec5f05d-2b0f-4f5d-8532-e4ce43b6ad8d | student1-stack | CREATE_COMPLETE | 2018-09-22T19:18:54Z | None         |
+--------------------------------------+----------------+-----------------+----------------------+--------------+
```

# Examining Stack Topology in Horizon

> Navigate to Orchestration -> Stacks using the second level navigation tabs  
> Click on **studentX-stack**

{{< figure src="../images/lab8-heat-2.png" title="Lab 8 Figure 2: Heat Stack Topology for the New student1-stack" >}}

# Examining Project Network Topology

> Navigate to Network -> Network Topology using the second level navigation tabs.

{{< figure src="../images/lab8-heat-3.png" title="Lab 8 Figure 3: Neutron Network Topology" >}}

# Summary

With the power of Heat, we just did in 1 lab what it took us multiple labs to do previously with a single YAML Heat Orchestration Template.

The major benefit to this is that we can version control our Heat templates and provisioning can be repeated in the same manner every time.

Heat templates can also be exposed to Red Hat CloudForms to present to end users in a service catalog. CloudForms is included in the purchase of Red Hat OpenStack Platform, as well as, Red Hat Infrastructure Site Subscription.

OpenStack has come a long way towards being the cloud software of choice for enterprise data centers.
