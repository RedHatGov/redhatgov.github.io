---
title: Exercise 07 - API Developer Portal
workshops: agile_integrations
workshop_weight: 27
layout: lab
---
# Exercise 7: API Developer Portal

### Publishing APIs to Developer Portal

* Duration: 20 mins
* Audience: API Owners, Product Managers, Developers, Architects

## Exercise Description

The focal point of your developers' experience is the API developer portal, and the level of effort you put into it will determine the level of decreased support costs and increased developer engagement. This exercise focuses on customizing the Red Hat 3scale Developer portal and registering new accounts.

### Why Red Hat?

3scale provides a built-in, state-of-the-art CMS portal, making it very easy to create your own branded hub, with a custom domain to manage developer interactions and increase API adoption.

You can customize the look and feel of the entire Developer Portal to match your own branding. You have complete control over every element of the portal, so you can make it as easy as possible for developers to learn how to use your API.

## Section 1: Customizing the Developer Portal

### Step 1. Open a browser window and navigate to the Red Hat 3scale. Confirm the link with your instructor; it should be similar to the following: (Note: Replace userX with your assigned user ID.)

    ```bash
    https://user1-admin.apps.ocp-ai.redhatgov.io/
    ```
     *Remember to replace `X` with your user number.*

### Step 2. Accept the self-signed certificate, if you haven't already done so.

### Step 3. Log into 3scale using your designated user ID and password. Click **Sign In**.

    <br><img src="../images/01-login.png" width="900" /><br><br>

### Step 4. Click the **Developer Portal** tab to access the developer portal settings.

    <br><img src="../images/10-developer-portal.png" width="900" /><br><br>


### Step 5. From the left-side menu, select **Home Page**, and replace the entire content with the content from this example link [example](https://raw.githubusercontent.com/epe105/dayinthelife-integration/master/docs/labs/developer-track/lab07/support/homepage.example)

	<br><img src="../images/15-homepage-devportal.png" width="900" /><br><br>

### Step 6. Replace the CHANGE_ME_URL to the PLAN_URL you get from last lab.

	<br><img src="../images/16-replace.png" width="900" /><br><br>


### Step 7. Click the *Publish* button, at the bottom of the editor, to save the changes and make them available in the site.

Notes:
- If you're not ready to publish, 3scale provides options to  'Save' the draft or 'Revert' to the last published state.
- A full version history can be viewed, using the 'Versions Popup' link that displays above the content box.

    <br><img src="../images/14-publish-devportal.png" width="900" /><br><br>

### Step 8. Click the **API** tab and select the **Integration** link, under **SSO Location API**.

### Step 9. Click the **Application Plans** on the left-side menu, when it displays, and publish your application plan by clicking the **Publish** option on the page.  

	<br><img src="../images/17-publishplan.png" width="900" /><br><br>



### Step 10. Go back to the **Developer Portal** tab. Click on the **Visit Developer Portal** to take a look of how your developer portal looks like.

    <br><img src="../images/11-visit-devportal.png" width="900" /><br><br>

## Section 2: Register New Accounts Using Developer Portal

### Step 1. Impersonate one of your developers and signup for the **Secure** plan.

    <br><img src="../images/16a-signup-limited.png" width="900" /><br><br>

### Step 2. Fill in your user information,  provide an email address, and set a password, to register as a developer. Click the **Sign up** button.

    <br><img src="../images/16b-signup-form.png" width="900" /><br><br>

Note: The system will try to send a message with an activation link. However, currently the lab environment doesn't have a configured email server, so we won't be able to receive the email.

    <br><img src="../images/16bb-signup-thankyou.png" width="900" /><br><br>



### Step 3. Go back to your *Admin Portal* tab and navigate to **Developers** (tab) to activate the new account.

    <br><img src="../images/16bc-developers-tab.png" width="900" /><br><br>

### Step 4. Find your user under the *Accounts* and click the **Activate** link.

    <br><img src="../images/16cc-activate-account.png" width="900" /><br><br>

    *Your user is now active and can log into the portal*.

### Step 1. Ensure that the the application redirects the user to the correct page, after successful login. Click the Developer tab and click on the user you have created in the previous steps.

	<br><img src="../images/20-developers.png" width="900" /><br><br>

### Step 5. Select the application for the `SSO Location API` service.

	<br><img src="../images/21-select-application.png" width="900" /><br><br>

### Step 6. Update redirect link to your locations application link.  Check with your instructor if there are any concerns.  Please update
 http://www-userX.apps.ocp-ai.redhatgov.io/*

	<br><img src="../images/22-updare-redirect-link.png" width="900" /><br><br>

## Section 3: Login to Developer Portal

### Step 1. As your portal is not currently public, you will need your portal code to login. You can get the code in the admin portal navigating to: **Settings > Developer Portal > Domains &amp; Access**.

    <br><img src="../images/16d-access-portal.png" width="900" /><br><br>

### Step 2. Open a new *Incognito/Private* browser window to test the Developer Portal login. Navigate to the following.  Make sure your user and OpenShift environment is correct.

    ```bash
     https://userX.apps.ocp-ai.redhatgov.io/
    ```

### Step 3. Type your portal code to finish the login.

    <br><img src="../images/16e-ingress-code.png" width="900" /><br><br>

### Step 4. Sign in to the portal with your previously created developer account.

    <br><img src="../images/16f-dev-signin.png" width="900" /><br><br>

### Step 5. You will land in the developers homepage, where you will be able to check your developers settings and retrieve your newly created **Client ID** and **Client Secret** for the **Workshop App** you created.

    <br><img src="../images/16g-user-credentials.png" "Application Credentials" width="900" /><br><br>

*Copy down these credentials, as it you will use them to authenticate yourself to the managed API* in the next exercise.

*Congratulations!* You have successfully customized your Developer Portal and completed a Sign Up process.

## Steps Beyond

So, you want more? Click the **Documentation** link. Where does it takes you? *API Docs* is where you can add your interactive documentation for your APIs. The API Docs tool is based on the known *Swagger UI* interface.

From the Admin Portal, under *API Docs*, you can add the API definition to generate live testing.

## Summary

In this lab you discovered how to add a developer-facing experience to your APIs. Developers in your organization or outside of it can now register, gain access to API keys and develop sample applications.

## Notes and Further Reading

Red Hat 3scale API Management's Developer Portal CMS consists of a few elements:

* Horizontal menu in the Admin Portal with access to content, redirects, and changes
* The main area containing details of the sections above
* CMS mode, accessible through the preview option

<br><img src="../images/09-developer-portal.png" width="900" /><br><br>

[Liquid](https://github.com/Shopify/liquid) is a simple programming language used for displaying and processing most of the data from the 3scale system and is available for API providers. In 3scale, it is used to expose server-side data to your API developers, greatly extending the usefulness of the CMS while maintaining a high level of security.

### Links

* [Developer Portal Documentation](https://access.redhat.com/documentation/en-us/red_hat_3scale/2.2/html/developer_portal/)
* [Liquid markup language](https://github.com/Shopify/liquid)
* [And Overview of Liquid](https://www.shopify.com/partners/blog/115244038-an-overview-of-liquid-shopifys-templating-language)
