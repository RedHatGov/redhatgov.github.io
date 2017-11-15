---
title: Exercise 9 - Secure Data Services
workshops: jdv_dev
workshop_weight: 1.9
layout: lab
toc: true
---

# Overview

* To secure the services we created in our VDB, we need to create an additional user on the server.

# Create the additional user

* In `$JBOSS_HOME/bin` directory run the following script with the answers to the prompts below

```
./add-user.sh
```

{{% alert %}}
For windows users, the script will be **add-user.bat**
{{% /alert %}}

* Type: **b) Application User**
* Username: **maskUser**
* Password: **Password1!** (same as the one used during installation
* groups: **odata,mask**
* Remoting: **no**

* Back in **JBDS** open the **demo-jdv.vdb** and then to Data Roles tab.  In the lower left add a new role

* Name the role **User**.

* In the mapped enterprise role tab add a value of **user**.  Click **finish**

<img src="../images/9-role-mapping.png">

* Add another Data Role called **Masked**

* In the mapped enterprise role tab add a value of **mask**

* Uncheck all the tables **except** for FedView

<img src="../images/9-masked-view.png">

* In the **row filter tab**, click **add**.  Set target as **FedView.combined**

* In the **condition** field add **visibility = 'public'**

<img src="../images/9-row-filter.png">

* In the **column masking** tab, click add

* Target column is **FedView.combined.email**.  Column expression is **'anon@email.com'**.

<img src="../images/9-column-mask.png">

# Deploy the changes

* **Save** the changes to vdb then click the **deploy** button.

# Test with Postman

* In postman, run the **FedView masked** test.  Verify that the **Test Results** tab returns **PASS**



