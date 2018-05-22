---
title: Lab - Run the App
workshops: source_to_image
workshop_weight: 13
layout: lab
---

## Step 1 - Create a Route to the Gochat Service
First we expose the pod with a service.
```terminal
oc expose dc wetty --port=8080 --target-port=8080 --name=gochat
```
Then we expose the service with a route.
```terminal
oc expose svc gochat
```
## Step 2 - Download the App Source
```terminal
go get -d github.com/kevensen/openshift-gochat-client
```
## Step 3 - Build the App
```terminal
cd go/src/github.com/kevensen/openshift-gochat-client
```
```terminal
glide install -v && go install
```
## Step 4 - Annotate the Service Account to Use OpenShift Authorization
These annotations allow for the Gochat Client to communicate to the OpenShift API for user credential verification.
```terminal
oc annotate sa/default serviceaccounts.openshift.io/oauth-redirectreference.1='{"kind":"OAuthRedirectReference","apiVersion":"v1","reference":{"kind":"Route","name":"gochat"}}' --overwrite
```
```terminal
oc annotate sa/default serviceaccounts.openshift.io/oauth-redirecturi.1=auth/callback/openshift --overwrite
```
## Step 5 - Run the App
```terminal
cd ~
```
```terminal
openshift-gochat-client -host :8080 -chatServer gochat-server.gochat-server.svc.cluster.local:8080 -templatePath go/src/github.com/kevensen/openshift-gochat-client/templates -logtostderr -insecure
```

## Step 6 - Access the App
Go back to the OpenShift WebUI and click on the "gochat" URL.

{{< panel_group >}}
{{% panel "Gochat Service Route - URL" %}}

<img src="../images/gochat_url.png" width="600" align="middle"/>

{{% /panel %}}
{{< /panel_group >}}

## Step 7 - Sign in to the App
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

## Step 8 - Test the App
Send a message!

## Step 9 - Logout
{{< panel_group >}}
{{% panel "Gochat Logout" %}}

<img src="../images/gochat_logout.png" width="600" align="middle"/>

{{% /panel %}}
{{< /panel_group >}}

## Step 10 - Quit the App
In the Wetty terminal **ctrl+c** to stop the server.

{{< importPartial "footer/footer.html" >}}