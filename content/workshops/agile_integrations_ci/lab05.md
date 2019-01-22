---
title: Lab 05 - API Security
workshops: agile_integrations_ci
workshop_weight: 25
layout: lab
---

# Lab 5

## API Security

### Securing APIs with OpenID Connect and Red Hat Single Sign On

* Duration: 20 mins
* Audience: API Owners, Product Managers, Developers, Architects

<br><img src="../images/agenda-05.png "Login" width="900" /><br><br>

## Overview

Once you have APIs in your organization and have applications being written, you also want to be sure in many cases that the various types of users of the APIs are correctly authenticated. In this lab you will discover how to set up the widely used OpenID connect pattern for Authentication.

### Why Red Hat?

The Red Hat SSO product provides important functionality for managing identities at scale. In this lab you will see how it fits together with 3scale and OpenShift.

##Lab Instructions

### Step 1: Get Red Hat Single Sign On Service Account Credentials

1. Open a browser window and navigate to your SSO Console.  Please check with your instructor for the link.  It should be similar to the following.  Replace userX with your assigned user and OCP_URL.

    ```bash
    http://sso-sso.apps.[OCP_URL]/auth/admin/[userX]/console/
    ```

    *Remember to replace the X with your user number.*

1. Log into Red Hat Single Sign On using your designated user and password. Click on **Sign In**.

    <br><img src="../images/00-login-sso.png "RH SSO Login" width="900" /><br><br>

1. Select **Clients** from the left menu.

    <br><img src="../images/00-clients.png "Clients" width="900" /><br><br>

    *A 3scale-admin client and service account was already created for you*.

1. Click on the **3scale-admin** link to view the details.

    <br><img src="../images/00-3scale-admin.png "3scale admin account"" width="900" /><br><br>

1. Click the **Credentials** tab.

    <br><img src="../images/00-sa-credentials.png "Service Account Credentials"" width="900" /><br><br>

1. Take notice of the service account **Secret**. Copy and save it or write it down as you will use it to configure 3scale.

    <br><img src="../images/00-sa-secret.png "Service Account Secret"" width="900" /><br><br>

### Step 2: Add User to Realm

1. Click on the Users menu on the left side of the screen.

    <br><img src="../images/00-users.png "Users Menu"" width="900" /><br><br>

1. Click the **Add user** button.

    <br><img src="../images/00-add-user.png "Add User"" width="900" /><br><br>

1. Type **apiuser** as the Username.

    <br><img src="../images/00-username.png "User Details"" width="900" /><br><br>

1. Click on the **Save** button.

1. Click on the **Credentials** tab to reset the password. Type **apipassword** as the *New Password* and *Password Confirmation*. Turn OFF the **Temporary** to avoid the password reset at the next login.

    <br><img src="../images/00-user-credentials.png "User Credentials"" width="900" /><br><br>

1. Click on **Reset Password**.

1. Click on the **Change password** button in the pop-up dialog.

    <br><img src="../images/00-change-password.png "Change Password Dialog"" width="900" /><br><br>

    *Now you have a user to test your integration.*

### Step 3: Configure 3scale Integration

1. Open a browser window and navigate to:

    ```bash
    https://userX-admin.apps.ocp-ai.redhatgov.io/p/login
    ```

    *Remember to replace the X with your user number.*

1. Accept the self-signed certificate if you haven't.

1. Log into 3scale using your designated [user and password](#environment). Click on **Sign In**.

    <br><img src="../images/01-login.png" width="900" /><br><br>

1. The first page you will land is the *API Management Dashboard*. Click on the **API** menu link.

    <br><img src="../images/01a-dashboard.png" width="900" /><br><br>

1. This is the *API Overview* page. Here you can take an overview of all your services. Click on the **Integration** link.

    <br><img src="../images/02-api-integration.png" width="900" /><br><br>

1. Click on the **edit integration settings** to edit the API settings for the gateway.

    <br><img src="../images/03-edit-settings.png" width="900" /><br><br>

1. Scrolll down the page, under the *Authentication* deployment options, select **OpenID Connect**.

    <br><img src="../images/04-authentication.png" width="900" /><br><br>

1. Click on the **Update Service** button.

1. Dismiss the warning about changing the Authentication mode by clicking **OK**.

    <br><img src="../images/04b-authentication-warning.png" width="900" /><br><br>

1. Back in the service integration page, click on the **edit APIcast configuration**.

    <br><img src="../images/05-edit-apicast.png" width="900" /><br><br>

1. Scroll down the page and expand the authentication options by clicking the **Authentication Settings** link.

    <br><img src="../images/05-authentication-settings.png" width="900" /><br><br>

1. In the **OpenID Connect Issuer** field, type in your previously noted client credentials with the URL of your Red Hat Single Sing On instance:

    ```bash
    http://3scale-admin:CLIENT_SECRET@sso-sso.apps.ocp-ai.redhatgov.io/auth/realms/userX
    ```

    *Remember to replace the X with user number*

    <br><img src="../images/06-openid-issuer.png "OpenID Connect Issuer"" width="900" /><br><br>

1. Scroll down the page and click on the **Update Staging Environment** button.

    <br><img src="../images/08-back-integration.png "Back Integration"" width="900" /><br><br>

1. After the reload, scroll down again and click the **Back to Integration &amp; Configuration** link.

    <br><img src="../images/07-update-environment.png "Update Environment"" width="900" /><br><br>

1. Promote to Production by clicking the **Promote to Production** button.

    <br><img src="../images/08a-promote-production.png "Update Environment"" width="900" /><br><br>

### Step 4: Create a Test App

1. Go to the *Developers* tab and click on **Developers**.

    <br><img src="../images/09-developers.png "Developers")

1. Click on the **Applications** link.

    <br><img src="../images/10-applications.png "Applications"" width="900" /><br><br>

1. Click on **Create Application** link.

    <br><img src="../images/11-create-application.png "Create Application"" width="900" /><br><br>

1. Select **Basic** plan from the combo box. Type the following information:

    * Name: **Secure App**
    * Description: **OpenID Connect Secured Application**

    <br><img src="../images/12-application-details.png "Application Details"" width="900" /><br><br>

1. Finally, scroll down the page and click on the **Create Application** button.

    <br><img src="../images/13-create-app.png "Create App"" width="900" /><br><br>

1. Update redirect link to your locations application link.  
  - Please update userX and OCP_URL http://www-[userX].apps.[OCP_URL]/
  -  And note the *API Credentials*. Write them down as you will need the **Client ID** and the **Client Secret** to test your integration.
    <br><img src="../images/14-app-credentials.png "App Credentials"" width="900" /><br><br>

*Congratulations!* You have now an application to test your OpenID Connect Integration.

## Steps Beyond

So, you want more? Login to the Red Hat Single Sign On admin console for your realm if you are not there already. Click on the Clients menu. Now you can check that 3scale zync component creates a new Client in SSO. This new Client has the same ID as the Client ID and Secret from the 3scale admin portal.

## Summary

Now that you can secure your API using three-leg authentication with Red Hat Single Sign-On, you can leverage the current assets of your organization like current LDAP identities or even federate the authentication using other IdP services.

For more information about Single Sign-On, you can check its [page](https://access.redhat.com/products/red-hat-single-sign-on).

## Notes and Further Reading

* [Red Hat 3scale API Management](http://3scale.net)
* [Red Hat Single Sign On](https://access.redhat.com/products/red-hat-single-sign-on)
* [Setup OIDC with 3scale](https://developers.redhat.com/blog/2017/11/21/setup-3scale-openid-connect-oidc-integration-rh-sso/)
