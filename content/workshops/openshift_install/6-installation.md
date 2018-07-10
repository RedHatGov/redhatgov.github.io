---
title: 'Lab 6: Installation'
workshops: openshift_install
layout: lab
workshop_weight: 60
---

## Advanced Installation

To install OpenShift, we will be using the **Advanced Installation** method
which requires you to build an Ansible inventory file with variables included.

For this lab, we will be walking through to options needed for this environment,
but it is recommended to look over the other available options after this
workshop to learn more about what you can configure when installing OpenShift.

The full documentation for the advanced installation method and all of the
available options can be found [here][1].

## Starting Template

For this workshop, you will start from the following barebones template and
add the options you need.

{{% alert info %}}
**Information**

A larger template with more options can be found on
your **bastion** host at `/usr/share/doc/openshift-ansible-docs-<OPENSHIFT_VERSION>/docs/example-inventories/hosts.ose.example`.
This file comes from the `atomic-openshift-utils` package.
{{% /alert %}}

Start by creating a file `~/hosts.ose` in your home directory with the following
content:

{{< highlight ini >}}
# Create an OSEv3 group that contains the masters and nodes groups
[OSEv3:children]
masters
nodes
etcd

# Set variables common for all OSEv3 hosts
[OSEv3:vars]

# host group for masters
[masters]
master.studentXX.example.com

[etcd]
master.studentXX.example.com

# NOTE: Currently we require that masters be part of the SDN which requires that they also be nodes
# However, in order to ensure that your masters are not burdened with running pods you should
# make them unschedulable by adding openshift_schedulable=False any node that's also a master.
[nodes]
master.studentXX.example.com
infra.studentXX.example.com
app01.studentXX.example.com
app02.studentXX.example.com
{{< /highlight >}}

{{% alert info %}}
**Information**

If you are using `vim` to edit your `~/hosts.ose` file, save the file, close
it, and re-open to get syntax highlighting to work.
{{% /alert %}}

## Variables

Most of the configuration of how to install OpenShift is done in the
`[OSEv3:vars]` section of the inventory file. Below we will walk through sets
of options and build out your installation configuration.

### How To Connect

You start by defining which user to use for the SSH connection to each node
that will be used by Ansible to do during the installation.

You'll be using the `ec2-user` to connect to your nodes. As a part
of provisioning this lab, SSH keys were already set up for the `ec2-user`
and copied to the `authorized_keys` file of each node.

Since the `ec2-user` is not the root user, you need to also specify that `sudo`
should be used for privilege escalation.

Add these options in the `[OSEv3:vars]` section below the options from the
previous step(s).

{{< highlight ini >}}
# SSH user, this user should allow ssh based auth without requiring a
# password. If using ssh key based auth, then the key should be managed by an
# ssh agent.
ansible_ssh_user=ec2-user

# If ansible_ssh_user is not root, ansible_become must be set to true and the
# user must be configured for passwordless sudo
ansible_become=yes
{{< /highlight >}}

### Deployment Type

The deployment for this lab will be for OpenShift Container Platform, which
was previously known as OpenShift Enterprise, therefore the option will be set
to `openshift-enterprise`. You will be deploying version 3.6 of OpenShift for
this workshop.

You'll also go ahead an specify the debug level and instructing the installer
to also install the OpenShift examples.

Add these options in the `[OSEv3:vars]` section below the options from the
previous step(s).

{{< highlight ini >}}
# Debug level for all OpenShift components (Defaults to 2)
debug_level=2

# Specify the deployment type. Valid values are origin and openshift-enterprise.
openshift_deployment_type=openshift-enterprise

# Specify the generic release of OpenShift to install. This is used mainly just during installation, after which we
# rely on the version running on the first master. Works best for containerized installs where we can usually
# use this to lookup the latest exact version of the container images, which is the tag actually used to configure
# the cluster. For RPM installations we just verify the version detected in your configured repos matches this
# release.
openshift_release=v3.6

# Manage openshift example imagestreams and templates during install and upgrade
openshift_install_examples=true
{{< /highlight >}}

### Authentication

In this workshop, you will be using the `HTPasswd` identity provider.

{{% alert info %}}
**Information**

The `HTPasswd` indentity provider is used in this workshop since it doesn't
require additional infrastructure in this environment. To view the other
authentication options, check out the docs [here][2].
{{% /alert %}}

Add these options in the `[OSEv3:vars]` section below the options from the
previous step(s).

{{< highlight ini >}}
# htpasswd auth
openshift_master_identity_providers=[{'name': 'htpasswd_auth', 'login': 'true', 'challenge': 'true', 'kind': 'HTPasswdPasswordIdentityProvider', 'filename': '/etc/origin/master/htpasswd'}]
# Defining htpasswd users
#openshift_master_htpasswd_users={'user1': '<pre-hashed password>', 'user2': '<pre-hashed password>'}
# or
#openshift_master_htpasswd_file=<path to local pre-generated htpasswd file>
{{< /highlight >}}

### Cluster Hostnames

Your lab environment is a non-HA configuration that only contains a single
master node. By default, the hostname for your API and Web Console would be
set to the hostname of the **master** node.

You are going to override this to be a different hostname that is more generic
than the hostname of the master node.

You will also set the default subdomain that will be used when deploying
applications in OpenShift and creating routes. This hostname is already setup
for you as a wildcard DNS entry that points to your **infra** node.

Add these options in the `[OSEv3:vars]` section below the options from the
previous step(s).

{{< highlight ini >}}
# Native high availability cluster method with optional load balancer.
# If no lb group is defined, the installer assumes that a load balancer has
# been preconfigured. For installation the value of
# openshift_master_cluster_hostname must resolve to the load balancer
# or to one or all of the masters defined in the inventory if no load
# balancer is present.
openshift_master_cluster_method=native
openshift_master_cluster_hostname=studentXX.example.com
openshift_master_cluster_public_hostname=studentXX.example.com

# default subdomain to use for exposed routes
openshift_master_default_subdomain=apps.studentXX.example.com
{{< /highlight >}}

### Node Selector

When applications are deployed in OpenShift, they need a set of compute
resources to use. You don't want these resources to come from your **master**
or **infra** nodes. Therefore, you will set a default node selector to ensure
your applications are deployed on the correct compute resources.

In a later step, you will see how we label the nodes to make this work.

Add these options in the `[OSEv3:vars]` section below the options from the
previous step(s).

{{< highlight ini >}}
# default project node selector
osm_default_node_selector='purpose=app'
{{< /highlight >}}

### OpenShift Router

The OpenShift router is a component that is required by OpenShift and is
installed by default. However, we want to ensure that the router is running
on the **infra** node.

In a later step, you will see how we label the nodes to make this work.

Add these options in the `[OSEv3:vars]` section below the options from the
previous step(s).

{{< highlight ini >}}
# OpenShift Router Options
#
# An OpenShift router will be created during install if there are
# nodes present with labels matching the default router selector,
# "region=infra". Set openshift_node_labels per node as needed in
# order to label nodes.
#
# Example:
# [nodes]
# node.example.com openshift_node_labels="{'region': 'infra'}"
#
# Router selector (optional)
# Router will only be created if nodes matching this label are present.
# Default value: 'region=infra'
openshift_hosted_router_selector='purpose=infra'
{{< /highlight >}}

### OpenShift Registry

The OpenShift registry is another component required by OpenShift and is
installed by default. we also want to ensure that the router is running on the
**infra** node.

The registry requires storage to persist the generated container images
that are created in OpenShift. For this workshop, an NFS server is being run
in the environment for each student to use.

{{% alert warning %}}
**Warning**

In a production environment, NFS is **NOT** a supported storage backend for
the registry. You can find more information about storage options for the
registry [here][3].

NFS storage **is** supported by OpenShift for your applications.
{{% /alert %}}

In a later step, you will see how we label the nodes to make this work.

Add these options in the `[OSEv3:vars]` section below the options from the
previous step(s).

{{< highlight ini >}}
# Openshift Registry Options
#
# An OpenShift registry will be created during install if there are
# nodes present with labels matching the default registry selector,
# "region=infra". Set openshift_node_labels per node as needed in
# order to label nodes.
#
# Example:
# [nodes]
# node.example.com openshift_node_labels="{'region': 'infra'}"
#
# Registry selector (optional)
# Registry will only be created if nodes matching this label are present.
# Default value: 'region=infra'
openshift_hosted_registry_selector='purpose=infra'

# Registry Storage Options
#
# External NFS Host
# NFS volume must already exist with path "nfs_directory/volume_name" on
# the storage_host. For example, the remote volume path using these
# options would be "nfs.example.com:/exports/registry"
openshift_hosted_registry_storage_kind=nfs
openshift_hosted_registry_storage_access_modes=['ReadWriteMany']
openshift_hosted_registry_storage_host=instructor.example.com
openshift_hosted_registry_storage_nfs_directory=/exports/studentXX
openshift_hosted_registry_storage_volume_name=registry
openshift_hosted_registry_storage_volume_size=10Gi
{{< /highlight >}}

### Metrics

An optional, but recommended, component of OpenShift is the metrics stack for
monitoring the CPU, memory, and network traffic of your applications.

The metrics stack also requires storage to persist its data. You will be using
the NFS server set up in the lab environment for this.

Add these options in the `[OSEv3:vars]` section below the options from the
previous step(s).

{{< highlight ini >}}
# Metrics deployment
# See: https://docs.openshift.com/enterprise/latest/install_config/cluster_metrics.html
#
# By default metrics are not automatically deployed, set this to enable them
openshift_hosted_metrics_deploy=true
#
# Storage Options
# If openshift_hosted_metrics_storage_kind is unset then metrics will be stored
# in an EmptyDir volume and will be deleted when the cassandra pod terminates.
# Storage options A & B currently support only one cassandra pod which is
# generally enough for up to 1000 pods. Additional volumes can be created
# manually after the fact and metrics scaled per the docs.
#
# Option B - External NFS Host
# NFS volume must already exist with path "nfs_directory/volume_name" on
# the storage_host. For example, the remote volume path using these
# options would be "nfs.example.com:/exports/metrics"
openshift_hosted_metrics_storage_kind=nfs
openshift_hosted_metrics_storage_access_modes=['ReadWriteOnce']
openshift_hosted_metrics_storage_host=instructor.example.com
openshift_hosted_metrics_storage_nfs_directory=/exports/studentXX
openshift_hosted_metrics_storage_volume_name=metrics
openshift_hosted_metrics_storage_volume_size=10Gi
openshift_hosted_metrics_storage_labels={'storage': 'metrics'}

# Additional metrics settings
openshift_metrics_cassandra_nodeselector={'purpose': 'infra'}
openshift_metrics_hawkular_nodeselector={'purpose': 'infra'}
openshift_metrics_heapster_nodeselector={'purpose': 'infra'}
{{< /highlight >}}

### Aggregated Logging

Another optional, but recommended, component of OpenShift is the aggregated
logging stack for capturing the log output of your applications.

The logging stack also requires storage to persist its data. You will be using
the NFS server set up in the lab environment for this.

Add these options in the `[OSEv3:vars]` section below the options from the
previous step(s).

{{< highlight ini >}}
# Logging deployment
#
# Currently logging deployment is disabled by default, enable it by setting this
openshift_hosted_logging_deploy=true
#
# Logging storage config
# Option B - External NFS Host
# NFS volume must already exist with path "nfs_directory/volume_name" on
# the storage_host. For example, the remote volume path using these
# options would be "nfs.example.com:/exports/logging"
openshift_hosted_logging_storage_kind=nfs
openshift_hosted_logging_storage_access_modes=['ReadWriteOnce']
openshift_hosted_logging_storage_host=instructor.example.com
openshift_hosted_logging_storage_nfs_directory=/exports/studentXX
openshift_hosted_logging_storage_volume_name=logging
openshift_hosted_logging_storage_volume_size=10Gi
openshift_hosted_logging_storage_labels={'storage': 'logging'}

# Additional logging settings
# See https://github.com/openshift/openshift-ansible/tree/release-3.6/roles/openshift_logging
openshift_logging_es_cluster_size=1
openshift_logging_es_memory_limit=4G
openshift_logging_es_nodeselector={'purpose': 'infra'}
openshift_logging_curator_nodeselector={'purpose': 'infra'}
openshift_logging_kibana_nodeselector={'purpose': 'infra'}
{{< /highlight >}}

### Multitenancy

By default, OpenShift deploys with a flat network that allows any application
running in OpenShift to communicate with any other application within OpenShift.

In many cases, this is not desirable so it is recommended to enable the
multitenant plugin to lock applications down so that they can only communicate
with the other things running within the same project, but not across projects.

Add these options in the `[OSEv3:vars]` section below the options from the
previous step(s).

{{< highlight ini >}}
# Configure the multi-tenant SDN plugin (default is 'redhat/openshift-ovs-subnet')
os_sdn_network_plugin_name='redhat/openshift-ovs-multitenant'
{{< /highlight >}}

### OpenShift SDN

There are two networks used in the OpenShift SDN. One for use in assigning each
pod its own IP address. The other for assigning each service its own IP
address.

In this workshop, you will be using the default values. We could leave these
options out and they would be configured to the same values we are going to be
setting automatically.

The reason for setting them explicitly here is to point out that these values
cannot be changed after you install OpenShift so it is important to ensure that
these are set to values that do not overlap CIDR ranges already existant in
your environment.

Add these options in the `[OSEv3:vars]` section below the options from the
previous step(s).

{{< highlight ini >}}
# Configure SDN cluster network and kubernetes service CIDR blocks. These
# network blocks should be private and should not conflict with network blocks
# in your infrastructure that pods may require access to. Can not be changed
# after deployment.
#
# WARNING : Do not pick subnets that overlap with the default Docker bridge subnet of
# 172.17.0.0/16.  Your installation will fail and/or your configuration change will
# cause the Pod SDN or Cluster SDN to fail.
#
# WORKAROUND : If you must use an overlapping subnet, you can configure a non conflicting
# docker0 CIDR range by adding '--bip=192.168.2.1/24' to DOCKER_NETWORK_OPTIONS
# environment variable located in /etc/sysconfig/docker-network.
osm_cluster_network_cidr=10.128.0.0/14
openshift_portal_net=172.30.0.0/16
{{< /highlight >}}

### API and Web Console Port

The last configuration option we will set is the ports to use for the
OpenShift API and the Web Console.

By default these are set to `8443`, which is a non-standard HTTPS port. To
prevent having to type the port number each time you use the browser or log
in to the API on the command line, you will override these to be the standard
HTTPS port `443`.

Add these options in the `[OSEv3:vars]` section below the options from the
previous step(s).

{{< highlight ini >}}
# Configure master API and console ports.
openshift_master_api_port=443
openshift_master_console_port=443
{{< /highlight >}}

## Hosts

The last section of the inventory file is where we specify the actual hosts
that will be part of the OpenShift cluster.

In the barebones file, you already have the hostnames of your nodes specified,
but we need to make a few modifications to tell OpenShift which nodes are
reserved for which functions.

If you recall in some of the previous configuration steps, we told specifc
components to look for certain node labels to use when deploying those
components. In this section, we will set those labels.

We will also be telling OpenShift that the **master** node is not to be used
for deploying user application by setting its scheduling to disabled.

Update your barebones section to look like the following.

{{< highlight ini >}}
# host group for masters
[masters]
master.studentXX.example.com

[etcd]
master.studentXX.example.com

# NOTE: Currently we require that masters be part of the SDN which requires that they also be nodes
# However, in order to ensure that your masters are not burdened with running pods you should
# make them unschedulable by adding openshift_schedulable=False any node that's also a master.
[nodes]
master.studentXX.example.com openshift_schedulable=False
infra.studentXX.example.com openshift_node_labels="{'purpose': 'infra'}"
app01.studentXX.example.com openshift_node_labels="{'purpose': 'app'}"
app02.studentXX.example.com openshift_node_labels="{'purpose': 'app'}"
{{< /highlight >}}

## Installation

Now you're ready to kick off the installation process with the inventory file
you just created.

{{< highlight bash >}}
ansible-playbook -i ~/hosts.ose /usr/share/ansible/openshift-ansible/playbooks/byo/config.yml
{{< /highlight >}}

## Final Inventory Example

After all of the configuration steps from above, your final inventory file
should look like the following.

{{% alert warning %}}
**Warning**

**If you are looking ahead at the steps in this lab**, you are encouraged to go
through each of the steps above one at a time instead of taking a shortcut and
copy/pasting this file. This file is the final example but does not explain
why you are setting each option like the above steps are.
{{% /alert %}}

{{< highlight ini >}}
# Create an OSEv3 group that contains the masters and nodes groups
[OSEv3:children]
masters
nodes
etcd

# Set variables common for all OSEv3 hosts
[OSEv3:vars]
# SSH user, this user should allow ssh based auth without requiring a
# password. If using ssh key based auth, then the key should be managed by an
# ssh agent.
ansible_ssh_user=ec2-user

# If ansible_ssh_user is not root, ansible_become must be set to true and the
# user must be configured for passwordless sudo
ansible_become=yes

# Debug level for all OpenShift components (Defaults to 2)
debug_level=2

# Specify the deployment type. Valid values are origin and openshift-enterprise.
openshift_deployment_type=openshift-enterprise

# Specify the generic release of OpenShift to install. This is used mainly just during installation, after which we
# rely on the version running on the first master. Works best for containerized installs where we can usually
# use this to lookup the latest exact version of the container images, which is the tag actually used to configure
# the cluster. For RPM installations we just verify the version detected in your configured repos matches this
# release.
openshift_release=v3.6

# Manage openshift example imagestreams and templates during install and upgrade
openshift_install_examples=true

# htpasswd auth
openshift_master_identity_providers=[{'name': 'htpasswd_auth', 'login': 'true', 'challenge': 'true', 'kind': 'HTPasswdPasswordIdentityProvider', 'filename': '/etc/origin/master/htpasswd'}]
# Defining htpasswd users
#openshift_master_htpasswd_users={'user1': '<pre-hashed password>', 'user2': '<pre-hashed password>'}
# or
#openshift_master_htpasswd_file=<path to local pre-generated htpasswd file>

# Native high availability cluster method with optional load balancer.
# If no lb group is defined, the installer assumes that a load balancer has
# been preconfigured. For installation the value of
# openshift_master_cluster_hostname must resolve to the load balancer
# or to one or all of the masters defined in the inventory if no load
# balancer is present.
openshift_master_cluster_method=native
openshift_master_cluster_hostname=studentXX.example.com
openshift_master_cluster_public_hostname=studentXX.example.com

# default subdomain to use for exposed routes
openshift_master_default_subdomain=apps.studentXX.example.com

# default project node selector
osm_default_node_selector='purpose=app'

# OpenShift Router Options
#
# An OpenShift router will be created during install if there are
# nodes present with labels matching the default router selector,
# "region=infra". Set openshift_node_labels per node as needed in
# order to label nodes.
#
# Example:
# [nodes]
# node.example.com openshift_node_labels="{'region': 'infra'}"
#
# Router selector (optional)
# Router will only be created if nodes matching this label are present.
# Default value: 'region=infra'
openshift_hosted_router_selector='purpose=infra'

# Openshift Registry Options
#
# An OpenShift registry will be created during install if there are
# nodes present with labels matching the default registry selector,
# "region=infra". Set openshift_node_labels per node as needed in
# order to label nodes.
#
# Example:
# [nodes]
# node.example.com openshift_node_labels="{'region': 'infra'}"
#
# Registry selector (optional)
# Registry will only be created if nodes matching this label are present.
# Default value: 'region=infra'
openshift_hosted_registry_selector='purpose=infra'

# Registry Storage Options
#
# External NFS Host
# NFS volume must already exist with path "nfs_directory/volume_name" on
# the storage_host. For example, the remote volume path using these
# options would be "nfs.example.com:/exports/registry"
openshift_hosted_registry_storage_kind=nfs
openshift_hosted_registry_storage_access_modes=['ReadWriteMany']
openshift_hosted_registry_storage_host=instructor.example.com
openshift_hosted_registry_storage_nfs_directory=/exports/studentXX
openshift_hosted_registry_storage_volume_name=registry
openshift_hosted_registry_storage_volume_size=10Gi

# Metrics deployment
# See: https://docs.openshift.com/enterprise/latest/install_config/cluster_metrics.html
#
# By default metrics are not automatically deployed, set this to enable them
openshift_hosted_metrics_deploy=true
#
# Storage Options
# If openshift_hosted_metrics_storage_kind is unset then metrics will be stored
# in an EmptyDir volume and will be deleted when the cassandra pod terminates.
# Storage options A & B currently support only one cassandra pod which is
# generally enough for up to 1000 pods. Additional volumes can be created
# manually after the fact and metrics scaled per the docs.
#
# Option B - External NFS Host
# NFS volume must already exist with path "nfs_directory/volume_name" on
# the storage_host. For example, the remote volume path using these
# options would be "nfs.example.com:/exports/metrics"
openshift_hosted_metrics_storage_kind=nfs
openshift_hosted_metrics_storage_access_modes=['ReadWriteOnce']
openshift_hosted_metrics_storage_host=instructor.example.com
openshift_hosted_metrics_storage_nfs_directory=/exports/studentXX
openshift_hosted_metrics_storage_volume_name=metrics
openshift_hosted_metrics_storage_volume_size=10Gi
openshift_hosted_metrics_storage_labels={'storage': 'metrics'}

# Additional metrics settings
openshift_metrics_cassandra_nodeselector={'purpose': 'infra'}
openshift_metrics_hawkular_nodeselector={'purpose': 'infra'}
openshift_metrics_heapster_nodeselector={'purpose': 'infra'}

# Logging deployment
#
# Currently logging deployment is disabled by default, enable it by setting this
openshift_hosted_logging_deploy=true
#
# Logging storage config
# Option B - External NFS Host
# NFS volume must already exist with path "nfs_directory/volume_name" on
# the storage_host. For example, the remote volume path using these
# options would be "nfs.example.com:/exports/logging"
openshift_hosted_logging_storage_kind=nfs
openshift_hosted_logging_storage_access_modes=['ReadWriteOnce']
openshift_hosted_logging_storage_host=instructor.example.com
openshift_hosted_logging_storage_nfs_directory=/exports/studentXX
openshift_hosted_logging_storage_volume_name=logging
openshift_hosted_logging_storage_volume_size=10Gi
openshift_hosted_logging_storage_labels={'storage': 'logging'}

# Additional logging settings
# See https://github.com/openshift/openshift-ansible/tree/release-3.6/roles/openshift_logging
openshift_logging_es_cluster_size=1
openshift_logging_es_memory_limit=4G
openshift_logging_es_nodeselector={'purpose': 'infra'}
openshift_logging_curator_nodeselector={'purpose': 'infra'}
openshift_logging_kibana_nodeselector={'purpose': 'infra'}

# Configure the multi-tenant SDN plugin (default is 'redhat/openshift-ovs-subnet')
os_sdn_network_plugin_name='redhat/openshift-ovs-multitenant'

# Configure SDN cluster network and kubernetes service CIDR blocks. These
# network blocks should be private and should not conflict with network blocks
# in your infrastructure that pods may require access to. Can not be changed
# after deployment.
#
# WARNING : Do not pick subnets that overlap with the default Docker bridge subnet of
# 172.17.0.0/16.  Your installation will fail and/or your configuration change will
# cause the Pod SDN or Cluster SDN to fail.
#
# WORKAROUND : If you must use an overlapping subnet, you can configure a non conflicting
# docker0 CIDR range by adding '--bip=192.168.2.1/24' to DOCKER_NETWORK_OPTIONS
# environment variable located in /etc/sysconfig/docker-network.
osm_cluster_network_cidr=10.128.0.0/14
openshift_portal_net=172.30.0.0/16

# Configure master API and console ports.
openshift_master_api_port=443
openshift_master_console_port=443

# host group for masters
[masters]
master.studentXX.example.com

[etcd]
master.studentXX.example.com

# NOTE: Currently we require that masters be part of the SDN which requires that they also be nodes
# However, in order to ensure that your masters are not burdened with running pods you should
# make them unschedulable by adding openshift_schedulable=False any node that's also a master.
[nodes]
master.studentXX.example.com openshift_schedulable=False
infra.studentXX.example.com openshift_node_labels="{'purpose': 'infra'}"
app01.studentXX.example.com openshift_node_labels="{'purpose': 'app'}"
app02.studentXX.example.com openshift_node_labels="{'purpose': 'app'}"
{{< /highlight >}}


[1]: https://docs.openshift.com/container-platform/3.6/install_config/install/advanced_install.html
[2]: https://docs.openshift.com/container-platform/3.6/install_config/configuring_authentication.html
[3]: https://docs.openshift.com/container-platform/3.6/install_config/registry/deploy_registry_existing_clusters.html#storage-for-the-registry
