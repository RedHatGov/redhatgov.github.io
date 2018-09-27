---
title: Exercise 1.3 - Discovering VM Systems
workshops: cloudforms41
workshop_weight: 130
layout: lab
---
# Exercise 1.3 - Discovering VM Systems

## Exercise Description

In Red Hat CloudForms, infrastructure VMs are operating systems running under a hypervisor. This exercise will enable you to view and manage  infrastructure VMs.


## Section 1: Explore Infrastructure VMs

### Step 1: Select **Compute** → **Infrastructure** → **Virtual Machines**.

<img title="CloudForms Infrastructure VMs" src="../images/cfme-nav-compute-infra-vms.png" width="1000"/><br/>
*Infrastructure VMs*

### Step 2: View the list of your private datacenter’s infrastructure virtual machines.


## Section 2: Explore the Virtual Thumbnail for Infrastructure VMs

The web interface uses virtual thumbnails to represent providers. Each thumbnail contains four quadrants by default, which display basic information about each provider.

<img title="CloudForms Example Virtual Thumbnail" src="../images/cfme-virt-thumbnail-vms.png"/><br/>
*Example Virtual Thumbnail*

*   The top left quadrant shows the operating system running on the VM.
*   The top right quadrant shows the status of the VM.
*   The image in the bottom left quadrant represents the type of host the VM is running on, such as ESXi or Red Hat Enterprise Virtualization.
*   The bottom right quadrant shows the number of snapshots of this VM.
*   A <i class="fa fa-shield fa-lg" aria-hidden="true"></i> (**Policy**) in the center indicates that this host has one or more policies applied.

### Step 1: In the top right corner of the window, click <i class="fa fa-th fa-lg" aria-hidden="true"></i> <i class="fa fa-th-large fa-lg" aria-hidden="true"></i> <i class="fa fa-list fa-lg" aria-hidden="true"></i> to toggle between **Grid**, **Tile**, and **List** views.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-grid-title-list-infra-vms.png" width="1000"/><br/>
*Top Window Navigation VM Providers*

### Step 2: Click <i class="fa fa-download fa-lg" aria-hidden="true"></i> (**Download**) to download a list of VMs.

<img title="CloudForms Download VM Providers" src="../images/cfme-nav-download-infra-vm.png" width="1000"/><br/>
*Download VM Providers*

### Step 3: Select the VM named **CF41_OpenStack1**, and examine the following details:

<img title="CloudForms Dashboard CF41_OpenStack1 VM" src="../images/cfme-dashboard-infra-vms.png" width="1000"/><br/>
*CF41_OpenStack1 VM Dashboard*

1.  The **Properties** section shows detailed information about the VM.
2.  The **Lifecycle** section shows when this VM was discovered, when it was most recently analyzed, and when it is scheduled for retirement.
3.  The **Relationships** section shows the related infrastructure provider, cluster, host, datastore, resource pool, parent VM, and drift and analysis histories for this VM.
4.  The **Normal Operating Ranges** section shows the VM’s average CPU and memory utilization.
5.  The **Compliance** section shows whether the VM is compliant with its applied policies.
6.  The **Power Management** section shows the VM’s current power state, last boot time, and date of its most recent change in power state.
7.  The **Security** section lists users, groups, patches, firewall rules, and other operating system security-related information.
8.  The **Configuration** section lists applications/packages, services, and other operating system configuration information.
9.  The **Datastore Allocation** section shows the number of virtual disks in this VM—if the disks are aligned and if it is thin-provisioned—as well as the amount of space allocated.
10. The **Datastore Actual Usage Summary** section shows how much actual disk space the VM is using.
11. The **Diagnostics** section shows running processes and event logs for the VM.
12. The **Smart Management** section shows that this host is tagged as existing at a specific location, as well as other tags that you can use in policies and other functions within CloudForms.

### Step 4: Click **Users** (under the **Security** section) to see a detailed list of user information.

<img title="CloudForms Dashboard CF41_OpenStack1 VM" src="../images/cfme-dashboard-infra-vms-users.png" width="1000"/><br/>
*CF41_OpenStack1 VM Dashboard Users*

### Step 5: Click **Packages** (under the **Configuration** section) to view details of packages installed on this VM.

<img title="CloudForms Dashboard CF41_OpenStack1 VM" src="../images/cfme-dashboard-infra-vms-packages.png" width="1000"/><br/>
*CF41_OpenStack1 VM Dashboard Packages*


## Section 3: Explore Infrastructure VM Utilization

We will continue using the **CF41_OpenStack1** VM.  If needed, find it by returning to the list of all VMs  (eg, Compute → Infrastructure → Virtual Machines → VMs → All VMs & Templates).

### Step 1: Click <img title="CloudForms Monitor Icon" src="../images/cfme-nav-monitor-icon.png"/> (**Monitor**) and then select <img title="CloudForms Utilization Icon" src="../images/cfme-nav-utilization-icon.png"/> (**Utilization**).

<img title="CloudForms Dashboard VMs Monitor" src="../images/cfme-nav-monitor-infra-vms.png" width="1000"/><br/>
*Navigate VMs Monitor Utilization*

### Step 2: Try changing the **Interval** to **Daily**.

<img title="CloudForms Dashboard Monitor VM Utilization Interval" src="../images/cfme-nav-infra-vms-util-interval.png" width="1000"/><br/>
*Monitor VM Utilization Interval*

### Step 3: Examine the on-screen report detailing CPU, memory, disk I/O, and network.

*   To see a specific data point, hover over any chart.
*   To zoom in on a chart, click <i class="fa fa-search-plus fa-lg" aria-hidden="true"></i> (Zoom In) in the lower left corner of the chart.
*   To modify the timeframe displayed in the report, select the date range at the top of the screen.

<p>{{% alert warning %}} The data in this demo is static, please do not go beyond August 7, 2013. {{% /alert %}}</p>
