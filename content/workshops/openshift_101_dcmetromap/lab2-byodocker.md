---
title: Lab 2 - BYO Docker
workshops: openshift_101_dcmetromap
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
```bash
$ oc new-app sonatype/nexus:oss
```

<blockquote>
The output should show something *similar* to below:
</blockquote>
```bash
--> Found Docker image adffc23 (13 days old) from Docker Hub for "sonatype/nexus:oss"
    * An image stream tag will be created as "nexus:oss" that will track this image
    * This image will be deployed in deployment config "nexus"
    * Port 8081/tcp will be load balanced by service "nexus"
      * Other containers can access this service through the hostname "nexus"
    * This image declares volumes and will default to use non-persistent, host-local storage.
      You can add persistent volumes later by running 'volume dc/nexus --add ...'
--> Creating resources ...
    imagestream.image.openshift.io "nexus" created
    deploymentconfig.apps.openshift.io "nexus" created
    service "nexus" created
--> Success
    Application is not exposed. You can expose services to the outside world by executing one or more of the commands below:
     'oc expose svc/nexus' 
    Run 'oc status' to view your app.
```

{{% /panel %}}

{{% panel "Web Console Steps" %}}

<blockquote>
Click "Add to Project"
</blockquote>
<img src="../images/ocp-addToProjectButton.png" width="150"><br/>

<blockquote>
Select the "Deploy Image" option from the drop down
</blockquote>
<img src="../images/ocp-nexus-deploy-image.png" width="200"><br/>

<blockquote>
Select the option for "Image Name" and enter "sonatype/nexus:oss", then click the magnifying glass to the far right to search for the image.
</blockquote>
<img src="../images/ocp-nexus-imagename-expand.png" width="600"><br/>

<blockquote>
Observe default values that are populated in the search results
</blockquote>
<img src="../images/ocp-nexus-create-1.png" width="600"><br/>

<blockquote>
Click "Deploy" then click "Close"
</blockquote>

{{% /panel %}}
{{< /panel_group >}}


## We can browse our project details with the command line
> <i class="fa fa-terminal"></i> Try typing the following to see what is available to 'get':

```bash
$ oc get all
```

> <i class="fa fa-terminal"></i> Now let's look at what our image stream has in it:

```bash
$ oc get is
```
```bash
$ oc describe is/nexus
```

{{% alert info %}}
An image stream can be used to automatically perform an action, such as updating a deployment, when a new image, in our case a new version of the nexus image, is created.
{{% /alert %}}

> <i class="fa fa-terminal"></i> The app is running in a pod, let's look at that:

```bash
$ oc describe pods
```

## We can see those details using the web console too
Let's look at the image stream.  

<blockquote>
Click on "Builds -> Images"
</blockquote>

<img src="../images/ocp-nexus-buildimages.png" width="200"><br/>

This shows a list of all image streams within the project.  

<blockquote>
Now click on the "nexus" image stream
</blockquote>

You should see something similar to this:

<img src="../images/ocp-nexus-is.png" width="600"><br/>


## Does this nexus do anything?
Good catch, your service is running but there is no way for users to access it yet.  We can fix that from the web console or the command line. You decide which you'd rather do from the steps below.

{{< panel_group >}}

{{% panel "CLI Steps" %}}

<blockquote>
<i class="fa fa-terminal"></i> In the command line type this:
</blockquote>

```bash
$ oc expose service nexus
```
{{% /panel %}}

{{% panel "Web Console Steps" %}}

<blockquote>
"Overview"
</blockquote>

<img src="../images/ocp-nexus-overview.png" width="400"><br/>

<blockquote>
Select the arrow '>' next to 'nexus, #' 
</blockquote>

<img src="../images/ocp-nexus-arrow1.png" width="200"><br/>
<img src="../images/ocp-nexus-arrow2.png" width="200"><br/>

<blockquote>
To get to this view
</blockquote>

<img src="../images/ocp-nexus-noroute.png" width="600"><br/>

<p>Notice there is no exposed route </p>

<blockquote>
Click on the "Create Route" link
</blockquote>

<img src="../images/ocp-nexus-createRoute.png" width="600"><br/>

<p>This is where you could specify route parameters, but we will just use the defaults.</p>

<blockquote>
Click "Create"
</blockquote>

{{% /panel %}}
{{< /panel_group >}}

{{% alert info %}}
You can also create secured HTTPS routes, but that's a topic for a more advanced workshop
{{% /alert %}}

## Test out the nexus webapp
Notice that in the web console overview, you now have a URL in the service box.  There is no database setup, but you can see the webapp running by clicking the route you just exposed.

> Click the link in the service box. You should see:

<img src="../images/ocp-nexus-app.png" width="300"><br/>


## Good work - this error is expected; since the nexus console is on /nexus
Go to URL: {{< rhocpuri4app " http://" "nexus-demo-" "/nexus/" >}} to get the Nexus console.  Of course, we have not provided persistent storage; so, any and all work will be lost.

<img src="../images/ocp-nexus-app2.png" width="600"><br/>

## Let's clean this up

> <i class="fa fa-terminal"></i> Let's clean up all this to get ready for the next lab:

```bash
$ oc delete all --all
```


# Summary
In this lab you've deployed an example docker image, pulled from docker hub, into a pod running in OpenShift.  You exposed a route for clients to access that service via thier web browsers.  And you learned how to get and describe resources using the command line and the web console.  Hopefully, this basic lab also helped to get you familiar with using the CLI and navigating within the web console.

{{< importPartial "footer/footer.html" >}}
