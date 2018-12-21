---
title: Exercise 05 - Fuse Online API
workshops: agile_integrations
workshop_weight: 25
layout: lab
---

# Exercise 5: Creating a Fuse Online API

* Duration: 20 mins
* Audience: Developers and Architects

## Exercise Description

When it comes to quick API development, you need both integration experts, as well as application developers, to easily develop and deploy the APIs. Here is how to create a simple API with Red Hat Fuse online.

### Why Red Hat?

Red Hat Fuse integration solution empowers integration experts, application developers, and business users to engage in enterprise-wide collaboration and high-productivity self-service.

## Section 1: Create database connection

### Step 1. Navigate to OpenShift.

### Step 2. selected your Tools Project.

### Step 3. Click your fuse-ignite Route and Log In.

### Step 4. If this is the first time that you're visiting the Fuse Online URL, an *Authorize Access* page displays.  Click the **Allow selected permissions** button to accept the defaults.

   <br><img src="../images/design-54.png "Accept permissions" width="900" /><br><br>

### Step 5. Click **Connections > Create Connection**

   <br><img src="../images/00-create-connection.png "Create Connection" width="900" /><br><br>

### Step 6. Select **Database**

   <br><img src="../images/01-select-database.png "Select Database" width="900" /><br><br>

### Step 7. Enter the following values for Database Configuration

    ```
    Connection URL: jdbc:postgresql://postgresql.OCPPROJECT.svc:5432/sampledb
    Username      : dbuser
    Password      : password
    Schema        : <blank>
    ```
*Remember to replace the OCPPROJECT with the OpenShift project(NameSpace) you used in last lab.  It should be your username*

### Step 8. Click **Validate** and verify that the connection is successful. Click **Next** to proceed.

  <br><img src="../images/02-click-validate.png "Validate" width="900" /><br><br>

### Step 9. Add `Connection details`:
  - `Connection Name: LocationDB`
  - `Description: Location Database`
  - Click **Create**.

   <br><img src="../images/03-connection-details.png "Add Connection Details" width="900" /><br><br>

### Step 10. Verify that the `Location Database` is successfully created.

## Section 2: Create a Webhook integration

Fuse Online provides a Webhook connection that you can use in any number of integrations as the start connection. Each time you add this Webhook connection to an integration, Fuse Online provides a new random token for use with that integration. You paste this token at the end of your GET or POST request.

### Step 1. Click  **Integrations > Create Integration**

  <br><img src="../images/04-create-integration.png "Create Integration" width="900" /><br><br>

### Step 2. Choose **Webhook**

  <br><img src="../images/05-choose-weebhook.png "Choose webhook"Integration" width="900" /><br><br>

### Step 3. Click `Incoming webhook`.

  <br><img src="../images/06-incoming-webhook.png "Add incoming webhook" width="900" /><br><br>

### Step 4. On the Incoming Webhook screen, below the Webhook Token, click **Next**.

  <br><img src="../images/07-webhook-configuration.png "Webhook Configuration" width="900" /><br><br>

### Step 5. To define the Output Data Type (see second screenshot, below), from the `Select type` options select `JSON instance`. To apply a `Definition: `, copy the JSON data, from the first image below and paste it in the Definition text box. For `Data type Name` enter 'Custom'. Click **Done**.

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

  **Screenshot**

 <br><img src="../images/08-data-type.png "Data Type" width="900" /><br><br>

### Step 6. From the catalog, click  `LocationDB` and then select `Invoke SQL`

 <br><img src="../images/09-invoke-sql.png "Invoke SQL" width="900" /><br><br>

### Step 7. Enter the SQL statement and click **Done**.

 ```
   INSERT INTO locations (id,name,lat,lng,location_type,status) VALUES (:#id,:#name,:#lat,:#lng,:#location_type,:#status )
 ```

 **Screenshot**

 <br><img src="../images/10-invoke-sql-2.png "Invoke SQL 2" width="900" /><br><br>

### Step 8. Click `Add step` and select `Data mapper`

 <br><img src="../images/11-data-mapper.png "Data Mapper" width="900" /><br><br>

### Step 9. Drag and drop the matching **Source** Data types to all their corresponding **Targets** as per the following screenshot. When finished, click **Done**.

 <br><img src="../images/12-configure-mapper.png "Configure Mapper" width="900" /><br><br>

### Step 10. Click **Publish** on the next screen and add `Integration Name: addLocation`. Again Click **Publish**.

 <br><img src="../images/13-publish-integration.png "Publish Integration" width="900" /><br><br>

*Congratulations*. You successfully published the integration. (Wait for few minutes to build and publish the integration)

## Section 3: Create a POST request

We will use an online cURL tool to create the `101th` record field in database.

### Step 1. Copy the `External URL` per the below screenshot

   <br><img src="../images/14-copy-URL.png "Copy URL" width="900" /><br><br>

### Step 2. Open a browser window and navigate to:

   ```
     https://onlinecurl.com/
   ```

### Step 3. Below are the values for the request. Note: `id:101` in the payload as we are creating `101th` record in the database.

   ```
     URL: https://i-addlocation-fuse-18308937-d7b6-11e8-96c6-0a580a810006.dil.opentry.me/webhook/4dTcVchE8evWz3dVvtHFK3wvfFbFzpVLPEMq1TkcF0MGIbJmu4

     --header (-H):  Content-Type: application/json

     --data (-d): {"id": 101, "name": "Kamarhati", "type": "Regional Branch", "status": "1", "location": { "lat": "-28.32555", "lng": "-5.91531" }}

     --request (-X): POST
   ```

   <br><img src="../images/15-online-curl.png "Online URL" width="900" /><br><br>

### Step 4. The page will load the `204` response information from the service, which means the request was successfully fulfilled.

   <br><img src="../images/16-response-header.png "Response Header" width="900" /><br><br>


### Step 5. Click on **Activity > Refresh** and verify if the newly record has been created.

   !<br><img src="../images/17-activity-refresh.png "Activity Refresh" width="900" /><br><br>

### Step 6. _(Optional)_ Visit the application URL in browser and verify if the record can be fetched.

  **REQUEST**
  ```
   http://location-service-international.dil.opentry.me/locations/101

  ```

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

In this exercise you discovered how to create an ad hoc API service using Fuse Online.


## Notes and Further Reading

* Fuse Online
  * [Webpage](https://www.redhat.com/en/technologies/jboss-middleware/fuse-online)
  * [Sample tutorials](https://access.redhat.com/documentation/en-us/red_hat_fuse/7.1/html-single/fuse_online_sample_integration_tutorials/index)
  * [Blog](https://developers.redhat.com/blog/2017/11/02/work-done-less-code-fuse-online-tech-preview-today/)
