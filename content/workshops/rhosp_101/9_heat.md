---
title: Lab 8 - Using Heat to Describe Stacks
workshops: rhosp_101
workshop_weight: 18
layout: lab
---

# We Have Done a Ton of Stuff, But All Manually. How Do We Orchestrate?

In OpenStack, the answer to that is **Heat**.

Heat is the main project for orchestration in OpenStack. It implements an orchestration engine to launch multiple composite cloud applications based on templates in the form of text files that can be treated like code. A native Heat template format is evolving, but Heat also endeavours to provide compatibility with the AWS CloudFormation template format, so that many existing CloudFormation templates can be launched on OpenStack. Heat provides both an OpenStack-native ReST API and a CloudFormation-compatible Query API.

Why **Heat**? It makes the clouds rise!

In this lab, we are going to walk through instantiating a Heat stack via CLI.

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

> Verify that you are connected by running nova list

```
$ openstack server list
```

You should see the instances you created in the previous labs.

```
(overcloud) [student1@bastion ~]$ openstack server list
+--------------------------------------+-----------------------+--------+-------------------------------------+---------------------+---------+
| ID                                   | Name                  | Status | Networks                            | Image               | Flavor  |
+--------------------------------------+-----------------------+--------+-------------------------------------+---------------------+---------+
| e0c0187f-e437-48fc-a415-36bfcb5fc2e6 | student1-cirros-cli-1 | ACTIVE | private-b=172.16.1.6                | student1-cirros-cli | m1.tiny |
| 45a45a6e-6e51-4858-b5d0-9e16a9308c33 | student1-cirros-1     | ACTIVE | private-a=172.16.0.6, 192.168.1.106 | student1-cirros     | m1.tiny |
| cbd781be-cc64-4302-b15c-5a7ae805a917 | student1-cirros-2     | ACTIVE | private-a=172.16.0.14               | student1-cirros     | m1.tiny |
+--------------------------------------+-----------------------+--------+-------------------------------------+---------------------+---------+
```

## Now Let's Examine the Heat Template

```
(overcloud) [student1@bastion ~]$ cat heat-example.yaml 
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
    default: rhel76
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
$ openstack stack create --parameter keypair={{< student "" "" >}} --parameter image=rhel76 -t heat-example.yaml {{< student "" "-stack" >}}
```

Here is an example run.
```
(overcloud) [student1@bastion ~]$ openstack stack create --parameter keypair=student1 --parameter image=rhel76 -t heat-example.yaml student1-stack
+---------------------+--------------------------------------+
| Field               | Value                                |
+---------------------+--------------------------------------+
| id                  | 561d326e-4135-41ff-8254-7527f4261c5e |
| stack_name          | student1-stack                       |
| description         | A simple server.                     |
| creation_time       | 2019-07-13T20:49:47Z                 |
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
Every 2.0s: openstack stack list                                                               Sat Jul 13 17:13:58 2019

+--------------------------------------+----------------+-----------------+----------------------+--------------+
| ID                                   | Stack Name     | Stack Status    | Creation Time        | Updated Time |
+--------------------------------------+----------------+-----------------+----------------------+--------------+
| 561d326e-4135-41ff-8254-7527f4261c5e | student1-stack | CREATE_COMPLETE | 2019-07-13T20:49:47Z | None		|
+--------------------------------------+----------------+-----------------+----------------------+--------------+
```

# Examining Stack Topology in Horizon

> Navigate to Orchestration -> Stacks using the second level navigation tabs  

{{< figure src="../images/lab8-heat-1.png" title="Lab 8 Figure 1: Heat Stack List" >}}

> Click on **{{< student "" "-stack" >}}**

{{< figure src="../images/lab8-heat-2.png" title="Lab 8 Figure 2: Heat Stack Topology for the New student1-stack" >}}

# Examining Project Network Topology

> Navigate to Network -> Network Topology using the second level navigation tabs.

{{< figure src="../images/lab8-heat-3.png" title="Lab 8 Figure 3: Neutron Network Topology" >}}

# Summary

With the power of Heat, we just did in 1 command with a single YAML Heat Orchestration Template what it took us 6 labs to do previously via Horizon.

The major benefit to this is that we can version control our Heat templates and provisioning can be repeated in the same manner every time.

Heat templates can also be exposed to Red Hat CloudForms to present to end users in a service catalog. CloudForms is included in the purchase of Red Hat OpenStack Platform.

OpenStack has come a long way towards being the cloud software of choice for enterprise data centers.

{{< importPartial "footer/footer-hattrick.html" >}}
