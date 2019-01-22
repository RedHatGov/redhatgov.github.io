---
title: Lab 08 - API Consumption
workshops: agile_integrations_dev
workshop_weight: 28
layout: lab
---
# Lab 8

## API Consumption

### Connect Applications and APIs

* Duration: 15 mins
* Audience: API Consumers, Developers, Architects

<br><img src="../images/agenda-05.png "Login" width="900" /><br><br>

### Overview

APIs provide the building blocks for applications, but it is applications which deliver functionality to the end users. hence to see APIs in action it helps to see how applications can call APIs to provide new functionality. In this lab you'll be able to create a simple web application which consumes the API you built earlier in the exercises.  

### Why Red Hat?

Applications can be built from many technologies. In this case we use a simple web application, but a wide range of Red Hat and non-Red Hat technologies could be used.

## Lab Instructions

### Update OpenShift Deployment

OpenShift let you automatically redeploy your changes when you setup a Continuous Integration / Continuous Deployment (CI/CD) pipeline through the use of webhook. For this lab we will trigger the new build and deployment manually through the OpenShift Console.

1. Go back to your OpenShift web console. Navigate to your project's overview page.

1. Scroll down and click in the www link in the BUILDS section.

    <br><img src="../images/deploy-10.png" "Scroll Down" width="900" /><br><br>

1. In the build environment variables page, replace the `CLIENT_ID` from `CHANGE_ME` to the one generated from the previous lab.
  - Also, make note of the API_BACKEND_URL.  That is the 3Scale backend address of your API.  If the 3Scale Environment is configured with self-signed certificates, go ahead and bring up that link in a Browser and have your Browser accept the certificate for later on. 3Scale should give you an authentication error since it's not configured yet.  The important thing is to just accept the certificate.

    <br><img src="../images/deploy-11.png" "Change Client ID" width="900" /><br><br>

1. Click Save button to persist the changes. A green pop up will show you that the changes were saved.

1. Click the Start Build button to trigger a new build using the new environment variables pointing to your service.

    <br><img src="../images/deploy-12.png "Start Build" width="900" /><br><br>

1. In the Overview Page, a new build will be triggered. Expand the row by clicking the Builds Icon.

    <br><img src="../images/deploy-13.png "View Build" width="900" /><br><br>

*The build process checks out the code from the git repo, runs a source-to-image container image build, and redeploys the container with the new image using a rolling upgrade strategy.*

1. Wait for until the new Build to complete and the rolling upgrade to finish to test your new deployment.

    <br><img src="../images/consume-22.png "Updated App" width="900" /><br><br>

### Update Secured Service with Red Hat Single Sign On Application Callback

Redirect URLs are a critical part of the OAuth flow. After a user successfully authorizes an application, the authorization server will redirect the user back to the application with either an authorization code or access token in the URL. Because the redirect URL will contain sensitive information, it is critical that the service doesn’t redirect the user to arbitrary locations.

1. Open a browser window and navigate to your SSO Console.  Please check with your instructor for the link.  It should be similar to the following.  Replace userX with your assigned user and OCP_URL.

    ```bash
    http://sso-sso.apps.[OCP_URL]/auth/admin/[userX]/console/
    ```

    *Remember to replace the X with your user number.*

1. Log into Red Hat Single Sign On using your designated user and password. Click on **Sign In**.

    <br><img src="../images/00-login-sso.png "RH SSO Login" width="900" /><br><br>

1. Select **Clients** from the left menu.

    <br><img src="../images/00-clients.png "Clients" width="900" /><br><br>

    *3scale, through it's [zync](https://github.com/3scale/zync/) component, already synchronized the application information into the Red Hat SSO security realm*.

1. Click on the **CLIENT_ID** link to view the details.

   *Remember to select correct CLIENT_ID with the one you got in the [API Security Lab](../lab07). It will easily identifiable as its and hexadecimal name*.

   <br><img src="../images/consume-24.png "Client Application" width="900" /><br><br>

1. Scroll down, type in and select the following options in the application configuration below.  Please make sure to use the Redirect URI for your user.

    | Field | Value |
    | --- | --- |
    | Access Type | Public |
    | Standard Flow Enabled | ON |
    | Implicit Flow Enabled | OFF |
    | Valid Redirect URIs | http://www-userX.apps.[OCP_URL]/* |
    | Web Origins | \* |

    *Remember to replace the X with your user number.*

    <br><img src="../images/consume-25.png "Client Configuration" width="900" /><br><br>

1. Finally, click **Save** button to persist the changes.

### Test the Single Sign On Integration

1. Open a Private Browser tab and navigate to your SSO Location App.  Update userX and OCP_URL :  
  - `http://www-userX.apps.[OCP_URL]/`.
  - *Remember to replace the X your user number.*

1. Navigate to the Locations Page

1. Click the **Sign In** button.

1. You are being redirected to Red Hat Single Sign On **Login Page**. Login using the user credentials you created in the [API Security Lab](../lab04/#step-2-add-user-to-realm)

    * Username: **userX**
    * Password: **password you received from instructor**

    <br><img src="../images/consume-23.png "Login Realm" width="900" /><br><br>

1. You will be redirected again to the **LOCATIONS** page where now you will be able to see the map with the International Inc Offices.

    <br><img src="../images/consume-14.png "Locations Page" width="900" /><br><br>

 *Congratulations!* You have successfully used the Keycloak Javascript Adapter to protect International Inc's Locations Service with Single Sign On.  If you have any issues, please see the next session.

### Troubleshooting the Locations Page

 1. In most cases, the Locations web page will **NOT** show the locations because of a self-signed certificate issue in your web-browser.  

 1. To resolve this issue in Chrome, navigate to More Tools > Developer Tools* menu.  A Developer Tools console should appear.

 1. In the developer console, a red error should appear indicating a cert issue. Click on the link and accept the certificate.  

 1. Refresh the page, and the locations should appear.

 1. If you get an "Authentication Parameter is Missing" Error.  It's most likely your backend api is not working
    - Make you created the location-service API from Lab 3  
    - Go into 3Scale and update the Private Base URL for the SSO Locations API to a working API such as the sample Locations API that your instructor can give you.   

 1. Also, make sure to use an Incognito Browser Window or Clear your Browser Cache when viewing the International Sample Application

 1. Also you can try relaxing your browser security settings.  In Settings > Advanced > Privacy and Security > Protect you and your device from dangerous sites
  - Turn that option to off
  - Make sure to turn this setting back on after the lab


## Steps Beyond

So, you want more? You can explore in detail the documentation on the Javascript Adapter to check what other things can you get from your authenticated user.

## Summary

In total you should now have been able to follow all the steps from designing and API, deploying it's code, issuing keys, connecting OpenID connect and calling it from an application. This gives you a brief overview of the creation and deployment of an API. There are many variations and extensions of these general principles to explore!

## Notes and Further Reading

* [Red Hat 3scale API Management](http://microcks.github.io/)
* [Setup OIDC with 3scale](https://developers.redhat.com/blog/2017/11/21/setup-3scale-openid-connect-oidc-integration-rh-sso/)
