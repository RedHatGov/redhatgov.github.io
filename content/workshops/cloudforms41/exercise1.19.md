---
title: Exercise 1.19 - Ansible Inside
workshops: cloudforms41
workshop_weight: 290
layout: lab
---

# Exercise 1.19 - Ansible Inside
## Exercise Description

Red Hat Ansible integration delivers out-of-the-box support for backing service, alert and policy actions using Ansible playbooks. Sync your existing playbook repositories with CloudForms, add credentials to access providers, and create service catalog items for actions ranging from creating and retiring VMs, updating security software, or adding additional disks when space runs low.

Ansible integrates with Red Hat CloudForms to provide automation solutions, using playbooks, for Service, Policy and Alert actions. Ansible playbooks consist of series of plays or tasks that define automation across a set of hosts, known as the inventory.

Ranging from simple to complex tasks, Ansible playbooks can support cloud management:

|   |   |
|---|---|
| Services        | Allow a playbook to back a CloudForms service catalog item. |
| Control Actions | CloudForms policies can execute playbooks as actions based on events from providers. |
| Control Alerts  | Set a playbook to launch prompted by a CloudForms alert. |



## Section 1: Enable Ansible Role

{{% alert success %}}

This should already be done for you.

{{% /alert %}}
In Red Hat CloudForms, the Ansible role is disabled by default. Navigate to the settings
menu, then Configuration → Settings and select the desired server under Zones. Set
the Server Role for Embedded Ansible to On to enable the role.

## Section 2: Configuration
### Step 1. Select Configuration
<img src="../images/configure.png" width="300" />

### Step 2. Click Embedded Ansible -> On

{{% alert success %}}

This should already be done for you.

{{% /alert %}}

<img src="../images/configure2.png" width="1000" />

<img src="../images/configure3.png" width="650" />


### Step 3. Click Automate -> Ansible

You will now see Ansible Playbooks.  These playbooks are samples from [GitHub](https://github.com/jeromemarc/workflow-demo)


<img src="../images/ansible-playbooks.png" width="1000" />



## Section 3: Playbook
### Step 1. Explore the first Playbook

```bash
ManageIQ/create_user.yml
```

From here we can see properties such as when it was uploaded and where the playbook came from.
<img src="../images/ansible-playbooks2.png" width="1000" />

If you click on "Repository" you can see even more detail about the Playbook.

<img src="../images/ansible-playbooks3.png" width="1000" />

Ansible is built into CloudForms so there is nothing to install.

| The basic workflow when using Ansible in Red Hat CloudForms is as follows:  |   |
|---|---|
| 1. Add a source control repository that contains your playbooks. | |
| 2. Establish credentials with your inventory. | |
| 3. Back your services, alerts and policies using available playbooks. | |

### Step 2. Add Credentials

Red Hat CloudForms can store credentials used by playbooks. Credentials saved in CloudForms are matched and executed with a playbook when run.

<img src="../images/ansible-creds.png" width="1000" />

```bash
Automate / Ansible / Credentials
```

### Step 3. Explore adding a new credential

From here you would add a credential adding the Name and Type and actual credential.

<img src="../images/ansible-creds2.png" width="650" />

### Step 4. Explore your new Ansible Service

```bash
Services / My Services / Create CloudForms User
```

<img src="../images/ansible-create.png" width="1000" />


<img src="../images/ansible-create2.png" width="1000" />


Now this Ansible Playbook can be offered up as a Service item with CloudForms controlling the access and lifecycle of the automation action.

# Summary

In this exercise we’ve seen how simple it is to add and use Ansible Playbooks. Ansible with it's 1300+ modules makes the sky the limit when it comes to automation actions you can perform or offer up as a service in CloudForms.
