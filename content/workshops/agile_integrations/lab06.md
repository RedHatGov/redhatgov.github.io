---
title: Exercise 06 - Managed API Endpoints
workshops: agile_integrations
workshop_weight: 26
layout: lab
---
# Exercise 6: Managed API Endpoints

### Take control of your APIs

* Duration: 5 mins
* Audience: API Owners, Product Managers, Developers, Architects

## Exercise Description

Once you have APIs deployed in your environment, it becomes critically important to manage who may use them, and for what purpose. You also need to begin to track usage of these different users to know who is/is not successful in their API usage. For this reason, in this exercise, you will be adding management capabilities to the API - to give you control and visibility of its usage, using Red Hat 3scale API Management,

### Why Red Hat?

Red Hat provides one of the leading API Management tools that provides management services, cost effectively. The 3scale API Management solution enables you to quickly and easily protect and manage your APIs, for internal and external users. It is a powerful infrastructure that adapts to meet your requirements, while offering deployment flexibility, integration and security.

## Section 1: Get API Token for Automation

Your 3scale Administration Portal provides access to several configuration features. However, prior to automating API setups, an administration token is required. This section will guide you in creating a new token for automated setups.

### Step 1. Open a browser window and navigate to the Red Hat 3scale. Confirm the link with your instructor; it should be similar to the following: (Note: Replace userX with your assigned user ID.)

    ```bash
    https://userX-admin.apps.ocp-ai.redhatgov.io
    ```

### Step 2. Accept the self-signed certificate, if you haven't already done so.

### Step 3. Log into 3scale, using your designated user ID and password. Click **Sign In**.

    <br><img src="../images/01-login.png" width="900" /><br><br>

### Step 4. Your landing page is the *API Management Dashboard*. Click the **Gear Icon** in the top right-hand corner and select 'Personal Settings'.

    <br><img src="../images/02-personalsettings.png" width="900" /><br><br>

### Step 5. Click the  **Tokens** Tab.
	<br><img src="../images/03-tokentab.png" width="900" /><br><br>

### Step 6. Click  **Add Access Token** to create a new management/Access token.
	<br><img src="../images/06-menu.png" width="900" /><br><br>


### Step 7. Create a new token, with 'Read & Write' permissions, to your management platform. Enter Name as **securetoken**, check the **Account management API** checkbox and **READ & WRITE** for Permission.

	<br><img src="../images/04-setuptoken.png" width="900" /><br><br>

### Step 8. Please make sure you record the **Token** to a secure place, and don't forget it. Click **I have copied the token** to finish off.

	<br><img src="../images/05-token.png" width="900" /><br><br>


### Section 2: Start managing your APIs

Using command lines, you will automatically setup the 3scale API configuration and start managing the API you have exposed!

### Step 1. In your command line terminal, or in your Che terminal, enter the following cURL command:

*Replace USERX as your user id, such as user1, user26, and OPENSHIFT_APP_URL, if you are not sure, check with your instructor*

```bash
curl -X POST http://threescale-automate-international.apps.ocp-devsecops2.redhatgov.io/threescale/automate/{YOUR_API_TOKEN}/{USERX}/{OPENSHIFT_APP_URL}
```

For example:

```bash
curl -X POST http://threescale-automate-international.apps.ocp-ai.redhatgov.io/threescale/automate/5077c20822f2e284aaa48d9b2115551cc9605cb9617eb2479815a4209fea20d9/user1/apps.ocp-ai.redhatgov.io
```

String **API automated, DONE!** should be returned as the result.

### Step 2. **Save the Result as you will need it for the next exercise**

*Congratulations!* You have configured 3scale access control layer as a proxy, which will only allow authenticated calls to your backend API.

3scale is also now:

* Authenticating (If you test with an incorrect API key it will fail)
* Recording calls (Visit the Analytics tab to check who is calling your API).

## Steps Beyond

In this exercise, we covered  basic proxy creation, for our API service. Red Hat 3scale API Management also enables us to track the security (as you can see in the next exercise), as well as the usage of our API. If getting value from APIs is also important to you, 3scale enables you to monetize your APIs with its embedded billing system.

Try to navigate through the remaining tabs of your Administration Portal. Did you notice that there are application plans associated to your API? Application Plans enable you to take actions, based on API usage, like doing rate limiting or charging by hit, or monthly usage.

## Summary

You set up an API management service and API proxies to control traffic into your API. From now on you will be able to issue keys and rights to users wishing to access the API.

## Notes and Further Reading

* [Red Hat 3scale API Management](http://microcks.github.io/)
* [Developers All-in-one 3scale install](https://developers.redhat.com/blog/2017/05/22/how-to-setup-a-3scale-amp-on-premise-all-in-one-install/)
* [ThoughtWorks Technology Radar - Overambitious API gateways](https://www.thoughtworks.com/radar/platforms/overambitious-api-gateways)
