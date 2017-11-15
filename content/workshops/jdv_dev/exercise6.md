---
title: Exercise 6 - Import REST data
workshops: jdv_dev
workshop_weight: 1.6
layout: lab
toc: true
---

# Import REST source

* file <i class="fa fa-arrow-right"></i> import <i class="fa fa-arrow-right"></i> Web Service Source >> Source and View Model (REST)

* Click **New** Connection Profile, then **next**

* Connection URL **https://jsonplaceholder.typicode.com/users**

* Response type **JSON**

* Make sure **Test Connection** returns **Ping Succeeded!**, then **Finish**

<img src="../images/6-new-connect.png">

* Click **Next**

* Set the following values like the screenshot below

<img src="../images/6-import.png">

* **Next** and put JNDI as **java:/RestDS**, then **Next**

* In the Import from REST Web Service Source, expand the first response element then right click on the second **response** element and select **Set as Root path**

* Then select the **id** field and then **Add**.  Highlight the added **id** field and select **Edit...** and change the **Data Type** to **biginteger**

* Select the following fields to add **name, website, phone, email, username**

* Expand the address element and add **zipcode, city, street**, click **Finish** and **save** RestDS and RestView

<img src="../images/6-rest-elements.png" width="800px">

* In the RestView model click the **new Virtual Table** button

<img src="../images/6-new-table.png">

* Select **Option 1: Build with new table wizard**

* Name **users**

* Under the **PK** tab, check the **include** box then put **id_pk** in the **name** field.  Click **ok**.  There will be model errors, this is ok

* Double-click the new **users** table to get to the Transformation diagram.  Now click and drag the **getUsers** procedure from the left pane into the **select** text box.  The columns should be copied over.

<img src="../images/6-drag.png" width="800px">

* Now select **id_pk** and edit the **Columns** property.  From the **Choices** column, move over **id** to **feature**.  Click **ok**

* You must now right-click on each of **name,website,phone,email,username,zipcode,city and street** then **modeling <i class="fa fa-arrow-right"></i> set DataType** and select **string** and set length to **255**

* Now save the **users** table.  There should no longer be any **red x** next to the model

# Preview the REST data

{{% alert %}}
At the bottom of the designer select the **Teiid Execution Plan** tab.  Make sure the **Generate Plans Preference** is set to **DISABLED**.  Leaving this on will result in previews for non-relational sources to take a very long time as the execution plan is calculated
{{% /alert %}}

* Select the **Model Editor** in the RestView model.

* Select the **users** table then click the **Preview data** button

* You will see data now in the **SQL Results** tab at the bottom.

# Deploy View Model

* Open the vdb **demo-jdv.vdb** and click the **Add Model** button in the lower left.  Select **RestVew** and save the vdb. Click the **Deploy** button

# Test with Postman

* In postman, run the **RestView** test.  Verify that the **Test Results** tab returns **PASS**
