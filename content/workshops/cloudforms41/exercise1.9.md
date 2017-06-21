---
title: Exercise 1.9 - Introduction to Catalogs
workshops: cloudforms41
workshop_weight: 190
layout: lab
---

<p>{{% alert warning %}} The following is run as a customer (not admin) account initially. {{% /alert %}}</p>


# Explore Catalog Configuration

> Select **Services** → **Catalogs**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-services-catalog.png" width="1000"/><br/>
*Services Catalog*

> On the right, select the catalog item called **Deploy Ticket Monster on VMware**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-ticket-monster.png" width="1000"/><br/>
*Ticket Monster*

> Click **Order** to order the service.

Enter values for **DBName** and **App Server Name** and click **Submit**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-ticket-monster-submit.png" width="1000"/><br/>
*Ticket Monster Submit*

<p>{{% alert info %}} The request is submitted in a similar way to provisioning as admin, but with fewer choices. {{% /alert %}}</p>


# Verify Catalog Configuration

Log out of the **consumer** account and log in to the **admin** account.

> Select **Services** → **Requests**.

<img title="CloudForms Top Window Navigation VM Providers" src="../images/cfme-services-request-test.png" width="1000"/><br/>
*Ticket Monster Verify*

Click the request you just made.

<p>{{% alert info %}} On the request screen, review the request that was just generated.  In this demo environment, the system does not actually build, so continue to the next section. {{% /alert %}}</p>
