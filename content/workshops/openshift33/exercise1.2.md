---
title: Exercise 1.2 - Deploying an App with S2I
workshops: openshift33
workshop_weight: 120
layout: lab
---

### Source to Image (S2I)
One of the useful components of OpenShift is its source-to-image capability.  S2I is a framework that makes it easy to turn your source code into runnable images.  The main advantage of using S2I for building reproducible Docker images is the ease of use for developers.  You'll see just how simple it can be in this lab.

### Let's build a node.js web server using S2I
We can do this either via the command line (CLI) or the web console.  You decide which you'd rather do and follow the steps below:

{{< panel_group >}}
{{% panel "CLI Steps" %}}

<i class="fa fa-terminal"></i> Goto the terminal and type the following:

```bash
oc new-app --name=dc-metro-map \
           https://github.com/dudash/openshift-workshops.git \
           --context-dir=dc-metro-map

oc expose service dc-metro-map
```

<!-- :information_source: OpenShift automatically detected the source code type and selected the nodejs builder image -->
**INFO:** You can also create secured HTTPS routes, but that's an advanced topic for a later lab

{{% /panel %}}
{{% panel "Web Console Steps" %}}

<blockquote>Click "Add to Project"</blockquote>
<p><img title="OpenShift Add to Project" src="../images/ose-lab-s2i-addbutton.png" width="100"/></p>

<blockquote>Click "Browse" and filter for nodejs, then click the nodejs:0.10 builder image</blockquote>
<p><img title="OpenShift Add Node.js" src="../images/ose-lab-s2i-filternode.png" width="600"/></p>

<blockquote>Fill out the boxes to look as follows:</blockquote>
<p><img title="OpenShift Add to Project" src="../images/ose-lab-s2i-addtoproject.png" width="600"/></p>

<!-- :notebook: You will need to click to expand the "advanced options"<br/><br/> -->
<!-- TODO: Note not bolded and '*' printed -->
**NOTE:** You will need to click to expand the "advanced options"
<p><p>

The GitHub repository URL is: <a href='https://github.com/dudash/openshift-workshops.git'>https://github.com/dudash/openshift-workshops.git</a><br/><br/>
The GitHub context-dir is: <b>/dc-metro-map</b><br/><br/>

<blockquote>Scroll to the bottom and click "Create"</blockquote>

{{% /panel %}}
{{< /panel_group >}}


### Check out the build details
We can see the details of what the S2I builder did.  This can be helpful to diagnose issues if builds are failing.

<!-- :thought_balloon: For a node.js app, running "npm shrinkwrap" is a good practice to perform on your branch before releasing changes that you plan to build/deploy as an image with S2I. -->
**NOTE:** For a node.js app, running "npm shrinkwrap" is a good practice to perform on your branch before releasing changes that you plan to build/deploy as an image with S2I.

{{< panel_group >}}
{{% panel "CLI Steps" %}}

<i class="fa fa-terminal"></i> Goto the terminal and type the following:

```bash
oc get builds
```

In the output, note the name of your build and use it to see the logs with:

```bash
oc logs builds/[BUILD_NAME]
```

The console will print out the full log for your build.  Note, you could pipe this to more or less for easier viewing in the CLI.

{{% /panel %}}
{{% panel "Web Console Steps" %}}

<blockquote>Hover over Browse and then click on "Builds"</blockquote>
<p><img title="OpenShift Builds Overview" src="../images/ose-lab-s2i-builds.png" width="300"/></p>

<blockquote>Click on the "dc-metro-map" link</blockquote>
<p><img title="OpenShift DC Metro Map Application" src="../images/ose-lab-s2i-metromapbuild.png" width="300"/></p>

<blockquote>Click on the "View Log" tab to see the details of your latest build</blockquote>
<p><img title="OpenShift DC Metro Map Application Log View" src="../images/ose-lab-s2i-metromapbuilds.png" width="500"/></p>

<blockquote>You should see a log output similar to the one below:</blockquote>
<p><img title="OpenShift DC Metro Map Application Build Log" src="../images/ose-lab-s2i-metromapbuildlog.png" width="500"/></p>

{{% /panel %}}
{{< /panel_group >}}

### See the app in action
Let's see this app in action!

{{< panel_group >}}
{{% panel "CLI Steps" %}}

<blockquote>
<i class="fa fa-terminal"></i> Goto the terminal and type the following:
</blockquote>

```bash
oc get routes
```

<blockquote>Copy the HOST/PORT and paste into your favorite web browser</blockquote>

{{% /panel %}}
{{% panel "Web Console Steps" %}}

<blockquote>Click on Overview</blockquote>
<p><img title="OpenShift DC Metro Map Application Overview" src="../images/ose-lab-s2i-overview.png" width="100"/></p>

<blockquote>Click the URL that is listed in the dc-metro-map service</blockquote>
<p><img title="OpenShift DC Metro Map Application Service" src="../images/ose-lab-s2i-dcmetromapsvc.png" width="500"/></p>

{{% /panel %}}
{{< /panel_group >}}

The app should look like this in your web browser:
<p><img title="OpenShift DC Metro Map Application" src="../images/ose-lab-s2i-apprunning.png" width="500"/></p>

Clicking the checkboxes will toggle on/off the individual metro stations on each colored line.  A numbered icon indicates there is more than one metro station in that area and they have been consolidated - click the number or zoom in to see more.

### Summary
In this lab we deployed a sample application using source to image.  This process built our code and wrapped that in a Docker image.  It then deployed the image into our OpenShift platform in a pod and exposed a route to allow outside web traffic to access our application.  In the next lab we will look at some details of this app's deployment and make some changes to see how OpenShift can help to automate our development processes.

[1]: https://docs.openshift.com/container-platform/3.3/dev_guide/new_app.html
