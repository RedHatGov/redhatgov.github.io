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

> On Linux or Mac, in your terminal, ssh to rhshadowbox.hopto.org on port 1122

```
$ ssh studentX@rhshadowbox.hopto.org -p 1122
```

If on Windows, run putty, enter **rhshadowbox.hopto.org** as the host and **1122** as the port.

You will get asked if you are sure you want to connect. Type **yes** and hit enter.

Login with your studentX credentials.

## Let's Autenticate to the OpenStack Cloud

> Source your studentXrc file

```
$ source studentXrc
```

> Verify that you are connected by running nova list

```
$ nova list
```

You should see the two instances you created in the previous lab.

{{< figure src="../images/lab7-using-clis-1.png" title="Lab 7 Figure 1: Logging into CLI system and Verifying Connectivity to OpenStack" >}}

## Now Let's Upload Another Cirros Image for Fun

> First we'll download the image using curl

```
$ curl -o ~/cirros035.qcow2 http://download.cirros-cloud.net/0.3.5/cirros-0.3.5-x86_64-disk.img
```

> Upload the cirros test image to glance

```
$ glance image-create --name studentX-cirros035 --disk-format qcow2 --container-format bare --visibility private --file ~/cirros035.qcow2
```

{{< figure src="../images/lab7-using-clis-2.png" title="Lab 7 Figure 2: Uploading a New Image to Glance" >}}

You will now see two images in your glance image list prefixed with studentX-cirros

> Run openstack image list (or glance image-list) to see the available images

```
$ openstack image list
```

{{< figure src="../images/lab7-using-clis-3.png" title="Lab 7 Figure 3: Listing Images in Glance" >}}

## Let's List the Available Instance Flavors Now

> Run the following command to see the existing flavors

```
$ openstack flavor list
```

{{< figure src="../images/lab7-using-clis-4.png" title="Lab 7 Figure 4: Listing Flavors in OpenStack" >}}

## Now We Will List Our Project's Floating IP Addresses

> List the existing floating IP addresses

```
openstack floating ip list
```

{{< figure src="../images/lab7-using-clis-5.png" title="Lab 7 Figure 5: Listing Floating IP Addresses in the Project" >}}

## Let's Now Create a Second Private Network

> First create the network

```
$ openstack network create private-b
```

{{< figure src="../images/lab7-using-clis-6.png" title="Lab 7 Figure 6: Adding a Second Private Network in the Project" >}}

> Then let's create the private-b subnet

```
$ openstack subnet create --network private-b --subnet-range 172.16.1.0/24 --dns-nameserver 192.168.0.1 private-b-subnet
```

{{< figure src="../images/lab7-using-clis-7.png" title="Lab 7 Figure 7: Adding a Subnet to the Network in the Project" >}}

> List the Neutron Networks and Subnets

```
$ openstack network list

$ openstack subnet list
```

{{< figure src="../images/lab7-using-clis-8.png" title="Lab 7 Figure 8: Listing Networks and Subnets within the Project" >}}

## Lastly, Let's Create an Instance Using the CLIs

> First we need to get the network UUID for private-b network

```
$ neutron net-list
```

{{< figure src="../images/lab7-using-clis-9.png" title="Lab 7 Figure 9: Neutron Network List with the UUID Highlighted for private-b network" >}}

{{% alert info %}}
Note that your Network UUID will be unique. In this example the value is: 8d6afc30-ac5e-4e27-8276-15998a3a917a
{{% /alert %}}

> Run the following command to boot a nova instance using the m1.tiny flavor, and the newest cirros image that we uploaded earlier in this lab.  
> We will also attach it to the new **private-b** network

```
$ openstack server create --image studentX-cirros035 --flavor m1.tiny --key-name studentX --nic net-id=Your-Network-UUID-Here studentX-instance-cli-1
```

{{< figure src="../images/lab7-using-clis-10.png" title="Lab 7 Figure 10: Booting Up a New Instance via CLI" >}}

> You can watch nova list to see it go through the provisioning process and become active

```
$ watch nova list
```

{{< figure src="../images/lab7-using-clis-11.png" title="Lab 7 Figure 11: Nova List Showing the New Instance Active" >}}

# Summary

We have now gone through some of the same excercises that we accomplished in Horizon, using strictly the CLIs. The flexibility with which we can interact with OpenStack is a tremendous benefit.

What if we could now take all of these manual steps we've gone through and put them into a template that does them all for us, the same way, every time?

We can do this with Heat. That will be our next lab.
