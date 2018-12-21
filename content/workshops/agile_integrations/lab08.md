---
title: Exercise 08 - API Consumption
workshops: agile_integrations
workshop_weight: 28
layout: lab
---
# Exercise 8: API Consumption

### Connect Applications and APIs

* Duration: 15 mins
* Audience: API Consumers, Developers, Architects

### Exercise Description

APIs provide the building blocks for applications, but it is applications which deliver functionality to the end users. Hence, to see APIs in action it helps to understand how applications can call APIs to provide new functionality. In this lab you'll be able to create a simple web application which consumes the API you built earlier in the exercises.  

### Why Red Hat?

Applications can be built from many technologies. In this case we use a simple web application, but a wide range of Red Hat and non-Red Hat technologies could be used.

Red Hat 3scale API Management makes it easy to manage your APIs for internal or external users. Share, secure, distribute, control, and monetize your APIs on an infrastructure platform built with performance, customer control, and future growth in mind. You can place any 3scale components on-premise, in the cloud, or on any combination of the two.

## Section 1: Update the OpenShift Deployment

OpenShift enables you to automatically redeploy your changes when you setup a Continuous Integration / Continuous Deployment (CI/CD) pipeline, through the use of a webhook. For this lab we will trigger the new build and deployment manually through the Red Hat OpenShift Container Platform console.

### Step 1. Go back to your OpenShift web console. Navigate to your project's overview page.

### Step 2. Scroll down and click the 'www' link in the BUILDS section.

   <br><img src="../images/deploy-10.png" "Scroll Down" width="900" /><br><br>

### Step 3. On the build environment variables page, replace the `CLIENT_ID` from `CHANGE_ME` to the one generated in the previous lab.

   <br><img src="../images/deploy-11.png" "Change Client ID" width="900" /><br><br>

### Step 4. Click Save to persist the changes. A green popup message will confirm that the changes were saved.

### Step 5. Click Start Build to trigger a new build, using the new environment variables that point to your service.

   <br><img src="../images/deploy-12.png "Start Build" width="900" /><br><br>

### Step 6. On the Overview Page, a new build will be triggered. Expand the row by clicking the Builds Icon.

   <br><img src="../images/deploy-13.png "View Build" width="900" /><br><br>

*The build process checks out the code from the Git repo, runs a source-to-image container image build, and redeploys the container with the new image, using a rolling upgrade strategy.*

### Step 7. Wait until the new Build completes and the rolling upgrade finishes, before testing your new deployment.

   <br><img src="../images/consume-22.png "Updated App" width="900" /><br><br>

## Section 2: Update Secured Service with Red Hat Single Sign-On (SSO) Application Callback

Redirect URLs are a critical part of the OAuth flow. After a user successfully authorizes an application, the authorization server redirects the user back to the application, with either an authorization code or access token in the URL. Because the redirect URL contains sensitive information, it is critical that the service doesn’t redirect the user to arbitrary locations.

### Step 1. Open a browser window and navigate to your SSO Console.  Please check with your instructor for the link.  It should be similar to the following.  Replace userX with your assigned user.

    ```bash
    http://sso-sso.apps.ocp-ai.redhatgov.io/auth/admin/userX/console/
    ```

    *Remember to replace the X with your user number.*

### Step 2. Log into Red Hat Single Sign-On, using your designated [user and password](#environment). Click on **Sign In**.

    <br><img src="../images/00-login-sso.png "RH SSO Login" width="900" /><br><br>

### Step 3. Select **Clients** from the left menu.

    <br><img src="../images/00-clients.png "Clients" width="900" /><br><br>

    *3scale, through its [zync](https://github.com/3scale/zync/) component, already synchronized the application information into the Red Hat SSO security realm*.

### Step 4. Click on the **CLIENT_ID** link to view the details.

   *Remember to select correct CLIENT_ID with the one you got in the [API Security Lab](../lab07). It will easily identifiable as its and hexadecimal name*.

   <br><img src="../images/consume-24.png "Client Application" width="900" /><br><br>

### Step 5. Scroll down the Client ID details page, type in and select the following options in the application configuration below.  Please make sure to use the Redirect URI for your user.

    | Field | Value |
    | --- | --- |
    | Access Type | Public |
    | Standard Flow Enabled | ON |
    | Implicit Flow Enabled | OFF |
    | Valid Redirect URIs | http://www-userX.apps.ocp-ai.redhatgov.io/* |
    | Web Origins | \* |

    *Remember to replace the X with your user number.*

    <br><img src="../images/consume-25.png "Client Configuration" width="900" /><br><br>

### Step 6. Finally, click **Save** button to persist the changes.

## Section 3: Test the Single Sign-On Integration

### Step 1. Open a browser tab and navigate to your SSO Location App.  It should be a similar link to:  
  - `http://www-userX.apps.ocp-ai.redhatgov.io/`.
  - *Remember to replace the X your user number.*

### Step 2. Navigate to the Locations Page.

### Step 3. Click the **Sign In** button.

### Step 4. You are being redirected to Red Hat Single Sign-On **Login Page**. Login using the user credentials you created in the [API Security Lab](../lab04/#step-2-add-user-to-realm)

   * Username: **userX**
   * Password: **password you received from instructor**

    <br><img src="../images/consume-23.png "Login Realm" width="900" /><br><br>

### Step 5. You will be redirected again to the **LOCATIONS** page, where you will be able to see the map with the International Inc Offices.

    <br><img src="../images/consume-14.png "Locations Page" width="900" /><br><br>

 *Congratulations!* You have successfully used the Keycloak Javascript Adapter to protect International Inc's Locations Service with Single Sign-On.

## Section 4: Troubleshooting the Locations Page

### Step 1. In most cases, the Locations web page will **NOT** show the locations because of a self-signed certificate issue in your web-browser.  

### Step 2. To resolve this issue in Chrome, navigate to *More Tools > Developer Tools* menu and view the Developer Tools portal.

### Step 3. In the developer portal, when a red error displays, indicating a cert issue, click the link and accept the certificate.  

### Step 4. In Settings > Advanced > Privacy and Security > Protect you and your device from dangerous sites. *Make sure to turn that option off, and turn the option back on after the exercise.*


### Step  5. Refresh the page, and the locations display.

## Steps Beyond

So, you want more? You can explore in detail the documentation on the Javascript Adapter to check what other things can you get from your authenticated user.

## Summary

In total you should now have been able to follow all the steps from designing and API, deploying its code, issuing keys, connecting OpenID connect, and calling it from an application. This exercise provided you with a brief overview of the creation and deployment of an API. There are many variations and extensions of these general principles to explore!

## Notes and Further Reading

* [Red Hat 3scale API Management](http://microcks.github.io/)
* [Setup OIDC with 3scale](https://developers.redhat.com/blog/2017/11/21/setup-3scale-openid-connect-oidc-integration-rh-sso/)
