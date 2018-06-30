---
title: 'Lab 4: Bastion Host Preparation'
workshops: openshift_install
layout: lab
workshop_weight: 40
---

## Bastion Node

The first set of steps for this lab will only apply to **the node you will be
performing your installation from**. In this workshop, we will be using your
**bastion** node for this.

### Base Packages

The following base packages need to be installed your **bastion** node:

- wget
- git
- net-tools
- bind-utils
- iptables-services
- bridge-utils
- bash-completion
- kexec-tools
- sos
- psacct

Begin by opening an SSH connection to your **bastion** node:

{{< highlight bash >}}
ssh ec2-user@bastion.studentXX.example.com
{{< /highlight >}}

Install the required base packages on your **bastion** node:

{{< highlight bash >}}
sudo yum install wget git net-tools bind-utils iptables-services bridge-utils bash-completion kexec-tools sos psacct -y
{{< /highlight >}}

Update all existing packages on your **bastion** node:

{{< highlight bash >}}
sudo yum update -y
{{< /highlight >}}

### OpenShift Installer Utilities

Install the OpenShift installer utilities and other tools required by the
installation process, such as Ansible and related configuration files:

{{< highlight bash >}}
sudo yum install atomic-openshift-utils -y
{{< /highlight >}}
