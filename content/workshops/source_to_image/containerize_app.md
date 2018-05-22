---
title: Lab - Containerize the App
workshops: source_to_image
workshop_weight: 14
layout: lab
---

# Introduction
Now we want to containerize the Gochat app.  If you are using the CLI on your own computer, you could use the **docker** command.  However, if you are in the Wetty terminal, remember you are actually in a container.  We could have exposed the container socket on the host to your Wetty container.  However, this would break the security model.

Fortunately we can build from a Dockerfile using the **oc** command line tool.  For those on your own computer, we recommend trying it this way as well.

## Step 1 - Create a New Project
Create a new project for your containerized gochat application.
```terminal
oc new-project gochat-container-user{{< span "userid" "YOUR#">}}
```

## Step 2 - Build from Dockerfile
Start a new build from the Dockerfile in the [gochat-container](https://github.com/kevensen/gochat-client-container) repository.

```terminal
oc new-build https://github.com/kevensen/gochat-client-container -e CHAT_SERVER=gochat-server.gochat-server.svc.cluster.local:8080
```

## Step 3 - Let's Take a Pause
Watch the deployment
```terminal
oc logs -f bc/gochat-client-container
```
Then **ctrl-c** once you've had enough.

## Step 4 - Deploy from ImageStream
```terminal
oc new-app gochat-client-container
```

## Step 5 - Expose the Containerized Gochat App
```terminal
oc expose svc gochat-client-container
```
## Step 6 - Annotate the Service Account to Use OpenShift Authorization
As in the previous lab, we must annotate the service account for the Gochat Client to communicate to the OpenShift API for user credential verification.
```terminal
oc annotate sa/default serviceaccounts.openshift.io/oauth-redirectreference.1='{"kind":"OAuthRedirectReference","apiVersion":"v1","reference":{"kind":"Route","name":"gochat-client-container"}}' --overwrite
```
```terminal
oc annotate sa/default serviceaccounts.openshift.io/oauth-redirecturi.1=auth/callback/openshift --overwrite
```
## Step 7 - Access the App
Go back to the OpenShift WebUI and click on the "gochat" URL.

{{< panel_group >}}
{{% panel "Gochat Service Route - URL" %}}

<img src="../images/gochat_container_url.png" width="800" align="middle"/>

{{% /panel %}}
{{< /panel_group >}}
## Step 8 - Sign in to the App
Click the blue "Login" button.
{{< panel_group >}}
{{% panel "Gochat Signin" %}}

<img src="../images/gochat_signin.png" width="800" align="middle"/>

{{% /panel %}}
{{< /panel_group >}}
Log in to the app with your OpenShift credentials.  The workshop moderator will provide you with the URL, your username, and password.

{{< panel_group >}}
{{% panel "OpenShift WebUI Login" %}}

<img src="../images/webui.png" width="1000" />

{{% /panel %}}
{{< /panel_group >}}

## Step 9 - Test the App
Send a message.

## Step 10 - Celebrate
**Yay**

## Step 11 - Logout
{{< panel_group >}}
{{% panel "Gochat Logout" %}}

<img src="../images/gochat_logout.png" width="600" align="middle"/>

{{% /panel %}}
{{< /panel_group >}}

{{< importPartial "footer/footer.html" >}}