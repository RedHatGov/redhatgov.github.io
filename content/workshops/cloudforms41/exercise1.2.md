---
title: Exercise 1.2 - Discovering Virtualization Host Systems
workshops: cloudforms41
workshop_weight: 120
layout: lab
---
#  Exercise 1.2 - Discovering Virtualization Host Systems

## Exercise Description
In this exercise, you will learn how to view, search and manage host systems.

In Red Hat CloudForms, hosts are hypervisors running on physical hardware providing virtual machines and infrastructure.

The CloudForms Management Engine automatically adds hosts from discovered providers. However, you can also discover hosts directly if not using a provider. Discovering hosts is only supported for standalone VMware vSphere servers.


## Section 1:  Explore Infrastructure Hosts

### Step 1: Select **Compute** → **Infrastructure** → **Hosts**.

<img title="List Infrastructure Hosts" src="../images/cfme-nav-compute-infra-hosts.png"  width="1000"/><br/>
*List Infrastructure Hosts*

### Step 2: View the list of your private datacenter infrastructure hosts, such as VMware vSphere and Red Hat Enterprise Virtualization managed hosts (Red Hat Enterprise Linux or Red Hat Enterprise Virtualization Hypervisor).

<p>{{% alert info %}} You can discover hosts independently, from an infrastructure provider, but this is not recommended because you do not see the relationship between hosts and providers. {{% /alert %}}</p>


## Section 2: Discover Infrastructure Hosts

In very large environments, you can discover new hosts directly.

### Step 1: Click <i class="fa fa-cog" aria-hidden="true"></i> (**Configuration**), then click <i class="fa fa-search" aria-hidden="true"></i> (**Discover items**).

<img title="Discover Infrastructure Hosts" src="../images/cfme-nav-discover-infra-hosts.png" width="1000"/><br/>
*Discover Infrastructure Hosts*

### Step 2: Review the data entry screen, but do not enter any information.

### Step 3: Click **Cancel** to return to the previous screen.

<img title="Cancel Infrastructure Host Discovery" src="../images/cfme-nav-discover-infra-hosts-cancel.png" width="1000"/><br/>
*Cancel Infrastructure Host Discovery*


## Section 3: Add Infrastructure Hosts

You can also manually add infrastructure hosts, if they are known.

### Step 1: Click <i class="fa fa-cog" aria-hidden="true"></i> (**Configuration**), then click <i class="fa fa-plus-circle fa-lg" aria-hidden="true"></i> (**Add**).

<img title="Add Infrastructure Hosts" src="../images/cfme-nav-add-infra-hosts.png" width="1000"/><br/>
*Add Infrastructure Hosts*

### Step 2: Review the data entry screen, but do not enter any information.

### Step 3: Click **Cancel** to return to the previous screen.

<img title="Cancel Add Infrastructure Hosts" src="../images/cfme-nav-add-infra-hosts-cancel.png" width="1000"/><br/>
*Cancel Add Infrastructure Hosts*


## Section 4: Explore the Virtual Thumbnail for Infrastructure Hosts

The web interface uses virtual thumbnails to represent providers. Each thumbnail contains four quadrants by default, which display basic information about each provider.

<img title="CloudForms Example Virtual Thumbnail" src="../images/cfme-virt-thumbnail-hosts.png"/><br/>
*Example Virtual Thumbnail*

*   The top left quadrant shows the number of VMs running on the host.
*   The top right quadrant shows the power state of the host.
*   The image in the bottom left quadrant represents the type of host, such as VMware vSphere and Red Hat Enterprise Virtualization.
*   The bottom right quadrant shows the status of the host.
*   A <i class="fa fa-shield fa-lg" aria-hidden="true"></i> (**Policy**) in the center indicates that this host has one or more policies applied.

### Step 1: To download the list of hosts, click <i class="fa fa-download fa-lg" aria-hidden="true"></i> (**Download**) next to <i class="fa fa-power-off" aria-hidden="true"></i> (**Power**).

<img title="CloudForms Download Host Providers" src="../images/cfme-nav-download-infra-hosts.png" width="1000"/><br/>
*Download Host Providers*

### Step 2: In the top right corner of the window, click <i class="fa fa-th fa-lg" aria-hidden="true"></i> <i class="fa fa-th-large fa-lg" aria-hidden="true"></i> <i class="fa fa-list fa-lg" aria-hidden="true"></i> to toggle between **Grid**, **Tile**, and **List** views.

<img title="Top Window Host Providers Navigation" src="../images/cfme-nav-grid-title-list-infra-hosts.png" width=1000/><br/>
*Top Window Host Providers Navigation*

### Step 3: Select the infrastructure host named **esxi3** with VMware and 20 VMs, and observe the following details on the resulting screen:

<img title="vSphere Hosts Dashboard" src="../images/cfme-dashboard-infra-hosts.png" width="1000"/><br/>
*vSphere Hosts Dashboard*

1.  The **Properties** section displays detailed information about the host.
  *  Observe these parts of the **Properties** details to see how this host relates to its resources in the provider.
2.  The **Compliance** section shows whether the host is compliant with its applied policies.
3.  The **Smart Management** section shows that this provider is tagged as existing at a specific location, as well as its provisioning scope.
4.  The **Authentication** status section shows whether or not CloudForms can log in to the host.
5.  The **Security** section lists users, groups, patches, firewall rules, and other operating system security-related information.
6.  The **Configuration** section lists packages, services, and other operating system configuration-related information.


## Section 5: Explore Host Drift History

### Step 1: In the Relationships section, click Drift History.

<img title="vSphere Host Drift Tab Dashboard" src="../images/cfme-nav-infra-hosts-drift-1.png" width="1000"/><br/>
*vSphere Host Drift Tab Dashboard*

<p>{{% alert info %}} The **Relationships** section is an accordion tab nested within the host named **esxi3**. {{% /alert %}}</p>

### Step 2: On the resulting screen, check at least two of the available dates.

### Step 3:  Click <img title="CloudForms Drift Icon" src="../images/cfme-nav-drift-icon.png"/> (**Drift**) above the list of timestamps.

<img title="vSphere Host Drift Dashboard Detail" src="../images/cfme-nav-infra-hosts-drift-2.png" width="1000"/><br/>
*vSphere Host Drift Dashboard Detail*

### Step 4: On the next screen, do not uncheck Properties, but check Security and Configuration.

### Step 5: Click Apply.

<img title="vSphere Host Drift Dashboard Section Detail" src="../images/cfme-nav-infra-hosts-drift-3.png" width="1000"/><br/>
*vSphere Host Drift Dashboard Section Detail*

If the host changes between the various points in time, it appears here. Can you see what’s changed over time?

### Step 6: Try using the <img title="CloudForms Drift Icon" src="../images/cfme-nav-drift-filter-icon.png"/> (**Filters Buttons**) to see which changes have occurred.

<img title="vSphere Host Drift Dashboard Filter Detail" src="../images/cfme-nav-infra-hosts-drift-4.png" width="1000"/><br/>
*vSphere Host Drift Dashboard Filter Detail*

<p>{{% alert info %}} You will likely need to click the little <i class="fa fa-angle-right fa-lg" aria-hidden="true"></i> mark next to the `Host Properties` section to expand and see the details of what’s changed. {{% /alert %}}</p>


## Section 6: Explore Infrastructure Host Utilization

### Step 1: Click **esxi3 (Summary)** to select the host named **esxi3** from the **Drift Analysis** page.

<img title="CloudForms vSphere Dashboard" src="../images/cfme-nav-esxi3-from-drift.png" width="1000"/><br/>
*CloudForms vSphere Dashboard*

### Step 2: Click <img title="CloudForms Monitor Icon" src="../images/cfme-nav-monitor-icon.png"/> (**Monitoring**) and then select <img title="CloudForms Utilization Icon" src="../images/cfme-nav-utilization-icon.png"/> (**Utilization**).

<img title="Hosts Monitor Utilization" src="../images/cfme-nav-monitor-infra-hosts.png" width="1000"/><br/>
*Hosts Monitor Utilization*

### Step 3: Try changing the **Interval** to **Hourly**.

<img title="CloudForms Dashboard Monitor Utilization Interval" src="../images/cfme-nav-infra-hosts-util-interval.png" width="1000"/><br/>
*Hosts Monitor Utilization Interval*

### Step 4: Examine the screen that appears, showing a detailed report of CPU, memory, disk I/O, network, and running VMs.

*   To see a specific data point, hover over any chart.
*   To zoom in on a chart, click <i class="fa fa-search-plus fa-lg" aria-hidden="true"></i> (Zoom In).
*   To modify the timeframe displayed in the report, select the date range at the top of the screen.

<p>{{% alert warning %}} The data in this demo is static, please do not go beyond August 7, 2013. {{% /alert %}}</p>


## Section 7: Explore Infrastructure Host Power State Control

### Step 1: Return to the list of Compute Hosts (eg, click the **Hosts** link in the navigation breadcrumbs at the top of the page).

<img title="Infrastructure Hosts Breadcrumb" src="../images/cfme-nav-compute-infra-hosts-breadcrumb.png" width="1000"/><br/>
*Infrastructure Hosts Breadcrumb*

### Step 2: Check the box next to any host, but do not select the host.

Note that the <img title="CloudForms Power Icon" src="../images/cfme-nav-power-icon.png"/> (**Power**), located above the list of hosts, is now active due to host  selection.

Also, observe the available power states that you can set for this host.

<img title="Infrastructure Hosts Power States" src="../images/cfme-nav-compute-infra-hosts-power-states.png" width="1000"/><br/>
*Infrastructure Hosts Power States*

<p>{{% alert warning %}} This demo environment is not connected to any real hosts, so changing the power state here does not affect any hosts. {{% /alert %}}</p>
