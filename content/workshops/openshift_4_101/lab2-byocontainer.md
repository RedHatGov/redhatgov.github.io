---
title: Lab 2 - BYO Container
workshops: openshift_4_101
workshop_weight: 12
layout: lab
---

# Bring your own OCI image
It's easy to get started with OpenShift whether you're using our app templates or bringing your existing assets.  In this quick lab we will deploy an application using an exisiting container image.  OpenShift will create an image stream for the image as well as deploy and manage containers based on that image.  

## Let's point OpenShift to an existing built container image
Choose either to complete the steps via CLI or Web Console.<br>
Note: You can only choose one OR the other not both.<br>

{{< panel_group >}}
{{% panel "CLI Steps" %}}

Goto the terminal and type the following to create a new project:

<pre><code style="color:#FFFFFF">$ oc new-project demo-{{< span2 userid "YOUR#" >}}
Now using project "demo-{{< span2 userid "YOUR#" >}}" on server "https://172.30.0.1:443".

You can add applications to this project with the 'new-app' command. For example, try:

    oc new-app rails-postgresql-example

to build a new example application in Ruby. Or use kubectl to deploy a simple Kubernetes application:

    kubectl create deployment hello-node --image=k8s.gcr.io/serve_hostname
</code></pre>

<hr>
By default, create a new project will default you to "using" that project.  In the event that the project is already create, you get set the "using" option by type the following:

<pre><code style="color:#FFFFFF">$ oc project demo-{{< span2 userid "YOUR#" >}}
</code></pre>

<hr>
Now, let's launch a pre-existing container from a container registry.

<pre><code style="color:#FFFFFF">$ oc new-app sonatype/nexus:oss --as-deployment-config=true
</code></pre>

<hr>
The output should show something *similar* to below:

<pre><code style="color:#FFFFFF">--> Found container image 8027e6d (2 months old) from Docker Hub for "sonatype/nexus:oss"         
                                                                                                  
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
</code></pre>

<hr>
Now, let's create a route, so that you can get to the app:

<pre><code style="color:#FFFFFF">$ oc expose service/nexus --path=/nexus
</code></pre>

{{% /panel %}}

{{% panel "Web Console Steps" %}}

Ensure that you are in "Developer" mode, by clicking on the menu, in the top left corner under the logo and selecting "Developer"
<img src="../images/ocp-switch-developer.gif"><br><br>
<hr>

Create a new project by selecting the "Project:" drop down and selecting "Create project"<br>
Note: When prompted, ensure to create the project with the name demo-{{< span2 userid "YOUR#" >}}
<img src="../images/ocp-addToProjectButton.gif"><br>
<hr>

Click "+Add" and then "Container Image", to add an existing image from the container registry<br>
<img src="../images/ocp-ContainerImageButton.png" width="300"><br>
<hr>


Select the option for "Image name from external registry" and enter "sonatype/nexus:oss", then ensure that the image is validated.
<img src="../images/ocp-nexus-imagename-expand.png" width="800"><br/>
<hr>

Enter the values shown, in the image above.
<p>
<table>
<tr><td><b>Application Name</b></td><td>nexus-app</td></tr>
<tr><td><b>Name</b></td><td>nexus</td></tr>
<tr><td><b>Resources</b></td><td>Deployment Config</td></tr>
<tr><td><b>Create a route to the application</b></td><td>Checked</td></tr>
<tr><td colspan=2><b>Click "Routing"</b></td></tr>
<tr><td><b>Path</b></td><td>/nexus</td></tr>
</table>
</p>

<blockquote>
Click "Create"
</blockquote>

{{% /panel %}}
{{< /panel_group >}}

{{< importPartial "footer/footer.html" >}}
