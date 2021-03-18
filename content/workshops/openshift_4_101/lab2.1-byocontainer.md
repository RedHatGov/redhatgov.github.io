---
title: Lab 2.1 - Reviewing container details
workshops: openshift_4_101
workshop_weight: 12
layout: lab
---

## Now that we have a running container, we can browse our project details with the command line
``
{{< urishortfqdn "https://" "console-openshift-console.apps" "/terminal" >}}
``

> <i class="fa fa-terminal"></i> Try typing the following to see what is available to 'get':

```bash
$ oc project demo-{{< span2 userid "YOUR#" >}}
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
``
{{< urishortfqdn "https://" "console-openshift-console.apps" >}}
``

Let's look at the image stream.  

<blockquote>
Click on "Developer", in the top left corner, and change it to "Administrator"
</blockquote>
<img src="../images/ocp-menu-administrator.gif"><br>

<blockquote>
Click on "Builds", in the left-side menu, then "Image Streams", and then click on nexus
</blockquote>

You should see something similar to this:

<img src="../images/ocp-nexus-is.png" width="800"><br/>

## Test out the nexus webapp

Change the context menu (the menu, in the top left, that contains "Administrator" and "Developer" back to "Developer", and click on the arrow, at the top right of the "nexus" thumbnail, to open the webapp's route.

<img src="../images/ocp-nexus-thumbnail.png" width="125"><br/>

<img src="../images/ocp-nexus-app2.png" width="600"><br/>

## Troubleshooting

If you get the following when attempting to browse the route ...<br>
<img src="../images/ocp-nexus-app.png" width="300"><br/>
Go to this URL: <br>
`
{{< rhocpuri4app "http://" "nexus-demo-" "/nexus/" >}}
`
<br>
This error means you missed a step above to set the path; however, the container is running ... 


{{< importPartial "footer/footer.html" >}}
