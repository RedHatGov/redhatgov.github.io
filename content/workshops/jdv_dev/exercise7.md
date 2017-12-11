---
title: Exercise 7 - Import Excel data
workshops: jdv_dev
workshop_weight: 1.7
layout: lab
toc: true
---

# Verify Settings

* You need to first verify that the Excel extensions were imported correctly into the designer

* window <i class="fa fa-arrow-right"></i> show view <i class="fa fa-arrow-right"></i> other <i class="fa fa-arrow-right"></i>

* Teiid Designer <i class="fa fa-arrow-right"></i> Model Extension Registry

<img src="../images/7-show-view.png">

* In the **Model Extension Registry** tab at the bottom, verify in the **Namespace Prefix** you see the value **excel** and a checkbox in the **imported** column.  If not, close the designer, re-open, click the start button to mark the server as started, and check again.

<img src="../images/7-model-extension.png">

# Import the Excel file

* file <i class="fa fa-arrow-right"></i> import <i class="fa fa-arrow-right"></i> Teiid Connection >> Source Model

<img src="../images/7-import.png">

* Click **New...**

* Name **java:/ExcelDS**

* Choose the **file** driver

* Set the **Parent Directory** to `jdv-demo/assets/excel`, click **apply**, then **ok**

<img src="../images/7-ds.png">

* Click **Next**

* Set Translator to **excel**

* Data Row number **2**

* Excel File **excel-data.xlsx**

* Header Row Number **1**, click **Next**

<img src="../images/7-file.png">

* Set Location to **demo-jdv/sources**

* Name **ExcelDS**, click **Next**, click **Next** again, then **Finish**

# Fix import default values

* On the Sheet1 table, right-click on **id** then **modeling <i class="fa fa-arrow-right"></i> set DataType** and change double to **int** 

* On the Sheet1 table, right-click on each of **region, visibility** then **modeling <i class="fa fa-arrow-right"></i> set DataType** and select **string** and set length to **255**

* Save **ExcelDS**.  There should be no red x next to the model.

* On the **Model Editor** tab, highlight **Sheet1** then click the **preview data** button.  You should see the Excel data in the **SQL Results** tab


# Create View Model

* Lets now create a REST view on top of this base layer, the same was as the Postgres source.

* file <i class="fa fa-arrow-right"></i> new Teiid Metadata Model

* Location **demo-jdv/views**

* Name **ExcelView**

* Model Type **View Model**

* **Transform from an existing model**, click **next**

* In the next window select the existing model as **ExcelDS**, click **Finish** and save the view model

{{% alert %}}
If you receive an alert about properties, click ok.
{{% /alert %}}


# Deploy View Model

* Open the vdb **demo-jdv.vdb** and click the **Add Model** button in the lower left.  Select **ExcelView** and save the vdb. Click the **Deploy** button

# Test with Postman

* In postman, run the **PostgresView** test.  Verify that the **Test Results** tab returns **PASS**
