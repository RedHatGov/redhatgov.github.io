---
title: Exercise 02 - API Mocking
workshops: agile_integrations
workshop_weight: 22
layout: lab
---
# Exercise 2: API Mocking

### Bring your APIs to life

* Duration: 20 mins
* Audience: Developers, Architects, Testers, Quality Engineers

## Exercise Description

When building and working with APIs, you often need to simulate the responses of the system before it has been fully completed. This is what we explore in this workshop - mocking up API structures quickly, so they can be subjected to testing, without having to create all the final service code.

### Why Red Hat?

Red Hat combines several commercial and open source tools to cover each part of the API Design lifecycle. In this exercise we'll be using the [Microcks](http://microcks.github.io/) open source tool.

## Prerequisite: Setup the collaboration environment using Git (Gogs)

For the Developer track, we require a collaboration environment based on Git. For this purpose, we  decided to use Gogs which is a hosted, lighter-weight version of GitLab. This lab environment has created a user for you in Gogs.

## Section 1: Set up a Repository

### Step 1. Open a browser window and navigate to Gogs.

### Step 2. Log into Gogs using your designated [user and password](#environment). Click on **Sign In**.

    <br><img src="../images/mock-01.png "Sign In" width="900" /><br><br>

### Step 3. In the main page, click in the **+** sign in the right top corner to display the *New* menu. Click the **New Migration** option.

    <br><img src="../images/mock-02.png "New Migration" width="900" /><br><br>

### Step 4. Fill in the repository migration information using the following values:

    * Clone Address: **https://github.com/epe105/dayinthelife-openapi.git**
    * Owner: **UserX**
    * Repository Name: **locations-api**

    <br><img src="../images/mock-03.png "New Migration Repository" width="900" /><br><br>

### Step 5. Click **Migrate Repository** to fork the GitHub repo into Gogs.

### Step 6. Switch to branch `dev-track-lab-02`

    <br><img src="../images/mock-04.png "Upload File" width="900" /><br><br>

### Step 7. Open the `locations-api` folder and click the filename link **Locations-UserX.json** to open and review the file.

    <br><img src="../images/mock-05.png "Click File" width="900" /><br><br>

### Step 8. If the file details are correct, click the **Edit** button to apply your personal user settings.

    <br><img src="../images/mock-06.png "Edit file" width="900" /><br><br>

### Step 9. Replace **UserX** with your user number.

    <br><img src="../images/mock-07.png "Rename file" width="900" /><br><br>

### Step 10. Commit the changes to Gogs.

    <br><img src="../images/mock-08.png "Commit file" width="900" /><br><br>

### Step 11. Click the **RAW** button, to get the raw download version of the file.

    <br><img src="../images/mock-09.png "Raw file" width="900" /><br><br>

### Step 12. Copy the browser tab URL. Store that URL address, as you will use it in the next steps of the exercise. The URL should look similar to the following:

    ```bash
     http://gogs.apps.ocp-ai.redhatgov.io/userX/locations-api/raw/dev-track-lab-02/locations-api/Locations-UserX.json
    ```

    *If you feel more comfortable, you can also copy and paste the RAW button link from the previous step.  Also, remember to update the X variable with your user number*.

## Section 2: Create a Microcks Job

### Step 1. Open a browser window and navigate to microcks.

### Step 2. Log in into Microcks using your designated [user and password](#environment).

    <br><img src="../images/mock-10.png "Openshift Login" width="900" /><br><br>

### Step 3. You are now in the main Microcks page. Click the **Importers** button to access the Importers page.

    <br><img src="../images/mock-11.png "Job" width="900" /><br><br>

### Step 4. Click the **Create** button to create your first job.

    <br><img src="../images/mock-12.png "Job" width="900" /><br><br>

### Step 5. In the `Create a New Job` dialog, type the following information; replace **X** with your user number. Click **Next**.

    * Name: **Locations-UserX**
    * Repository URL: *You can also copy and paste the raw url you saved from the Gogs repository*.  It is similar to the below link.
      * **http://gogs.apps.ocp-ai.redhatgov.io/userX/locations-api/raw/dev-track-lab-02/locations-api/Locations-UserX.json**



    <br><img src="../images/mock-13.png "Job Details" width="900" /><br><br>

### Step 6. Click **Next** for the Authentication options.

### Step 7. Review the details and click **Create** to create the job.

   <br><img src="../images/mock-14.png "Create Job" width="900" /><br><br>

### Step 8. After your job is created, click the **Activate** option.

    <br><img src="../images/mock-15.png "Activate Job" width="900" /><br><br>

### Step 9. Repeat the last step, but now select the **Force Import** option. This will start the synchronization job.

    <br><img src="../images/mock-16.png "Start Job" width="900" /><br><br>

### Step 10. Refresh your window to get it to the latest state.

### Step 11. You will see 3 labels next to your Job. Click the **Services** label.

    <br><img src="../images/mock-17.png "Job Services" width="900" /><br><br>

### Step 12. In the dialog you will see your service listed. Click the **Locations-UserX - 1.0.0.** link.

    <br><img src="../images/mock-18.png "Job Service" width="900" /><br><br>

### Step 13. Click **Close** to dismiss the dialog.

### Step 14. This is your new REST mock service, based on the OpenAPI definition you just loaded to Microcks. Click the arrow to expand the **GET /locations** operation.

    <br><img src="../images/mock-19.png "Mock Service" width="900" /><br><br>

### Step 15. You can verify that the example we added to the definition in [Lab 1](lab01.md) will be used to return the mock values. Scroll down, copy and save the **Mocks URL**, we will use that endpoint to test the REST mock service.

    <br><img src="../images/mock-20.png "Mock Operation" width="900" /><br><br>


## Section 3: Test the REST Mock Service

We now have a working REST mock service listening for requests. We will use an online cURL tool to test it.

### Step 1. Open a browser window and navigate to:

    ```bash
    https://onlinecurl.com/
    ```

### Step 2. Copy and paste the Mock URL from earlier step. *Remember to replace X with your user number*. It should look similar to the link below.

   ```bash
   http://microcks.apps.ocp-ai.redhatgov.io/rest/Locations-UserX/1.0.0/locations
   ```

### Step 3. Click the **START YOUR CURL** button.

    <br><img src="../images/mock-21.png "cURL Service" width="900" /><br><br>

### Step 4. The page will load the response information from the service. You will be able to see the *RESPONSE HEADERS* and the actual *RESPONSE_BODY*. This last part contains the examples we add during the design phase.

    <br><img src="../images/mock-22.png "cURL Response" width="900" /><br><br>

*Congratulations!* You have successfully configured a Microcks Job to create a REST mock service to test your API.

## Steps Beyond

> So, you want more? ...

## Summary

In this exercise you used Microcks, to configure a REST mock service, for the API definition you created in the previous exercise. REST mock services enables you to simulate a REST API service when you are in a prototyping stage of your API program journey.

Microcks enables you to test a number of various responses for client application requests. When deploying API, micro-services or SOA practices at large scale, Microcks solves the problems of providing and sharing consistent documentation and mocks to the involved teams. It acts as a central repository and server that can be used for browsing but can also be used by your Continuous Integration builds or pipelines.

## Notes and Further Reading

* Microcks
  * [Webpage](http://microcks.github.io/)
  * [Jenkins Plugin](http://microcks.github.io/automating/jenkins/)
  * [Installing on OpenShift](http://microcks.github.io/installing/openshift/)
