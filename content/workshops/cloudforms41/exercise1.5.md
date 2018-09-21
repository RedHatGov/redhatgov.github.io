---
title: Exercise 1.5 - Examine Infrastructure Provisioning
workshops: cloudforms41
workshop_weight: 150
layout: lab
---

#  Exercise 1.5: Examine Infrastructure Provisioning

## Exercise Description
Learn to provision infrastructures, using Red Hat CloudForms. CloudForms enables provisioning and management across physical, virtual, and private cloud platforms.

### Red Hat CloudForms Infrastructure Provisioning process (Summary)

In Red Hat CloudForms, when a virtual machine or cloud instance is provisioned, it goes through multiple phases. First, the request must be made. The request includes ownership information, tags, virtual hardware requirements, the operating system, and any customization of the request. Second, the request must go through an approval phase, either automatic or manual. Finally, the request is executed.

Execution consists of pre-processing and post-processing. Pre-processing acquires IP addresses for the user, creates VMDB instances, and creates the virtual machine based on information in the request. Post-processing activates the VMDB instance.

<img title="CloudForms Discover Infrastructure Hosts" src="../images/cfme-provision-vm-workflow.png"/><br/>
*Provision VM Workflow*


## Infrastructure Provisioning

### Step 1: > Select **Compute** → **Infrastructure** → **Virtual Machines**.

<img title="CloudForms Infrastructure VMs" src="../images/cfme-nav-compute-infra-vms.png" width="1000"/><br/>
*Infrastructure VMs*

### Step 2: On the left, in the **VMs** accordion, select **All VMs & Templates**.

### Step 3: On the right, click <img title="CloudForms Infrastructure VMs" src="../images/cfme-lifecycle-icon.png" /> (**Lifecycle**).

### Step 4: Select <i class="fa fa-plus-circle fa-lg" aria-hidden="true"></i> (**Provision VMs**), and observe the following.

<img title="CloudForms Infrastructure VMs" src="../images/cfme-nav-compute-infra-vms-all-lifecycle.png" width="1000"/><br/>
*Provision VMs*

A list of templates displays.

<img title="CloudForms Infrastructure VMs" src="../images/cfme-provision-vm-1.png" width="1000"/><br/>
*Template List*

The **Provider** column shows some templates are from Red Hat Enterprise Virtualization Manager and others are from VMware.

### Step 5: Select any template and click **Continue**.

<img title="CloudForms Infrastructure VMs" src="../images/cfme-provision-vm-2.png" width="1000"/><br/>
*Template Continue*

### Step 6: On the resulting page, perform the steps indicated below for each tab and review the data requested.

<img title="CloudForms Infrastructure VMs" src="../images/cfme-provision-vm-3.png" width="1000"/><br/>
*Provision Virtual Machines*

*   In the **Request** tab, fill out all the fields.
*   In the **Catalog** tab, set the VM Name.
*   In the **Environment** tab, check **Choose Automatically**.
*   In the **Network** tab, choose a **vLan**.
*   Click **Submit**.

<p>{{% alert warning %}} Because you are working in a lab environment, nothing happens after these steps. {{% /alert %}}</p>

### Step 7: On the resulting screen, observe that your provision request appears in a list. If you are in an environment with real infrastructure, you can monitor this area for the status of the VM build.

<img title="CloudForms Infrastructure VMs" src="../images/cfme-provision-vm-4.png" width="1000"/><br/>
*Provision Request*

<p>{{% alert info %}} You can also arrive at this screen by clicking **Services** → **Requests**. {{% /alert %}}</p>
