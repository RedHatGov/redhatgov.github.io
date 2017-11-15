---
title: Exercise 8 - Federate Data
workshops: jdv_dev
workshop_weight: 1.8
layout: lab
toc: true
---

# Create the combined view

file -> new -> teiid metadata model

* Location **demo-jdv/federated**

* Model Name **FedView**

* Model Type **View Model**

* Do not select any options under model builder and click **Finish**

* Right-click on the FedView Package diagram and select new -> child -> table

* Select **Option 1: Build with new table wizard**

* Name **combined**

* * Under the **PK** tab, check the **include** box then put **id_pk** in the **name** field.  Click **ok**.  There will be model errors, this is ok

* Double-click the **combined** table to bring up the **Transformation Diagram**.

* Hold down **ctrl** and highlight all 3 **Sheet1, order_details and users** tables in the views.  Then drag them into the **Transformation Editor**

<img src="../images/8-drag.png" width="800px">

* In the **Transformation Editor**, copy the following where clause to the end of the transformation SQL to join the added tables on the 'id' field

```sql
	WHERE
		(ExcelView.Sheet1.id = PostgresView.order_details.id) AND (PostgresView.order_details.id = RestView.users.id)
```

* Now click the **Save and Validate** button to check our work

<img src="../images/8-validate.png" width="800px">

* Cleanup the unnecessary colums by right-clicking on the **id_1, id_2, ROW_ID** fields and delete each one

* Select **pk_id** and edit the **Columns** property.  From the **Choices** column, move over **id** to **feature**.  Click **ok**

* **Save** FedView

* Go to the **Model Editor** tab and click the **preview data** button.  10 Records should return in the **SQL Results**

<img src="../images/8-preview.png" width="800px">

# Deploy View Model

* Open the vdb **demo-jdv.vdb** and click the **Add Model** button in the lower left.  Select **FedView** and save the vdb. Click the **Deploy** button

# Test with Postman

* In postman, run the **FedView** test.  Verify that the **Test Results** tab returns **PASS**
