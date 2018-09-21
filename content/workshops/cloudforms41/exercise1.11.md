---
title: Exercise 1.11 - Explore Chargeback
workshops: cloudforms41
workshop_weight: 210
layout: lab
---

# Exercise 1.11 - Explore Chargeback

## Exercise Description

In Red Hat CloudForms, the chargeback feature of CloudForms Management Engine (CFME) enables you to calculate monetary virtual machine charges, based on owner or company tag. In this exercise you will learn how to review chargebacks, and  explore related reports, rates and assignments.


## Section 1: Explore Chargebacks

CloudForms Management Engine provides a default set of rates for calculating chargeback costs, but you can create your own set of computing and storage costs, as well.

Select **Cloud Intel** → **Chargeback**.

<img title="CloudForms Chargeback" src="../images/cfme-nav-chargeback.png" width="1000"/><br/>
*Chargeback*


## Section 2: Explore Reports

### Step 1. Select the **Reports** accordion.

<img title="CloudForms Chargeback Reports" src="../images/cfme-nav-chargeback-reports.png" /><br/>
*Chargeback Reports*

### Step 2. Select **Saved Chargeback Reports** → **Chargeback (Admin)**

<img title="CloudForms Chargeback Reports Admin" src="../images/cfme-nav-chargeback-reports-admin.png" width="1000"/><br/>
*Chargeback (Admin)*

### Step 3. Select any of the reports displayed and note how each instance is charged by resources consumed.


## Section 3: Explore Rates

### Step 1. Select the **Rates** accordion.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-chargeback-rates.png" /><br/>
*Chargeback Rates*

### Step 2. Select **Rates** → **Compute** → **Default**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-chargeback-rates-compute-default.png" width="1000"/><br/>
*Chargeback Compute Default*

### Step 3. Observe how rates are assigned to each resource.

### Step 4. Click <i class="fa fa-cog fa-lg" aria-hidden="true"></i> (**Configuration**) and select <i class="fa fa-files-o" aria-hidden="true"></i> (**Copy this Chargeback Rate**).

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-chargeback-rates-compute-default-copy.png" width="1000"/><br/>
*Chargeback Compute Copy*

### Step 5. Edit this chargeback rate, note the possible settings, and then click **Cancel** to discard your changes.

### Step 6. Repeat steps for **Rates** → **Storage** → **Default**.


## Section 4: Explore Assignments

### Step 1. Select the **Assignments** accordion.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-chargeback-assignments.png" /><br/>
*Chargeback Assignments*

### Step 2. Select **Assignments** → **Compute**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-chargeback-assignments-compute.png" width="1000"/><br/>
*Chargeback Assignments Compute*

### Step 3. Observe that the computed rate assignments are configured for the entire enterprise using the default rates from the previous accordion.

### Step 4. Select **Assignments** → **Storage**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-nav-chargeback-assignments-storage.png" width="1000"/><br/>
*Chargeback Assignments Storage*

### Step 5. Observe that the computed rate assignments are configured for the entire enterprise, using the default rates from the previous accordion.
