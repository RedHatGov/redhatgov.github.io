---
title: Exercise 5 - Import PostgreSQL data
workshops: jdv_dev
workshop_weight: 1.5
layout: lab
toc: true
---

# Import JDBC datasource

* file <i class="fa fa-arrow-right"></i> import <i class="fa fa-arrow-right"></i> teiid designer <i class="fa fa-arrow-right"></i> JDBC Database >> source model

<img src="../images/5-import-jdbc-1.png">

* Under Connection Profile, select **new**

* Select **PostgreSQL** as the Connection Profile Type, **Next**

* In the next window, click the **New Driver Definition** icon

* Under the **Jar List** tab, select **Add JAR/Zip** and then select `jdv-demo/assets/postgres/postgresql-42.1.4.jar`, then **ok**

* In the **New JDBC Connection Profile** window make sure to use the IP address of your PostgreSQL instance and put the credentails for the **postgres** user and check **Save Password**.

* Click **Test Connection** and verify you get a **Ping Succeeded** response before selecting **Finish**

<img src="../images/5-jdbc-connection.png" width="1020px">

* Select **TABLE** to import

<img src="../images/5-import-jdbc-2.png">

* Then select the **order_details** table, then click **next**

<img src="../images/5-import-jdbc-3.png">

* Name your model **PostgresDS.xmi**

* In folder **demo-jdv/sources**

* JNDI Name **java:/PostgresDS**

* Click **Finish**

<img src="../images/5-import-jdbc-4.png">

# Fix import default values

* We have to fix the default values for two properties.

* Click on the **Package Diagram** tab and then click on **lastupdatedate** and then change the property **Default Value** in the lower left to **now()**

* Click on **status** and then change the property **Default Value** in the lower left to **'ACTIVE'** and then save the model

<img src="../images/5-default-value.png" width="1020px">

{{% alert %}}
This is a common issue when importing tables that have existing contraints.  The data preview would fail and you would need to check the server log for the error.
{{% /alert %}}

* On the **Model Editor** tab, highlight **order_details** then click the **preview data** button.  You should see the Postgres data in the **SQL Results** tab

<img src="../images/5-preview.png" width="1020px">

# Create View Model

* Lets now create a REST view on top of this base layer

* file <i class="fa fa-arrow-right"></i> new Teiid Metadata Model

* Location **demo-jdv/views**

* Name **PostgresView**

* Model Type **View Model**

* **Transform from an existing model**, click **next**

* In the next window select the existing model as **PostgresDS**, click **Finish** and save the view model

<img src="../images/5-view.png">

# Deploy View Model

* Open the vdb **demo-jdv.vdb** and click the **Add Model** button in the lower left.  Select **PostgresView** and save the vdb. Click the **Deploy** button

# Test with Postman

* In postman, run the **PostgresView** test.  Verify that the **Test Results** tab returns **PASS**
