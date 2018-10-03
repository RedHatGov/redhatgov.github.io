---
title: Exercise 1.9 - Introduction to Catalogs
workshops: cloudforms41
workshop_weight: 190
layout: lab
---

<p>{{% alert warning %}} The following steps are initially run as a non-admin customer account. {{% /alert %}}</p>

# Exercise 1.9 - Introduction to Catalogs
## Exercise Description
This exercise enables you to explore and verify the catalog configuration.

## Section 1: Explore Catalog Configuration

### Step 1. Select **Services** → **Catalogs**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-services-catalog.png" width="1000"/><br/>
*Services Catalog*

### Step 2. On the right, select the  **Deploy Ticket Monster on VMware** catalog item.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-ticket-monster.png" width="1000"/><br/>
*Ticket Monster*

### Step 3. Click **Order** to order the service.

### Step 4. Enter values for **DBName** and **App Server Name** and click **Submit**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-ticket-monster-submit.png" width="1000"/><br/>
*Ticket Monster Submit*

<p>{{% alert info %}} The request is submitted in a similar way to provisioning as admin, but with fewer choices. {{% /alert %}}</p>


## Section 2: Verify Catalog Configuration

### Step 1. Log out of the **consumer** account and log in to the **admin** account.

### Step 2. Select **Services** → **Requests**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-services-request-test.png" width="1000"/><br/>
*Ticket Monster Verify*

### Step 3. Click the request you just made.

<p>{{% alert info %}} On the request screen, review the request that was just generated.  In this demo environment, the system does not actually build, so continue to the next section. {{% /alert %}}</p>
