---
title: Lab 05 - Fuse Online
workshops: agile_integrations_dev
workshop_weight: 25
layout: lab
---

# Lab 5

## Fuse Online

* Duration: 20 mins
* Audience: Developers and Architects

<br><img src="../images/agenda-03.png "Login" width="900" /><br><br>

## Overview

When it comes to quick API development, you need both the integration experts as well as application developers to easily develop, deploy the APIs. Here is how to create a simple API with Fuse online.

### Why Red Hat?

Red Hat Fuse integration solution empowers integration experts, application developers, and business users to engage in enterprise-wide collaboration and high-productivity self-service.

##Lab Instructions

### Step 1: Create database connection

1. Navigate to OpenShift.

1. Click on your Tools Project.

1. Click on your Fuse Online Route and Log In.

1. The first time that you hit the Fuse Online URL, you will be presented with an *Authorize Access* page.  Click the **Allow selected permissions** button to accept the defaults.

    <br><img src="../images/design-54.png "Accept permissions" width="900" /><br><br>

1. Click on **Connections > Create Connection**

    <br><img src="../images/00-create-connection.png "Create Connection" width="900" /><br><br>

1. Select **Database**

    <br><img src="../images/01-select-database.png "Select Database" width="900" /><br><br>

1. Enter below values for Database Configuration

    ```
    Connection URL: jdbc:postgresql://postgresql.OCPPROJECT.svc:5432/sampledb
    Username      : dbuser
    Password      : password
    Schema        : <blank>
    ```
*Remember to replace the OCPPROJECT with the OpenShift project(NameSpace) you used in last lab.  It should be your username*

1. Click **Validate** and verify if the connection is successful. Click **Next** to proceed.

    <br><img src="../images/02-click-validate.png "Validate" width="900" /><br><br>

1. Add Connection details:
  - Connection Name: LocationDB
  - Description: Location Database
  - Click **Create**.

    <br><img src="../images/03-connection-details.png "Add Connection Details" width="900" /><br><br>

1. Verify that the Location Database is successfully created.

### Step 2: Create webhook integration

Description goes here

1. Click on **Integrations > Create Integration**

    <br><img src="../images/04-create-integration.png "Create Integration" width="900" /><br><br>

1. Choose **Webhook**

    <br><img src="../images/05-choose-weebhook.png "Choose webhook"Integration" width="900" /><br><br>

1. Click on Incoming webhook

    <br><img src="../images/06-incoming-webhook.png "Add incoming webhook" width="900" /><br><br>

1. It navigates to the Webhook Token screen. Click **Next**

    <br><img src="../images/07-webhook-configuration.png "Webhook Configuration" width="900" /><br><br>

1. Define the Output Data Type.
  - Select type from the dropdown as JSON instance.
  - Enter Data type Name: Custom
  - For Definition:, copy below JSON data.
  - Click Done

    ```
    {
      "id": 1,
      "name": "Kamarhati",
      "type": "Regional Branch",
      "status": "1",
      "location": {
        "lat": "-28.32555",
        "lng": "-5.91531"
      }
    }
    ```
      <br> <br> <img src="../images/08-data-type.png "Data Type" width="900" /><br><br>

1. Click on LocationDB from the catalog and then select Invoke SQL

    <br><img src="../images/09-invoke-sql.png "Invoke SQL" width="900" /><br><br>

1. Enter the SQL statement and click **Done**.

    ```
INSERT INTO locations (id,name,lat,lng,location_type,status) VALUES (:#id,:#name,:#lat,:#lng,:#location_type,:#status )
    ```

    <br><img src="../images/10-invoke-sql-2.png "Invoke SQL 2" width="900" /><br><br>

1. Click on Add step and select Data mapper

    <br><img src="../images/11-data-mapper.png "Data Mapper" width="900" /><br><br>

1. Drag and drop the matching **Source** Data types to all their corresponding **Targets** as per the following screenshot. When finished, click **Done**.

    <br><img src="../images/12-configure-mapper.png "Configure Mapper" width="900" /><br><br>

1. Click **Publish** on the next screen

1. Add Integration Name: addLocation.

1. Again Click **Publish**.

    <br><img src="../images/13-publish-integration.png "Publish Integration" width="900" /><br><br>

*Congratulations*. You successfully published the integration. (Wait for few minutes to for the integration to be built and published)

### Step 3: Create a POST request

We will use an online cURL tool to create the 101st record field in database.  If you'd prefer to use the Terminal in your Che instance, go ahead and skip the online cURL instructions and just use the cURL command in your Che Terminal.

1. Copy the External URL per the below screenshot

    <br><img src="../images/14-copy-URL.png "Copy URL" width="900" /><br><br>

1. Open a browser window and navigate to: https://onlinecurl.com/


1. Below are the values for the request.

  - Past the URL you just copied for the curl command
  - Click "+ ADD Option" 3 times
      - for --request (x) enter:
          - POST
      - for --data (-d) enter:
          - {"id": 101, "name": "Kamarhati", "type": "Regional Branch", "status": "1", "location": { "lat": "-28.32555", "lng": "-5.91531" }}
      - for --header (-H)
          - Content-Type: application/json
  - Note: id:101 in the payload as we are creating 101th record in the database.
  - Click START YOUR CURL
      - URL: https://i-addlocation-fuse-18308937-d7b6-11e8-96c6-0a580a810006.apps.ocp-ai.redhatgov.io/webhook/4dTcVchE8evWz3dVvtHFK3wvfFbFzpVLPEMq1TkcF0MGIbJmu4
      - --header (-H):  Content-Type: application/json
      - --data (-d): {"id": 101, "name": "Kamarhati", "type": "Regional Branch", "status": "1", "location": { "lat": "-28.32555", "lng": "-5.91531" }}
      - --request (-X): POST


      <br><img src="../images/15-online-curl.png "Online URL" width="900" /><br><br>

1. The page will load the 204 response information from the service which means the request was successfully fulfilled.  
  - If you get an SSL error, please see the next step.

      <br><img src="../images/16-response-header.png "Response Header" width="900" /><br><br>

1.  If you are using an Environment with self signed certificates and get an SSL error, you can also use the curl utility in the terminal of your Eclipse Che environment instead of online curl.  
  - Please make sure to use the your URL you copied and pasted

    ```
    curl -k \
    --header "Content-Type: application/json" \
    --request POST \
    --data '{"id": 101, "name": "Kamarhati", "type": "Regional Branch", "status": "1", "location": { "lat": "-28.32555", "lng": "-5.91531" }}' \
    https://i-addlocation-tools1.apps.ocp-ai.redhatgov.io/webhook/KcZ3E86SUJTqIUsA8iB7Yb5Sa1KLp9cchnRO5twYnr6UTruYd1
    ```


1. Click on **Activity > Refresh** and verify if the newly record is created.

    <br><img src="../images/17-activity-refresh.png "Activity Refresh" width="900" /><br><br>

1. _(Optional)_ Visit the application URL in the browser from the Location Service created in the previous lab and verify if the record can be fetched.


  **RESPONSE**
  ```
    {
      "id" : 101,
      "name" : "Kamarhati",
      "type" : "Regional Branch",
      "status" : "1",
      "location" : {
        "lat" : "-28.32555",
        "lng" : "-5.91531"
      }
    }
  ```

## Summary

In this lab you discovered how to create an adhoc API service using Fuse Online.


## Notes and Further Reading

* Fuse Online
  * [Webpage](https://www.redhat.com/en/technologies/jboss-middleware/fuse-online)
  * [Sample tutorials](https://access.redhat.com/documentation/en-us/red_hat_fuse/7.1/html-single/fuse_online_sample_integration_tutorials/index)
  * [Blog](https://developers.redhat.com/blog/2017/11/02/work-done-less-code-fuse-online-tech-preview-today/)
