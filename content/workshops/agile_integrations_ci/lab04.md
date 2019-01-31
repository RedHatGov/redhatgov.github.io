---
title: Lab 04 - Managing API Endpoints
workshops: agile_integrations_ci
workshop_weight: 24
layout: lab
---
# Lab 4

## Managing API Endpoints

### Take control of your APIs

* Duration: 15 mins
* Audience: API Owners, Product Managers, Developers, Architects

<br><img src="../images/agenda-04.png "Login" width="900" /><br><br>

## Overview

Once you have APIs deployed in your environment, it becomes critically important to manage who may use them, and for what purpose. You also need to begin to track usage of these different users to know who is or is not succeeding in their usage. For this reason, in this lab, you will be adding management capabilities to the API to give you control and visibility of it's usage.

### Why Red Hat?

Red Hat provides one the leading API Management tools that provides API management services. The [3scale API Management](https://www.3scale.net/) solution enables you to quickly and easily protect and manage your APIs.


## Lab Instructions

### Step 1: Define your API Proxy

Your 3scale Admin Portal provides access to a number of configuration features.

1. Open a browser window and navigate to 3Scale.  Please check with you instructor if you need the link.

1. Log into 3scale using your designated user and password. Click on **Sign In**.

    <br><img src="../images/01-login.png" width="900" /><br><br>

1. The first page you will land is the *API Management Dashboard*. Click on the **API** menu link.

    <br><img src="../images/01a-dashboard.png" width="900" /><br><br>

1. This is the *API Overview* page. Here you can take an overview of all your services. Click on the **Integration** link.

    <br><img src="../images/02-api-integration.png" width="900" /><br><br>

1. Click on the **edit integration settings** to edit the API settings for the gateway.

    <br><img src="../images/03-edit-settings.png" width="900" /><br><br>

1. Keep select the **APIcast** deployment option in the *Gateway* section.

    <br><img src="../images/04-apicast.png" width="900" /><br><br>

1. Scroll down and keep the **API Key (user_key)** Authentication.

    <br><img src="../images/05-authentication.png" width="900" /><br><br>

1. Click on **Update Service**.

1. Click on the **add the Base URL of your API and save the configuration** button.

    <br><img src="../images/04-base-url.png" width="900" /><br><br>

1. Leave the settings for `Private Base URL`, `Staging Public Base URL`, and `Production Public Base URL` as it is. We will come back to the screen to update the correct values in later step.

1. Scroll down and expand the **MAPPING RULES** section to define the allowed methods on our exposed API.

    *The default mapping is the root ("/") of our API resources, and this example application will not use that mapping. The following actions will redefine that default root ("/") mapping.*

    <br><img src="../images/07b-mapping-rules.png" width="900" /><br><br>

1. Click on the **Metric or Method (Define)**  link.

    <br><img src="../images/07b-mapping-rules-define.png" width="900" /><br><br>

1. Click on the **New Method** link in the *Methods* section.

    <br><img src="../images/07b-new-method.png" width="900" /><br><br>

1. Fill in the information for your Fuse Method.

    * Friendly name: **Get Locations**

    * System name: **locations_all**

    * Description: **Method to return all locations**

    <br><img src="../images/07b-new-method-data.png" width="900" /><br><br>

1. Click on **Create Method**.

1. Click on the **Add mapping rule** link.

    <br><img src="../images/07b-add-mapping-rule.png" width="900" /><br><br>

1. Click on the edit icon next to the GET mapping rule.

    <br><img src="../images/07b-edit-mapping-rule.png" width="900" /><br><br>

1. Type in the *Pattern* text box the following:

    ```bash
    /locations
    ```

1. Select **locations_all** as Method from the combo box.

    <br><img src="../images/07b-getall-rule.png" width="900" /><br><br>

### Step 2: Define your API Policies

Red Hat 3scale API Management provides units of functionality that modify the behavior of the API Gateway without the need to implement code. These management components are know in 3scale as policies.

The order in which the policies are executed, known as the “policy chain”, can be configured to introduce differing behavior based on the position of the policy in the chain. Adding custom headers, perform URL rewriting, enable CORS, and configurable caching are some of the most common API gateway capabilities implemented as policies.

1. Scroll down and expand the **POLICIES** section to define the allowed methods on our exposed API.

    <br><img src="../images/policies-01.png "Policies" width="900" /><br><br>

    *The default policy in the Policy Chain is APIcast. This is the main policy and most of the times you want to keep it*.

1. Click the **Add Policy** link to add a new policy to the chain.

    <br><img src="../images/policies-02.png" width="900" /><br><br>

    _Out-of-the-box 3scale includes a set of policies you can use to modify the way your API gateway behaves. For this lab, we will focus on the **Cross Origin Resource Sharing (CORS)** one as we will use it in the consumption lab_.

1. Click in the **CORS** link to add the policy.

    <br><img src="../images/policies-03.png "CORS" width="900" /><br><br>

1. Put your mouse over the right side of the policy name to enable the reorder of the chain. Drag and drop the CORS policy to the top of the chain.

    <br><img src="../images/policies-04.png "Chain Order" width="900" /><br><br>

1. Now **CORS** policy will be executed before the **APIcast**. Click the **CORS** link to edit the policy.

    <br><img src="../images/policies-05.png "Cors Configuration"" width="900" /><br><br>

1. In the *Edit Policy* section, click the green **+** button to add the allowed headers.

    <br><img src="../images/policies-06.png "Add Allow Headers"" width="900" /><br><br>

1. Type **Authorization** in the *Allowed headers* field.

    <br><img src="../images/policies-07.png "Add Authorization Header"" width="900" /><br><br>

1. Tick the **allow_credentials** checkbox and fill in with a star (**\***) the *allow_origin* text box.

    <br><img src="../images/policies-08.png "Allow Origin"" width="900" /><br><br>

1. Click twice the green **+** button under *ALLOW_METHODS* to enable two combo boxes for the CORS allowed methods.

1. Select **GET** from the first box and **OPTIONS** from the second box.

    <br><img src="../images/policies-09.png "Allow Methods"" width="900" /><br><br>

1. Click the **Submit** button to save the policy configuration.

### Step 3: Configure the Upstream Endpoint

1. Scroll back to the top of the page. Fill in the information for accessing your API:

    * Private Base URL: **http://location-service.international.svc:8080**

    * Staging Public Base URL: **https://location-userX-api-staging.amp.apps.ocp-ai.redhatgov.io:443**

    * Production Public Base URL: **https://location-userX-api.amp.apps.ocp-ai.redhatgov.io:443**

    *Remember to replace the X with your user number*.

    *We are using the internal API service, as we are deploying our services inside the same OpenShift cluster*.

    <br><img src="../images/07-baseurl-configuration.png)

1. Scroll down to the **API Test GET request**.

1. Type in the textbox:

    ```bash
    /locations
    ```

1. Click on the **Update the Staging Environment** to save the changes and check the connection between client, gateway and API.

    <br><img src="../images/08-update-staging.png" width="900" /><br><br>

    *If everything works, you will get a green message on the left*.

1. Click on **Back to Integration &amp; Configuration** link to return to your API overview.

    <br><img src="../images/08aa-back-to-integration.png" width="900" /><br><br>

1. Click on the **Promote v.1 to Production** button to promote your configuration from staging to production.

    <br><img src="../images/08a-promote-production.png" width="900" /><br><br>

*Congratulations!* You have configured 3scale access control layer as a proxy to only allow authenticated calls to your backend API. 3scale is also now:

* Authenticating (If you test with an incorrect API key it will fail)
* Recording calls (Visit the Analytics tab to check who is calling your API).

## Steps Beyond

In this lab we just covered the basics of creating a proxy for our API service. Red Hat 3scale API Management also allows us to keep track of  security (as you will see in the next lab) as well as the usage of our API. If getting money for your APIs is also important to you, 3scale  allows you to monetize your APIs with its embedded billing system.

Try to navigate through the rest of the tabs of your Administration Portal. Did you notice that there are application plans associated to your API? Application Plans allow you to take actions based on the usage of your API, like doing rate limiting or charging by hit (API call) or monthly usage.

## Summary

You set up an API management service and API proxies to control traffic into your API. From now on you will be able to issue keys and rights to users wishing to access the API.

## Notes and Further Reading

* [Red Hat 3scale API Management](https://www.3scale.net/)
* [Developers All-in-one 3scale install](https://developers.redhat.com/blog/2017/05/22/how-to-setup-a-3scale-amp-on-premise-all-in-one-install/)
* [ThoughtWorks Technology Radar - Overambitious API gateways](https://www.thoughtworks.com/radar/platforms/overambitious-api-gateways)
