---
title: Lab 02 - API Mocking
workshops: agile_integrations_ci
workshop_weight: 22
layout: lab
---
# Lab 2

## API Mocking

### Bring your APIs to life

* Duration: 20 mins
* Audience: Developers, Architects, Testers, Quality Engineers

<br><img src="../images/agenda-02.png "Login" width="900" /><br><br>

## Overview

When building and working with APIs, you often need to simulate the responses of the system before it has been fully completed. This is what we explore in this workshop - mocking up API structures quickly so they can be subjected to testing without having to create all the final service code.

### Why Red Hat?

Red hat combines and number of commercial and Open Source tools to cover each part of the API Design lifecycle. In this lab we'll be using the [Microcks](http://microcks.github.io/) open source tool.

## Lab Instructions


### Step 1: Create a Microcks Job

1. Open a browser window and navigate to microcks.  Please ask your instructor if you need the link.

1. Log in into Microcks using your designated user and password.

    <br><img src="../images/mock-09.png "Openshift Login" width="900" /><br><br>

1. You are now in the main Microcks page. Click the **Importers** button to access the Importers page.

    <br><img src="../images/mock-11.png "Job" width="900" /><br><br>

1. Click the **Upload** button to upload the **Locations-UserX.yaml** spec generated from Lab 1.

    <br><img src="../images/mock-12.png "Upload Spec" width="900" /><br><br>

1. Click on **Upload**.

    <br><img src="../images/mock-13.png "Upload" width="900" /><br><br>

   *Congratulations! The spec is successfully imported*

1. Navigate to **APIs | Services** tab.

    <br><img src="../images/mock-14.png "Job" width="900" /><br><br>

1. Click on the link for your username. eg: **Locations-User1**.

    <br><img src="../images/mock-15.png "Select services" width="900" /><br><br>

1. Click on the arrow to expand the **Operation GET /locations**.

    <br><img src="../images/mock-16.png "Mock Service" width="900" /><br><br>


1. You can check that the example we added to the definition in [Lab 1](lab01.md) will be used to return the mock values. Copy and save the **Mocks URL**, we will use that endpoint to test the REST mock service.

    <br><img src="../images/mock-17.png "Mock Operation" width="900" /><br><br>

### Step 2: Test the REST Mock Service

We now have a working REST mock service listening for requests. We will use an online cURL tool to test it.

1. Open a browser window and navigate to:

    ```bash
    https://onlinecurl.com/
    ```

1. Enter the copied URL from **Step 9**. It should look similar to this:

    ```bash
    http://microcks.apps.ocp-ai.redhatgov.io/rest/Locations-User1/1.0.0/locations
    ```

1. Click the **START YOUR CURL** button.

    <br><img src="../images/mock-18.png "cURL Service" width="900" /><br><br>

1. The page will load the response information from the service. You will be able to see the *RESPONSE HEADERS* and the actual *RESPONSE_BODY*. This last part contains the examples we add during the design phase.

    <br><img src="../images/mock-19.png "cURL Response" width="900" /><br><br>

*Congratulations!* You have successfully configure a Microcks Job to create a REST mock service to test your API.

## Summary

In this lab you used Microcks to configure a REST mock service for the API definition you created in the previous lab. REST mock services allows you to simulate a REST API service when you are in a prototyping stage of your API program journey.

Microcks allows you to test a number of various responses for client application requests. When deploying API, micro-services or SOA practices at large scale, Microcks solves the problems of providing and sharing consistent documentation and mocks to the involved teams. It acts as a central repository and server that can be used for browsing but also by your Continuous Integration builds or pipelines.

## Notes and Further Reading

* Microcks
  * [Webpage](http://microcks.github.io/)
  * [Jenkins Plugin](http://microcks.github.io/automating/jenkins/)
  * [Installing on OpenShift](http://microcks.github.io/installing/openshift/)
