---
title: 'Lab 5: OpenShift Host Preparation'
workshops: openshift_install
layout: lab
workshop_weight: 50
---

## All Nodes

The steps in this lab will be done on all of your nodes, not the bastion node.

Start by opening an SSH session to each of your nodes, from your **bastion** host:

{{% alert info %}}
**Information**

You _should_ be able to use the shortnames below from your bastion host, but
if they are not working, use the fully qualified domain names for your hosts
(i.e. `master.studentXX.example.com`)
{{% /alert %}}

{{< highlight bash >}}
ssh master
ssh infra
ssh app01
ssh app02
{{< /highlight >}}

### Docker

Install `docker` on your each of your nodes.

{{< highlight bash >}}
sudo yum install docker-1.12.6 -y
{{< /highlight >}}

Determine the block device to use for docker storage on each of your nodes.

{{< highlight bash >}}
lsblk
{{< /highlight >}}

You're looking for the disk that has not been partitioned. This device should
be `/dev/xvdb`, but that may change due to changes in AWS instances. Your
output should look similar to:

{{< highlight text "hl_lines=5" >}}
NAME    MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
xvda    202:0    0  50G  0 disk
├─xvda1 202:1    0   1M  0 part
└─xvda2 202:2    0  50G  0 part /
xvdb    202:16   0  20G  0 disk
{{< /highlight >}}

Create storage configuration for docker on each of your nodes. Be sure to use
the name of the device from the previous step for the `DEVS` option in the
command below.

{{< highlight bash >}}
echo "
DEVS=/dev/xvdb
VG=docker-vg
" | sudo tee -a /etc/sysconfig/docker-storage-setup
{{< /highlight >}}

Run `docker-storage-setup` to configure local docker storage on each of your nodes.

{{< highlight bash >}}
sudo docker-storage-setup
{{< /highlight >}}

Start and enable the `docker` service on each of your nodes.

{{< highlight bash >}}
sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl status docker
{{< /highlight >}}
