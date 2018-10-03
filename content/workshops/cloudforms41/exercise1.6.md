---
title: Exercise 1.6 - Explore Cloud Providers
workshops: cloudforms41
workshop_weight: 160
layout: lab
---

# Exercise 1.6 - Explore Cloud Providers

## Exercise Description
This exercise will explain how to view cloud providers and related details.

In Red Hat CloudForms, a cloud provider is a computing platform that manages instances and enables the creation of multi-tenant infrastructure services, independently from underlying hypervisors.


## Section 1: Explore Cloud Providers

### Step 1: Select **Compute** → **Clouds** → **Providers**.

<img title="CloudForms Infrastructure VMs" src="../images/cfme-nav-compute-cloud-providers.png" width="1000"/><br/>
*Cloud Providers*

A list of your private and public cloud providers, such as OpenStack and Amazon EC2, displays.

### Step 2: To add Amazon EC2 or Microsoft Azure as a provider, use either <i class="fa fa-cog fa-lg" aria-hidden="true"></i> (**Configuration**) and <i class="fa fa-search fa-lg" aria-hidden="true"></i>
 (**Discover**) or <i class="fa fa-cog fa-lg" aria-hidden="true"></i> (**Configuration**) and <i class="fa fa-plus-circle fa-lg" aria-hidden="true"></i> (Add).

Step 3: To add OpenStack or Google Compute Engine as a provider, you must use (Configuration) and (Add).


## Section 2: Explore the Virtual Thumbnail for Cloud Providers

The web interface uses virtual thumbnails to represent providers. Each thumbnail contains four quadrants by default, which display basic information about each provider.

<img title="CloudForms Example Virtual Thumbnail" src="../images/cfme-virt-thumbnail-cloud.png" /><br/>
*Example Virtual Thumbnail*

### Step 1: View the following:

*   The top left quadrant shows the number of instances defined in the provider.
*   The top right quadrant shows the number of images available in the provider.
*   The image in the bottom left quadrant represents the type of provider (only Amazon EC2 or OpenStack are shown).
*   The bottom right quadrant shows the status of the provider.
*   A <i class="fa fa-shield fa-lg" aria-hidden="true"></i> (**Policy**) in the center indicates that this host has one or more policies applied.

### Step 2: In the top right corner of the window, click <i class="fa fa-th fa-lg" aria-hidden="true"></i> <i class="fa fa-th-large fa-lg" aria-hidden="true"></i> <i class="fa fa-list fa-lg" aria-hidden="true"></i> to toggle between **Grid**, **Tile**, and **List** views.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-grid-title-list-infra-cloud.png" width="1000"/><br/>
*Top Window Navigation*

### Step 3: Click <i class="fa fa-download fa-lg" aria-hidden="true"></i> (**Download**) to download a list of cloud providers.

<img title="CloudForms Download VM Providers" src="../images/cfme-nav-download-infra-cloud.png" width="1000"/><br/>
*Download Cloud*

### Step 4: Select the **Amazon (US West 2)** Amazon EC2 cloud provider.

<img title="CloudForms Dashboard CF41_OpenStack1 VM" src="../images/cfme-dashboard-infra-cloud.png" width="1000"/><br/>
*Cloud Dashboard*

### Step 5: Click the **Relationships** tab and review the kind of information CloudForms gathers from a provider.

<img title="CloudForms Dashboard CF41_OpenStack1 VM" src="../images/cfme-dashboard-infra-cloud-relation.png" width="1000"/><br/>
*Cloud Relationships*

<p>{{% alert info %}} The screen shows this provider’s relationships with its components, such as availability zones, flavors, security groups, instances, and images. {{% /alert %}}</p>

### Step 6: Return to the list of **Cloud Providers…**
### Step 7: Select the **OpenStack** cloud provider and click the relationships to review the gathered information.
