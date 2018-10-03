---
title: Exercise 1.14 - Examine Policies
workshops: cloudforms41
workshop_weight: 240
layout: lab
---
# Exercise 1.14 - Examine Policies

## Exercise Description
Policy profiles are groups of policies that you can apply to entities within CloudForms.  Two common types of policies are Compliance policies, which check for a specific state in a host or VM, and Control policies, which control a host or VM, depending on certain criteria.

In this exercise, you will learn how to work with policies, events, conditions, actions, alerts, and profiles.

*  An **Event** is a trigger to check a condition.
*  A **Condition** is a test triggered by an event.
*  An **Action** is an execution that occurs if a condition is met.

## Section 1: Examine Policies

### Step 1. Select **Control** → **Explorer**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-control-explorer.png" width="1000"/><br/>
*Control Explorer*

### Step 2. Select the **Policy Profiles** accordion.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-policy-profile-accordion.png" /><br/>
*Policy Profile Accordion*

### Step 3. Select **All Policy Profiles** → **Linux Compliance Check** → **VM and Instance Compliance: Shell-Shock Vulnerability** → **Vulnerable bash Package (ShellShock)**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-shell-shock.png" width="1000"/><br/>
*Shell-Shock Vulnerability*

### Step 4. On the right, observe the Expression used for this policy.


## Section 2: Explore Events

### Step 1. Select the **Events** accordion.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-events-accordion.png" /><br/>
*Events Accordion*

### Step 2. Select **All Events** → **Container Image Discovered**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-container-image-discovered.png" width="1000"/><br/>
*Container Image Discovered*

### Step 3. Observe that the imported policy shows up as assigned.


## Section 3. Explore Conditions

### Step 1. Select the **Conditions** accordion.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-conditions-accordion.png" /><br/>
*Conditions Accordion*

### Step 2. Select **All Conditions** → **All VM and Instance Conditions** → **Vulnerable bash Package (ShellShock)**

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-conditions-shellshock.png" width="1000"/><br/>
*Conditions ShellShock*

### Step 3. Examine the **Expression**.


## Section 4: Explore Actions

### Step 1. Select the **Actions** accordion.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-actions-accordion.png" /><br/>
*Actions Accordion*

### Step 2. Select **All Actions** → **Send Email to Security Team**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-actions-send-email.png" width="1000"/><br/>
*Send Email*

### Step 3. Observe what this action does and the policies to which it is assigned.

### Step 4. Examine other actions and results.


## Section 5. Explore Alerts

### Step 1. Select the **Alerts** accordion.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-alerts-accordion.png" /><br/>
*Alerts Accordion*

### Step 2. Select **All Alerts** → **VM Memory was decreased**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-alerts-vm-decrease.png" width="1000"/><br/>
*VM Memory Alerts*

### Step 3. Review the **Hardware Reconfigured Parameters** section to see what this alert monitors.


## Section 6. Explore Alert Profiles

### Step 1. Select the **Alert Profiles** accordion.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-alert-profile.png" /><br/>
*Alerts Profile Accordion*

### Step 2. Select **All Alert Profiles** → **VM and Instance Alert Profiles**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-alert-profile-vm-instance.png" width="1000"/><br/>
*All VM and Instance Alert Profiles*

### Step 3. Add an alert profile:

1.  Click <i class="fa fa-cog fa-lg" aria-hidden="true"></i> (**Configuration**) → **Add a New VM and Instance Alert Profile**.
2.  Enter **VM Memory Decrease** for **Description**.
3.  In **Alert Selection**, select **VM Memory was decreased** and click <i class="fa fa-caret-right fa-lg" aria-hidden="true"></i>.
4.  Click **Add**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-alert-profile-add.png" width="1000"/><br/>
*Add Alert Profile*

<p>{{% alert warning %}} You cannot assign an alert directly to an entity; you must put alerts into an alert profile as you did here. {{% /alert %}}</p>

<p>{{% alert info %}} An alert profile can contain many alerts or just one. {{% /alert %}}</p>

### Step 4. Assign your alert profile:

1.  Select the new alert profile you just created.
2.  Click <i class="fa fa-cog fa-lg" aria-hidden="true"></i> (**Configuration**) → **Edit assignments for this Alert Profile**.
3.  Choose **Selected Cluster/Deployment Roles** for **Assign To**.
4.  Check the **Raleigh** box.
5.  Click **Save**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-alert-profile-assign.png" width="1000"/><br/>
*Assign Alert Profile*

You have now assigned this alert to any VM in the Raleigh cluster.
