---
title: 'Lab 3: Node Registration'
workshops: openshift_install
layout: lab
workshop_weight: 30
---

## Nothing To See Here

**For the purposes of this workshop, we have already subscribed the nodes to the
repositories needed to install OpenShift.**

{{% alert danger %}}
**Alert**

If you are participating in a workshop with this content, do **NOT** perform
the following steps. The repositories you need have already been added to your
nodes and the steps below are for reference.
{{% /alert %}}

## Summary

Below is a description of what would normally be required to register and
subscribe your nodes in order to install OpenShift. The full documention for
the steps outlined below can be found [here][1].

## Connect

You will need to register each node in your cluster to RHSM. Start by
opening an SSH session to each of your nodes.

{{< highlight bash >}}
ssh ec2-user@bastion.studentXX.example.com
ssh ec2-user@master.studentXX.example.com
ssh ec2-user@infra.studentXX.example.com
ssh ec2-user@app01.studentXX.example.com
ssh ec2-user@app02.studentXX.example.com
{{< /highlight >}}

## Subscribe Nodes

On each node, run the following command to register your nodes:

{{< highlight bash >}}
sudo subscription-manager register --username=<user_name> --password=<password>
{{< /highlight >}}

## Attach OpenShift Pool

List the available subscriptions related to OpenShift:

{{< highlight bash >}}
sudo subscription-manager list --available --matches '*OpenShift*'
{{< /highlight >}}

Find the **Pool ID** in the output from the previous command and use it to
attach the pool to your nodes:

{{< highlight bash >}}
sudo subscription-manager attach --pool=<pool_id>
{{< /highlight >}}

## Enable Required Repos

Before enabling the required repositories, ensure that all repositories are disabled:

{{< highlight bash >}}
sudo subscription-manager repos --disable='*'
{{< /highlight >}}

Enable all of the required repositories:

{{< highlight bash >}}
sudo subscription-manager repos \
    --enable="rhel-7-server-rpms" \
    --enable="rhel-7-server-extras-rpms" \
    --enable="rhel-7-server-ose-3.6-rpms" \
    --enable="rhel-7-fast-datapath-rpms"
{{< /highlight >}}


[1]: https://docs.openshift.com/container-platform/3.6/install_config/install/host_preparation.html#host-registration
