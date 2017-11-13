---
title: Exercise 4 - Create new teiid project
workshops: jdv_dev
workshop_weight: 1.4
layout: lab
toc: true
---

# Create a new JDV project

* window <i class="fa fa-arrow-right"></I> perspective <i class="fa fa-arrow-right"></I> open perspective <i class="fa fa-arrow-right"></I> other <i class="fa fa-arrow-right"></I> teiid designer

* file <i class="fa fa-arrow-right"></I> new <i class="fa fa-arrow-right"></I> teiid model project

* Name the project **jdv-demo** and its ok to leave the default location.

* Do change the default folders to **sources, views and federated**

<img src="../images/4-folders.png">

{{% alert %}}
[teiid](http://teiid.jboss.org/) is the the upstream community project for JBoss Data Virtualization
{{% /alert %}}

# Create a VDB

* file <i class="fa fa-arrow-right"></I> New <i class="fa fa-arrow-right"></I> Teiid VDB

* name the vdb **demo-jdv**

# Deploy a VDB

* Double click the new vdb and then click the **Deploy**

* You will be prompted to create a datasource, click **ok**

<img src="../images/4-deploy-vdb.png">

# Test VDB

* Open Postman and run the test called **VDB Check**
{{% alert %}}
The **test** button in the VDB will initiate a JDBC connection and create a SQL query environment for the VDB.  We want to verify REST connectivity.
{{% /alert %}}

* Verify that you get an xml response like below

<img src="../images/4-postman.png">

