---
title: Lab 2 - BYO Container
workshops: openshift_4_101
workshop_weight: 12
layout: lab
---

# Bring your own docker
It's easy to get started with OpenShift whether you're using our app templates or bringing your existing assets.  In this quick lab we will deploy an application using an exisiting container image.  OpenShift will create an image stream for the image as well as deploy and manage containers based on that image.  And we will dig into the details to show how all that works.

## Let's point OpenShift to an existing built container image

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
--> Found container image 8027e6d (2 months old) from Docker Hub for "sonatype/nexus:oss"         
                                                                                                  
    Red Hat Universal Base Image 7                                                                
    ------------------------------                                                                
    The Universal Base Image is designed and engineered to be the base layer for all of your conta
inerized applications, middleware and utilities. This base image is freely redistributable, but Re
d Hat only supports Red Hat technologies through subscriptions for Red Hat products. This image is
 maintained by Red Hat and updated regularly.                                                     
                                                                                                  
    Tags: base rhel7                                                                              
                                                                                                  
    * An image stream tag will be created as "nexus:oss" that will track this image               
    * This image will be deployed in deployment config "nexus"                                    
    * Port 8081/tcp will be load balanced by service "nexus"                                      
      * Other containers can access this service through the hostname "nexus"                     
    * This image declares volumes and will default to use non-persistent, host-local storage.     
      You can add persistent volumes later by running 'oc set volume dc/nexus --add ...'          
                                                                                                  
--> Creating resources ...                                                                        
    imagestream.image.openshift.io "nexus" created                                                
    deploymentconfig.apps.openshift.io "nexus" created                                            
    service "nexus" created                                                                       
--> Success                                                                                       
    Application is not exposed. You can expose services to the outside world by executing one or m
ore of the commands below:                                                                        
     'oc expose svc/nexus'                                                                        
    Run 'oc status' to view your app.  
```

<blockquote>
Now, let's create a route, so that you can get to the app:
</blockquote>

```bash
$ oc expose svc/nexus
```

{{% /panel %}}

{{% panel "Web Console Steps" %}}

<blockquote>
Switch to "Developer" mode, by clicking on the menu, in the top left corner, where it says "Administrator", and pick "Developer"
</blockquote>
<img src="../images/ocp-switch-developer.png" width="500"><br/>

<blockquote>
Click "+Add"
</blockquote>
<img src="../images/ocp-addToProjectButton.png" width="450"><br/>

<blockquote>
Click "Container Image", to add an existing image from the container registry
</blockquote>
<img src="../images/ocp-ContainerImageButton.png" width="300"><br/>

<blockquote>
Select the option for "Image name from external registry" and enter "sonatype/nexus:oss", then ensure that the image is validated.
</blockquote>
<img src="../images/ocp-nexus-imagename-expand.png" width="800"><br/>

<blockquote>
Enter the values shown, in the image above.
</blockquote>
<p>
<table>
<tr><td><b>Application Name</b></td><td>nexus-app</td></tr>
<tr><td><b>Name</b></td><td>nexus</td></tr>
<tr><td><b>Resources</b></td><td>Deployment Config</td></tr>
<tr><td><b>Create a route to the application</b></td><td>Checked</td></tr>
</table>
</p>

<blockquote>
Click "Create"
</blockquote>

{{% /panel %}}
{{< /panel_group >}}


## We can browse our project details with the command line
> <i class="fa fa-terminal"></i> Try typing the following to see what is available to 'get':

```bash
$ oc project demo-{{< span userid "YOUR#" >}}
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
Click on "Developer", in the top left corner, and change it to "Administrator"
</blockquote>
<img src="../images/ocp-menu-administrator.png" width="300"><br/>

<blockquote>
Click on "Builds", in the left-side menu, and then "Image Streams"
</blockquote>
<img src="../images/ocp-nexus-buildimages.png" width="227"><br/>

This shows a list of all image streams within the project.  

<blockquote>
Now click on the "nexus" image stream
</blockquote>

You should see something similar to this:

<img src="../images/ocp-nexus-is.png" width="600"><br/>

## Test out the nexus webapp

Change the context menu (the menu, in the top left, that contains "Administrator" and "Developer" back to "Developer", and click on the arrow, at the top right of the "nexus" thumbnail, to open the webapp's route.

<img src="../images/ocp-nexus-thumbnail.png" width="125"><br/>

You will get a new browser window or tab, containing the following:

<img src="../images/ocp-nexus-app.png" width="300"><br/>

Good work - this error is expected; since the nexus console is on /nexus

Go to this URL:

## {{< rhocpuri4app "http://" "nexus-demo-" "/nexus/" >}}

... to get the Nexus console.  Of course, we have not provided persistent storage; so, any and all work will be lost.

<img src="../images/ocp-nexus-app2.png" width="600"><br/>

## Let's clean this up

> <i class="fa fa-terminal"></i> Let's clean up all this to get ready for the next lab:

```bash
$ oc delete all --selector app=nexus
```


# Summary
In this lab, you've deployed an example container image, pulled from Quay.io, into a pod running in OpenShift.  You exposed a route for clients to access that service via their web browsers.  And you learned how to get and describe resources using the command line and the web console.  Hopefully, this basic lab also helped to get you familiar with using the CLI and navigating within the web console.

{{< importPartial "footer/footer.html" >}}
