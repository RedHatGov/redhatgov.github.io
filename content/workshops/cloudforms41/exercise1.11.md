---
title: Exercise 1.11 - Explore Chargeback
workshops: cloudforms41
workshop_weight: 210
layout: lab
---

# What Is Chargeback?

In Red Hat CloudForms, the chargeback feature of CloudForms Management Engine (CFME) allows you to calculate monetary virtual machine charges based on owner or company tag.


# Explore Chargeback

> Select **Cloud Intel** → **Chargeback**.

<img title="CloudForms Chargeback" src="../images/cfme-nav-chargeback.png" width="1000"/><br/>
*Chargeback*


# Explore Reports

> Select the **Reports** accordion.

<img title="CloudForms Chargeback Reports" src="../images/cfme-nav-chargeback-reports.png" /><br/>
*Chargeback Reports*

> Select **Saved Chargeback Reports** → **Chargeback (Admin)**

<img title="CloudForms Chargeback Reports Admin" src="../images/cfme-nav-chargeback-reports-admin.png" width="1000"/><br/>
*Chargeback (Admin)*

Select any of the reports shown and note how each instance is charged by resources consumed.


# Explore Rates

> Select the **Rates** accordion.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-chargeback-rates.png" /><br/>
*Chargeback Rates*

> Select **Rates** → **Compute** → **Default**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-chargeback-rates-compute-default.png" width="1000"/><br/>
*Chargeback Compute Default*

Observe how rates are assigned to each resource.

> Click <i class="fa fa-cog fa-lg" aria-hidden="true"></i> (**Configuration**) and select <i class="fa fa-files-o" aria-hidden="true"></i> (**Copy this Chargeback Rate**).

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-chargeback-rates-compute-default-copy.png" width="1000"/><br/>
*Chargeback Compute Copy*

Edit this chargeback rate, note the possible settings, and then click **Cancel** to discard your changes.

Repeat steps for **Rates** → **Storage** → **Default**.


# Explore Assignments

> Select the **Assignments** accordion.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-chargeback-assignments.png" /><br/>
*Chargeback Assignments*

> Select **Assignments** → **Compute**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-chargeback-assignments-compute.png" width="1000"/><br/>
*Chargeback Assignments Compute*

Observe that the computed rate assignments are configured for the entire enterprise using the default rates from the previous accordion.

> Select **Assignments** → **Storage**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-chargeback-assignments-storage.png" width="1000"/><br/>
*Chargeback Assignments Storage*

Observe that the computed rate assignments are configured for the entire enterprise using the default rates from the previous accordion.
