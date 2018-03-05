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
## Step 2 - Download the App
```terminal
go get github.com/kevensen/openshift-gochat-client
```
## Step 3 - Get Your OpenShift Token
You'll need this in step 5.
```terminal
oc whoami -t
```
## Step 4 - Run the App
```terminal
openshift-gochat-client -host :8080 -chatServer gochat-server.gochat-server.svc.cluster.local:8080 -templatePath go/src/github.com/kevensen/openshift-gochat-client/templates -logtostderr
```
## Step 5 - Access the App
Go back to the OpenShift WebUI and click on the "gochat" URL.

{{< panel_group >}}
{{% panel "Gochat Service Route - URL" %}}

<img src="../images/gochat_url.png" width="600" align="middle"/>

{{% /panel %}}
{{< /panel_group >}}

## Step 6 - Sign in to the App
Log in to the app with your OpenShift token.

{{< panel_group >}}
{{% panel "Gochat Signin" %}}

<img src="../images/gochat_signin.png" width="600" align="middle"/>

{{% /panel %}}
{{< /panel_group >}}

## Step 7 - Test the App
Send a message!

## Step 8 - Logout
{{< panel_group >}}
{{% panel "Gochat Logout" %}}

<img src="../images/gochat_logout.png" width="600" align="middle"/>

{{% /panel %}}
{{< /panel_group >}}

## Step 9 - Quit the App
In the Wetty terminal **ctrl+c** to stop the server.