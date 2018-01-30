---
title: Exercise 1.14 - Examine Policies
workshops: cloudforms41
workshop_weight: 240
layout: lab
---

# What Are Policies?

In Red Hat CloudForms, Policy profiles are groupings of policies that you can apply to entities within CloudForms.  Compliance policies check for a certain state in a host or VM. Control policies control a host or VM depending on certain criteria.


# Examine Policies

> Select **Control** → **Explorer**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-control-explorer.png" width="1000"/><br/>
*Control Explorer*

> Select the **Policy Profiles** accordion.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-policy-profile-accordion.png" /><br/>
*Policy Profile Accordion*

> Select **All Policy Profiles** → **Linux Compliance Check** → **VM and Instance Compliance: Shell-Shock Vulnerability** → **Vulnerable bash Package (ShellShock)**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-shell-shock.png" width="1000"/><br/>
*Shell-Shock Vulnerability*

On the right, observe the Expression used for this policy.


# Explore Events

> Select the **Events** accordion.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-events-accordion.png" /><br/>
*Events Accordion*

> Select **All Events** → **Container Image Discovered**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-container-image-discovered.png" width="1000"/><br/>
*Container Image Discovered*

Observe that the imported policy shows up as assigned.


# Explore Conditions

> Select the **Conditions** accordion.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-conditions-accordion.png" /><br/>
*Conditions Accordion*

> Select **All Conditions** → **All VM and Instance Conditions** → **Vulnerable bash Package (ShellShock)**

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-conditions-shellshock.png" width="1000"/><br/>
*Conditions ShellShock*

Examine the **Expression**.


# Explore Actions

> Select the **Actions** accordion.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-actions-accordion.png" /><br/>
*Actions Accordion*

> Select **All Actions** → **Send Email to Security Team**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-actions-send-email.png" width="1000"/><br/>
*Send Email*

Observe what this action does and the policies to which it is assigned.

Examine other actions and results.


# Explore Alerts

> Select the **Alerts** accordion.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-alerts-accordion.png" /><br/>
*Alerts Accordion*

> Select **All Alerts** → **VM Memory was decreased**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-alerts-vm-decrease.png" width="1000"/><br/>
*VM Memory Alerts*

Review the **Hardware Reconfigured Parameters** section to see what this alert monitors.


# Explore Alert Profiles

> Select the **Alert Profiles** accordion.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-alert-profile.png" /><br/>
*Alerts Profile Accordion*

> Select **All Alert Profiles** → **VM and Instance Alert Profiles**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-alert-profile-vm-instance.png" width="1000"/><br/>
*All VM and Instance Alert Profiles*

Add an alert profile:

1.  Click <i class="fa fa-cog fa-lg" aria-hidden="true"></i> (**Configuration**) → **Add a New VM and Instance Alert Profile**.
2.  Enter **VM Memory Decrease** for **Description**.
3.  In **Alert Selection**, select **VM Memory was decreased** and click <i class="fa fa-caret-right fa-lg" aria-hidden="true"></i>.
4.  Click **Add**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-alert-profile-add.png" width="1000"/><br/>
*Add Alert Profile*

<p>{{% alert warning %}} You cannot assign an alert directly to an entity; you must put alerts into an alert profile as you did here. {{% /alert %}}</p>

<p>{{% alert info %}} An alert profile can contain many alerts or just one. {{% /alert %}}</p>

Assign your alert profile:

1.  Select the new alert profile you just created.
2.  Click <i class="fa fa-cog fa-lg" aria-hidden="true"></i> (**Configuration**) → **Edit assignments for this Alert Profile**.
3.  Choose **Selected Cluster/Deployment Roles** for **Assign To**.
4.  Check the **Raleigh** box.
5.  Click **Save**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-alert-profile-assign.png" width="1000"/><br/>
*Assign Alert Profile*

You have now assigned this alert to any VM in the Raleigh cluster.
