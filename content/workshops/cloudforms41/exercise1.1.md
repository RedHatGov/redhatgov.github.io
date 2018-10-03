---
title: Exercise 1.1 - Explore Your First Infrastructure Provider
workshops: cloudforms41
workshop_weight: 110
layout: lab
---
# Exercise 1.1: Working with Infrastructure Providers


## Exercise Description
Learn to view, search and manage infrastructure providers, in Red Hat CloudForms.

In Red Hat CloudForms, an infrastructure provider is a virtual infrastructure environment that you can add to a Red Hat CloudForms appliance, to manage and interact with the resources, in that environment.

In other words, a infrastructure provider is a management platform for managing virtual machines from a single type of hypervisor. Infrastructure providers supported by CloudForms are Red Hat Enterprise Virtualization Management (RHEV-M), VMware vCenter and Microsoft System Center Virtual Machine Manager (SCVMM).


## Section 1: Explore Infrastructure Providers

### Step 1: Select **Compute** → **Infrastructure** → **Providers**.

<img title="Infrastructure Providers" src="../images/cfme-nav-compute-infra-providers.png" width="1000"/><br/>
*Infrastructure Providers*

### Step 2: view the list of your data center infrastructure providers, such as VMware vCenter and Red Hat Enterprise Virtualization.


## Section 2: Discover Infrastructure Providers

In very large environments, you can discover new infrastructure providers.

### Step 1: Click <i class="fa fa-cog" aria-hidden="true"></i> (**Configuration**), then click <i class="fa fa-search" aria-hidden="true"></i> (**Discover**).

<br><img title="Discover Infrastructure Providers" src="../images/cfme-nav-discover-infra-providers.png" width="1000"/><br/>
*Discover Infrastructure Providers*

<p>{{% alert warning %}} Review the data entry screen, but do not enter any information. {{% /alert %}}</p>

### Step 2: Click **Cancel** to return to the previous screen.

<br><img title="Cancel Discover Infrastructure Providers" src="../images/cfme-nav-discover-infra-providers-cancel.png" width="1000"/><br/>
*Cancel Discover Infrastructure Providers*


## Section 3: Add Infrastructure Providers

You can also add infrastructure providers, if known.

### Step 1: Click <i class="fa fa-cog" aria-hidden="true"></i> (**Configuration**), then click <i class="fa fa-plus-circle" aria-hidden="true"></i> (**Add**).

<img title="Add Infrastructure Providers" src="../images/cfme-nav-add-infra-providers.png" width="1000"/><br/>
*Add Infrastructure Providers*

### Step 2: Review the data entry screen, but do not enter any information.

Step 3: Click **Cancel** to return to the previous screen.

<img title="Cancel Add Infrastructure Providers" src="../images/cfme-nav-add-infra-providers-cancel.png" width="1000"/><br/>
*Cancel Add Infrastructure Providers*

## Section 4: Explore the Virtual Thumbnail for Infrastructure Providers

The web interface uses virtual thumbnails to represent providers. Each thumbnail contains four quadrants by default, which displays basic information about each provider.

<img title="Example Virtual Thumbnail" src="../images/cfme-virt-thumbnail.png" /><br/>
*Example Virtual Thumbnail*

1.  Number of hosts
2.  Management system software
3.  Currently unused
4.  Authentication status

In the Virtual Thumbnail below, note the <i class="fa fa-exclamation-circle fa-lg" aria-hidden="true"></i>. This demo is disconnected from the providers, so if you ever encounter the exclamation point, it indicates the status as not connected.

<img title="Disconnected Virtual Thumbnail" src="../images/cfme-virt-thumbnail-disconnected.png" /><br/>
*Disconnected Virtual Thumbnail*

When connected to providers, such as in a actual deployment, the <i class="fa fa-exclamation-circle fa-lg" aria-hidden="true"></i> is replaced with a <i class="fa fa-check-circle-o fa-lg" aria-hidden="true"></i>.

A <i class="fa fa-shield fa-lg" aria-hidden="true"></i> (**Policy**) in the center of the virtual thumbnail indicates that this provider has one or more policies applied. There are no policies configured in this exercise, so the shield does not appear.

### Step 1: Toggle views
> In the top right corner of the window, click <i class="fa fa-th" aria-hidden="true"></i> <i class="fa fa-th-large" aria-hidden="true"></i> <i class="fa fa-list" aria-hidden="true"></i> to toggle between **Grid**, **Tile**, and **List** views.

<img title="Top Window Navigation Infrastructure Providers" src="../images/cfme-nav-grid-title-list-infra-providers.png" width="1000"/><br/>
*Top Window Navigation Infrastructure Providers*

### Step 2: Access provider lists
> Click <i class="fa fa-download fa-lg" aria-hidden="true"></i> (**Download**) for a list of providers in TXT, CSV, or PDF formats.

<img title="Download Infrastructure Providers" src="../images/cfme-nav-download-infra-providers.png" width="1000"/><br/>
*Download Infrastructure Providers*

### Step 3: View provider details
> Click any infrastructure provider and observe the following details on the resulting screen:

<img title="Infrastructure Providers Dashboard" src="../images/cfme-dashboard-infra-providers.png" width="1000"/><br/>
*Infrastructure Providers Dashboard*

1.  The **Properties** section lists the aggregate host resources for the provider.
2.  CloudForms can communicate with the provider in the **Authentication Status** section.
3.  The **Relationships** section lists related clusters, hosts, datastores, VMs, and templates for this provider.
  * Click these relationships to see the type of information CloudForms gathers from a provider.
4.  The **Smart Management** section shows if this provider has any smart tags applied. You learn more about smart tagging later in the lab.
