---
title: Introduction to Red Hat OpenStack Platform
workshops: rhosp_101
workshop_weight: 10
layout: lab
---

# Red Hat OpenStack Platform Overview

Red Hat OpenStack Platform is implemented as a collection of interacting services that control compute, storage, and networking resources. The following diagram provides a high-level overview of the OpenStack core services.

{{< figure src="../images/rhosp-service-overview.png" title="OpenStack Services Overview" >}}

1. Horizon - User interface built to give a graphical way to interact with OpenStack services
2. Keystone - Identity management service for projects, users, groups, roles, endpoints, etc.
3. Neutron - Software defined networking API service that can be backed by different SDN solutions. Default is Open vSwitch
4. Cinder - Block storage API that can be backed by many different storage backends including Ceph, NFS, SAN, LVM, etc.
5. Nova - Compute API for OpenStack. Default hypervisor is KVM. ESXi also supported
6. Glance - API for storing golden machine images. Backed by Object, Block, File or HTTP storage
7. Object - Object storage allows access to storage objects via API. Object storage is either Swift or Ceph RadowGW
8. Ceilometer - Ceilometer is a collection of services for gathering metrics over time and alerting cabability on those metrics
9. Heat - Orchestration of OpenStack resources into complete application stacks. Heat stacks defined in YAML tempates

## OpenStack Terminology

### Infrastructure-as-a-Service

**The capability** provided to the consumer is **to provision processing, storage, networks, and other fundamental computing resources where the consumer is able to deploy and run arbitrary software**, which can include operating systems and applications. **The consumer does not manage or control the underlying cloud infrastructure** but has control over operating systems, storage, and deployed applications; and possibly limited control of select networking components (e.g., host firewalls). [NIST Cloud Computing Definition](http://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-145.pdf)

Red Hat OpenStack Platform is Infrastructure-as-a-Service.

### Cloud controller

The coordinating manager. All machines in the OpenStack cloud communicate with the cloud controller(s) using the Advanced Message Queuing Protocol (AMQP). In Red Hat OpenStack Platform, messaging is handled by RabbitMQ.

### Compute node

A hypervisor; any machine running the Nova compute service. Often, the machine is running _only_ the Nova compute service.

### Storage node

A node used for either block, object or file storage; Often these are commodity servers with many disks available for Ceph or Swift.

### Project

A segmented collection of resources inside of the OpenStack cloud. Projects have quotas and can be assigned members or groups.

### Instance

A virtual machine. Some utilities may refer to this as a server.

### Stack

A group of instances built from a template. Template files are written in YAML. Stacks and the template files are used in the Heat orchestration service.

### Volume

A block device that is created by Cinder and is attached to a instance as storage.

# This Sounds Great, Can We Get to Work Already!

You got it!

{{< importPartial "footer/footer-hattrick.html" >}}
