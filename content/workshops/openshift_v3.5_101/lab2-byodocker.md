---
title: Lab 2 - BYO Docker
workshops: openshift_3.5_101
workshop_weight: 12
layout: lab
---

# Bring your own docker
It's easy to get started with OpenShift whether you're using our app templates or bringing your existing docker assets.  In this quick lab we will deploy an application using an exisiting docker image.  OpenShift will create an image stream for the image as well as deploy and manage containers based on that image.  And we will dig into the details to show how all that works.

## Let's point OpenShift to an existing built docker image

{{< panel_group >}}
{{% panel "CLI Steps" %}}

<blockquote>
<i class="fa fa-terminal"></i> Goto the terminal and type the following:
</blockquote>
```
$ oc new-app kubernetes/guestbook
```

<blockquote>
The output should show something *similar* to below:
</blockquote>
```
--> Found docker image a49fe18 (17 months old) from docker Hub for "kubernetes/guestbook"
    * An image stream will be created as "guestbook:latest" that will track this image
    * This image will be deployed in deployment config "guestbook"
    * Port 3000/tcp will be load balanced by service "guestbook"
--> Creating resources with label app=guestbook ...
    ImageStream "guestbook" created
    DeploymentConfig "guestbook" created
    Service "guestbook" created
--> Success
    Run 'oc status' to view your app.
```

{{% /panel %}}

{{% panel "Web Console Steps" %}}

<blockquote>
Click "Add to Project"
</blockquote>
<img src="/static/openshift_101_dcmetromap/ocp-addToProjectButton.png" width="200"><br/>

<blockquote>
Select the tab for "Deploy Image" from the top options
</blockquote>
<img src="/static/openshift_101_dcmetromap/ocp-guestbook-deploy-image.png" width="400"><br/>

<blockquote>
Select the option for "Image Name" and enter "kubernetes/guestbook", then click the magnifying glass to the far right to search for the image.
</blockquote>
<img src="/static/openshift_101_dcmetromap/ocp-guestbook-imagename-expand.png" width="600"><br/>

<blockquote>
Observe default values that are populated in the search results
</blockquote>
<img src="/static/openshift_101_dcmetromap/ocp-guestbook-create-1.png" width="600"><br/>
<img src="/static/openshift_101_dcmetromap/ocp-guestbook-create-2.png" width="600"><br/>

<blockquote>
Scroll to the bottom and click "Create"
</blockquote>

{{% /panel %}}
{{< /panel_group >}}


## We can browse our project details with the command line
> <i class="fa fa-terminal"></i> Try typing the following to see what is available to 'get':

```
$ oc get
```

> <i class="fa fa-terminal"></i> Now let's look at what our image stream has in it:

```
$ oc get is
```
```
$ oc describe is/guestbook
```

{{% alert info %}}
An image stream can be used to automatically perform an action, such as updating a deployment, when a new image, in our case a new version of the guestbook image, is created.
{{% /alert %}}

> <i class="fa fa-terminal"></i> The app is running in a pod, let's look at that:

```
$ oc describe pods
```

## We can see those details using the web console too
Let's look at the image stream.  

<blockquote>
Click on "Builds -> Images"
</blockquote>

This shows a list of all image streams within the project.  

<blockquote>
Now click on the guestbook image stream
</blockquote>

You should see something similar to this:

<img src="/static/openshift_101_dcmetromap/ocp-guestbook-is.png" width="600"><br/>


## Does this guestbook do anything?
Good catch, your service is running but there is no way for users to access it yet.  We can fix that from the web console or the command line. You decide which you'd rather do from the steps below.

{{< panel_group >}}

{{% panel "CLI Steps" %}}

<blockquote>
<i class="fa fa-terminal"></i> In the command line type this:
</blockquote>

```
$ oc expose service guestbook
```
{{% /panel %}}

{{% panel "Web Console Steps" %}}

<blockquote>
To expose via the web console, click on "Overview" to get to this view
</blockquote>
<img src="/static/openshift_101_dcmetromap/ocp-guestbook-noroute.png" width="600"><br/>

<p>Notice there is no exposed route </p>

<blockquote>
Click on the "Create Route" link
</blockquote>

<img src="/static/openshift_101_dcmetromap/ocp-guestbook-createRoute.png" width="600"><br/>

<p>This is where you could specify route parameters, but we will just use the defaults.</p>

<blockquote>
Click "Create"
</blockquote>

{{% /panel %}}
{{< /panel_group >}}

{{% alert info %}}
You can also create secured HTTPS routes, but that's a topic for a more advanced workshop
{{% /alert %}}

## Test out the guestbook webapp
Notice that in the web console overview, you now have a URL in the service box.  There is no database setup, but you can see the webapp running by clicking the route you just exposed.

> Click the link in the service box. You should see:

<img src="/static/openshift_101_dcmetromap/ocp-guestbook-app.png" width="600"><br/>


## Good work, let's clean this up
> <i class="fa fa-terminal"></i> Let's clean up all this to get ready for the next lab:

```
$ oc delete all --all
```


# Summary
In this lab you've deployed an example docker image, pulled from docker hub, into a pod running in OpenShift.  You exposed a route for clients to access that service via thier web browsers.  And you learned how to get and describe resources using the command line and the web console.  Hopefully, this basic lab also helped to get you familiar with using the CLI and navigating within the web console.
