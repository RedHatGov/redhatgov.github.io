---
title: Lab 01 - API Design
workshops: agile_integrations_ci
workshop_weight: 21
layout: lab
---
## Lab 1

## API Design

### Create an OpenAPI Specification using Apicurio Studio

* Duration: 10 mins
* Audience: API Owner, Product Manager, Developers, Architects

<br><img src="../images/agenda-01.png "Login" width="900" /><br><br>

## Overview

As APIs become more widespread in the enterprise, consistent design and usage is critically important to improve reusability. The more reusable APIs are, the less friction there is for other internal or external teams to make progress. Having design standards and tools baked into the API development and maintenance process is a very powerful way to enable this consistency.

### Why Red Hat?

Red Hat is one of the founding members of the Linux Foundation OpenAPI Initiative (OAI) which produces the leading standard for REST API specifications. Red Hat consistently uses this standard throughout its tooling, starting with the Apicurio Studio API Designer editor.

## Lab Instructions

### Step 1: Creating APIs with Apicurio Studio

1. Open a browser window and navigate to Apicurio.  Please ask your Instructor if you do not have the link.

1. Log in using your designated user and password.

    <br><img src="../images/design-01.png "Login" width="900" /><br><br>

1. Click on **Create New API**.

    <br><img src="../images/design-03.png "Create New API" width="900" /><br><br>

1. Create a brand new API by completing the following information:

    * Type: **Open API 3.0.2**
    * Name: **Locations-UserX** (Replace *X* with your user number)
    * Description: **Locations API**

    <br><img src="../images/design-04.png "Create API" width="900" /><br><br>

1. Click on **Create API**.

1. Finally, click on **Edit API** to start editing your newly created API.

    <br><img src="../images/design-05.png "Edit API" width="900" /><br><br>

### Step 2: Editing APIs

You are now in the main screen to edit your APIs. Apicurio is a graphical, form-based API editor. With Apicurio you don't need master in and out all the details of the **OpenAPI Specification**. It allows you to design beautiful, functionals APIs with zero coding.

Let's start crafting your API.

1. Time to prepare our data definitions for the API. Click on the **Add a datatype** link under the *Data Types*.

    <br><img src="../images/design-15.png "Add Datatype" width="900" /><br><br>

1. Fill in the *Name* field with the value **location**. Expand the *Enter the JSON Example (optional)* to paste the following example, then click **Save**:

    * Name: **location**
    * JSON Example:

        ```bash
        {
            "id": 1,
            "name": "International Inc Corporate Office",
            "location": {
                "lat": 51.5013673,
                "lng": -0.1440787
            },
            "type": "headquarter",
            "status": "1"
        }
        ```
    * Choose to create a REST Resource with the Data Type: **No Resource**

    <br><img src="../images/design-16.png "JSON Example" width="900" /><br><br>

1. Apicurio automatically tries to detect the data types from the provided example.

    <br><img src="../images/design-17.png "Definition Data Types" width="900" /><br><br>

    *Time to start creating some paths*.

### Step 3: Adding Paths

#### 3a: Add `/locations` path with GET method

The `/locations` path with an HTTP GET method will return a complete set of all location records in the database.

1. Click on the **Add a path** link under the *Paths* section. APIs need at least one path.

    <br><img src="../images/design-06.png "Add Path" width="900" /><br><br>

1. Fill in the new resource path with the following information:

    * Path: **/locations**

    <br><img src="../images/design-07.png "Path" width="900" /><br><br>

1. Click **Add**.

    *By default, Apicurio suggest a series of available operations for your new path*.

1. Click **Create Operation** under the *GET* operation.

    <br><img src="../images/design-08.png "Create Operation" width="900" /><br><br>

1. Click on the green **GET** operation button to edit the operation information.

    <br><img src="../images/design-09.png "Get Operation" width="900" /><br><br>

    *As you can notice, Apicurio Editor guides you with warning for the elements missing in your design*.

1. Click on the **Add a response** link under *Responses* to edit the response for this operation.

    <br><img src="../images/design-58.png "Add Response" width="900" /><br><br>

1. Leave the **200** option selected in the  *Response Status Code* combo box and click on **Add**.

    <br><img src="../images/design-11.png "Add Response Code" width="900" /><br><br>

1. Scroll down to the bottom of the page. Move your mouse over the **200 OK** response to enable the options. Click the *No response media types defined* drop-down. Now click on the **Add Media Type** button.

    <br><img src="../images/design-59.png "Add Media Type" width="900" /><br><br>


1. Click on the *Add* button to accept **application/json** as the Media Type.

    <br><img src="../images/design-18.png "Location Type" width="900" /><br><br>

1. Click on the *Type* dropdown and select **Array** and **location**.

    <br><img src="../images/design-18a.png "Location Type" width="900" /><br><br>

1. Click the **Add an example** link to add a Response Example.

    *This will be useful to mock your API in the next lab*.

    <br><img src="../images/design-19.png "Add Example" width="900" /><br><br>

1. Fill in the information for your response example:

    * Name: **all**
    * Example:

        ```bash
        [
            {
                "id": 1,
                "name": "International Inc Corporate Office",
                "location": {
                    "lat": 51.5013673,
                    "lng": -0.1440787
                },
                "type": "headquarter",
                "status": "1"
            },
            {
                "id": 2,
                "name": "International Inc North America",
                "location": {
                    "lat": 40.6976701,
                    "lng": -74.259876
                },
                "type": "office",
                "status": "1"
            },
            {
                "id": 3,
                "name": "International Inc France",
                "location": {
                    "lat": 48.859,
                    "lng": 2.2069746
                },
                "type": "office",
                "status": "1"
            }
        ]
        ```

    <br><img src="../images/design-20.png "Response Example" width="900" /><br><br>

1. Click on the drop-down next to the `No description` message, and enter `Returns an array of location records` as the description.  Click the check-mark button to accept the description.

    <br><img src="../images/design-54.png "Enter description" width="900" /><br><br>

1. Click on the green **GET** operation button to highlight the list of operations.

    <br><img src="../images/design-31.png "Get Operation" width="900" /><br><br>

#### 3b: Update `/locations` path with POST method

The HTTP POST method will allow us to insert a new locations record into the database.

1. Click on the **Create Operation** link under *POST* to create a new POST operation.

    <br><img src="../images/design-32.png "Create POST operation" width="900" /><br><br>

1. Click the orange **POST** button to edit the operation.

    <br><img src="../images/design-33.png "Edit POST operation" width="900" /><br><br>

1. Click the **Add a response** link.

    <br><img src="../images/design-34.png "Edit POST operation" width="900" /><br><br>

1. Set the **Response Status Code** value to `201`.  Click Add.

    <br><img src="../images/design-35.png "Edit POST operation" width="900" /><br><br>

1. Click on the drop-down next to the `No description` message, and enter `Creates a new location record` as the description.  Click the check-mark button to accept the description.

    <br><img src="../images/design-55.png "Enter description" width="900" /><br><br>

1. Scroll down to the bottom of the page. Move your mouse over the **201 Created** response to enable the options. Click the *No response media types defined* drop-down. Now click on the **Add Media Type** button.

    <br><img src="../images/design-60.png "Add Media Type" width="900" /><br><br>


1. Click on the *Add* button to accept **application/json** as the Media Type.

    <br><img src="../images/design-18.png "Location Type" width="900" /><br><br>

1. Click on the *Type* dropdown and select **location**.

    <br><img src="../images/design-36.png "Location" width="900" /><br><br>

#### 3c: Add `/locations/{id}` path with GET method

The `/locations/{id}` path will return a single location record based on a single `id` parameter, passed via the URL.

1. Now we need to create another path.  Click on the `+` symbol to add a new path, then enter `/locations/{id}` for the **Path** property.  Click **Add**.

    <br><img src="../images/design-37.png "Location" width="900" /><br><br>

1. Scroll over the `id` *Path Parameter* value, then click the **Create** button.

    <br><img src="../images/design-37a.png "Location" width="900" /><br><br>

1. Click the drop-down arrow, then update the `id` Path Parameter by selecting `Integer` as the **Type** and `32-Bit Integer` as the sub-type.

    <br><img src="../images/design-38.png "Path Parameter" width="900" /><br><br>

1. Click on the `Create Operation` button underneath **GET**, then click the green **GET** button.

    <br><img src="../images/design-39.png "Path Parameter" width="900" /><br><br>

1. Click on the **Add a response** link under *Responses* to edit the response for this operation.

    <br><img src="../images/design-10.png "Add Response" width="900" /><br><br>

1. Leave the **200** option selected in the  *Response Status Code* combo box and click on **Add**.

    <br><img src="../images/design-11.png "Add Response Code" width="900" /><br><br>

1. Scroll down to the bottom of the page. Move your mouse over the **200 OK** response to enable the options. Click the *No response media types defined* drop-down. Now click on the **Add Media Type** button.

    <br><img src="../images/design-12.png "Add Media Type" width="900" /><br><br>


1. Click on the *Add* button to accept **application/json** as the Media Type.

    <br><img src="../images/design-18.png "Location Type" width="900" /><br><br>

1. Click on the *Type* dropdown and select **location**.

    <br><img src="../images/design-40.png "Location Type" width="900" /><br><br>

1. Click on the drop-down next to the `No description` message, and enter `Returns a single location record` as the description.  Click the check-mark button to accept the description.

    <br><img src="../images/design-56.png "Enter description" width="900" /><br><br>

#### 3d: Add `/locations/phone/{id}` path with GET method

The `/locations/phone/{id}` path will return a single location record based on a single phone number parameter, passed via the URL.

1. Now we need to create another path.  Click on the `+` symbol to add a new path, then enter `/locations/phone/{id}` for the **Path** property.  Click **Add**.

    <br><img src="../images/design-41.png "Location" width="900" /><br><br>

1. Click on the `Create Operation` button underneath **Get**, then click the green **Get** button.

    <br><img src="../images/design-42.png "Get operation" width="900" /><br><br>

1. Scroll down to the `id` path parameter to highlight the row, and click the `Create` button that appears.

    <br><img src="../images/design-53.png "Get operation" width="900" /><br><br>

1. Click the drop-down arrow next to `No Type`, then update the `id` Path Parameter by selecting `Integer` as the **Type** and `32-Bit Integer` as the sub-type.

    <br><img src="../images/design-64.png "Path Parameter" width="900" /><br><br>

1. Click on the **Add a response** link under *Responses* to edit the response for this operation.

    <br><img src="../images/design-61.png "Add Response" width="900" /><br><br>)

1. Leave the **200** option selected in the  *Response Status Code* combo box and click on **Add**.

    <br><img src="../images/design-11.png "Add Response Code" width="900" /><br><br>

1. Scroll down to the bottom of the page. Move your mouse over the **200 OK** response to enable the options. Click the *No response media types defined* drop-down. Now click on the **Add Media Type** button.

    <br><img src="../images/design-62.png "Add Media Type" width="900" /><br><br>


1. Click on the *Add* button to accept **application/json** as the Media Type.

    <br><img src="../images/design-18.png "Location Type" width="900" /><br><br>

1. Click on the *Type* dropdown and select **location**.

    <br><img src="../images/design-63.png "Location Type" width="900" /><br><br>

1. Click on the drop-down next to the `No description` message, and enter `Returns a location record` as the description.  Click the check-mark button to accept the description.

    <br><img src="../images/design-57.png "Enter description" width="900" /><br><br>

### Step 4: Download the API definition

1. Click the **Locations-UserX** link to return to the API admin page.

    <br><img src="../images/design-22.png "Locations API" width="900" /><br><br>

1. To start using your new API definition, display the API menu from the kebab link. Click the **Download (YAML)** option from the menu.

    <br><img src="../images/design-23.png "Download API" width="900" /><br><br>

1. This will start the download of your API definition file. It could take a few seconds to start the download. **Save** it to your local disk drive.

1. You can open the file with any text editor. Take a look at the source file. Everything is there.

    <br><img src="../images/design-24.png "API Definition Source" width="900" /><br><br>

*Congratulations!* You have created your first API definition based on the OpenAPI Specification  using Red Hat's Apicurio. Don't lose track of the file, you will use this definition for your next lab.

## Steps Beyond

So, you want more? Did you notice the link **source** when editing the *Paths* or the *Definitions*? Get back to the API editor and follow the link. What do you see? Apicurio lets you follow the form-based editor or go one step beyond and also lets you direct edit the source of your API definition.

## Summary

In this lab you used Apicurio Studio to create a simple API definition using the OpenAPI Specification. You learned how to author and download a standards compliant API Specification using Red Hat's APICurio.

## Notes and Further Reading

* Apicurio
  * [Webpage](https://www.apicur.io)
  * [Roadmap](https://www.apicur.io/roadmap/)
* OpenAPI
  * [OpenAPI Initiative](https://www.openapis.org/)
  * [OpenAPI Specification 3.0.2](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.2.md)
