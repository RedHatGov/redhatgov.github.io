---
title: Lab 7 - Developing and Managing Your Application
workshops: openshift_4_101_dynatrace
workshop_weight: 17
layout: lab
---

# Developing and managing an application in OpenShift
In this lab we will explore some of the common activities undertaken by developers working in OpenShift.  You will become familiar with how to use environment variables, secrets, build configurations, and more.  Let's look at some of the basic things a developer might care about for a deployed app.

## Setup
From the previous lab you should have the DC Metro Maps web app running in OpenShift.  

{{% alert warning %}}
Only if you don't already have it running, add it with the following steps.
{{% /alert %}}

> <i class="fa fa-terminal"></i> Goto the terminal and type these commands:

```bash
$ oc new-app --name=dc-metro-map https://github.com/RedHatGov/openshift-workshops.git --context-dir=dc-metro-map
$ oc expose service dc-metro-map
```

## See the app in action and inspect some details
Unlike in previous versions of OpenShift, there is no more ambiguity or confusion about where the app came from.  OpenShift provides traceability for your running deployment, back to the container image, and the registry that it came from. Additionally, images built by OpenShift are traceable back to the exact [branch](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/about-branches) and [commit](https://help.github.com/en/github/getting-started-with-github/github-glossary#commit). Let's take a look at that!

{{< panel_group >}}
{{% panel "CLI Steps" %}}

<blockquote>
<i class="fa fa-terminal"></i> Goto the terminal and type the following:
</blockquote>

```bash
$ oc status
```

This is going to show the status of your current project.  In this case it will show the dc-metro-map service (svc) with a nested deployment config(also called a "DC") along with some more info that you can ignore for now.  

<blockquote>
<i class="fa fa-info-circle"></i>  A deployment in OpenShift is a replication controller based on a user defined template called a deployment configuration <br/>
</blockquote>

The dc provides us details we care about to see where our application image comes from, so let's check it out in more detail.

<blockquote>
<i class="fa fa-terminal"></i> Type the following to find out more about our dc:
</blockquote>

```bash
$ oc describe deploymentconfig/dc-metro-map
```

Notice under the template section it lists the containers it wants to deploy along with the path to the container image.

<blockquote>
<i class="fa fa-info-circle"></i> There are a few other ways you could get to this information.  If you are feeling adventurous, you might also want to try to:
</blockquote>

- describe the replication controller
    - ```oc describe rc -l app=dc-metro-map```
- describe the image stream
    - ```oc describe is -l app=dc-metro-map```
- describe the running pods
    - ```oc describe pod```

Because we built this app using S2I, we get to see the details about the build - including the container image that was used for building the source code.  So let's find out where the image came from.  Here are the steps to get more information about the build configuration (bc) and the builds themselves.

<blockquote>
<i class="fa fa-terminal"></i> Type the following to find out more about our bc:
</blockquote>

```bash
$ oc describe bc/dc-metro-map
```

Notice the information about the configuration of how this app gets built.  In particular look at the github URL, the webhooks you can use to automatically trigger a new build, the docker image where the build runs inside of, and the builds that have been completed.  New let's look at one of those builds.

<blockquote>
<i class="fa fa-terminal"></i> Type the following:
</blockquote>
```bash
$ oc describe build/dc-metro-map-1
```

This shows us even more about the deployed container's build and source code, including exact commit information, for this build.  We can also see the commit's author, and the commit message.  You can inspect the code by opening a web browser and pointing it to a specific commit, like this:

https://github.com/RedHatGov/redhatgov.github.io/commit/2d5078cc5bbdf3cf63c5ab15e1628f30b3c89954

{{% /panel %}}

{{% panel "Web Console Steps" %}}

<blockquote>
Change modes to "Administrator", and then click on "Workloads", and "Deployment Configs".
</blockquote>
<img src="../images/ocp-lab-devman-dc.png" width="500"><br/>

<blockquote>
Click on "dc-metro-map", under "Name", and check out the details of the deployment
</blockquote>
<img src="../images/ocp-lab-devman-deployment-shortcut.png" width="700"><br/>

<blockquote>
Within the deployment for the dc-metro-map is a container summary that shows the detailed registry, container reference, and hash information, for the container that was deployed.
</blockquote>
<img src="../images/ocp-lab-devman-imageGuid.png" width="600"><br/>

<blockquote>
Click on "Builds", and then "Image Streams", in the left-side menu.
</blockquote>
<img src="../images/ocp-BuildsImageStreamsButton.png" width="300"><br/>

<blockquote>
Click on the "dc-metro-map" image stream, to see its details.
</blockquote>
<img src="../images/ocp-lab-devman-DCMetroMapIS.png" width="600"><br/>

<blockquote>
You should see something like what is shown, below.
</blockquote>
<img src="../images/ocp-lab-devman-DCMetroMapIS-Details.png" width="600"><br/>

<blockquote>
Click "Builds" and then "Builds", in the left-side menu, to get back to the build summary
</blockquote>
<img src="../images/ocp-builds-builds.png" width="300"><br/>

<blockquote>
Click "dc-metro-map-1" to see the build details
</blockquote>
<img src="../images/ocp-lab-buildsnoone.png" width="600"><br/>

<blockquote>
Because we built this app using S2I, we get to see the details about the build - including the container image that was used for building the source code.  Note that you can kick-off a rebuild here if something went wrong with the initial build and you'd like to attempt it again.<br/>
<br/>
Notice that, in the "Git Commit" section, you can see the comment from the last commit when the build was started, and you can see the that commit's author.
</blockquote>
<img src="../images/ocp-lab-devman-commitmsg.png" width="400"><br/>

{{% /panel %}}
{{< /panel_group >}}


## Pod logs
In the S2I lab we looked at a build log to inspect the process of turning source code into an image.  Now let's inspect the log for a running pod - in particular let's see the web application's logs.

{{< panel_group >}}
{{% panel "CLI Steps" %}}

<blockquote>
<i class="fa fa-terminal"></i> Goto the terminal and type the following:
</blockquote>

```bash
$ oc get pods
```

This is going to show basic details for all pods in this project (including the builders).  Let's look at the log for the pod running our application.  Look for the POD NAME that that is "Running" you will use it below.

<blockquote>
<i class="fa fa-terminal"></i> Goto the terminal and type the following (replacing the POD ID with your pod's ID):
</blockquote>

```bash
$ oc logs [POD NAME]
```

You will see in the output details of your app starting up and any status messages it has reported since it started.

<blockquote>
<i class="fa fa-info-circle"></i> You can see more details about the pod itself with 'oc describe pod/<POD NAME>'
</blockquote>

{{% /panel %}}

{{% panel "Web Console Steps" %}}

<blockquote>
Click on "Workloads" and then click on "Pods"
</blockquote>
<img src="../images/ocp-lab-devman-apppods.png" width="300"><br/>

<blockquote>
This is going to show basic details for all pods in this project (including the builders).
</blockquote>
<img src="../images/ocp-lab-devman-pods.png" width="600"><br/>

<blockquote>
Next let's look at the log for the pod running our application.
<br/>
Click the pod that starts with "dc-metro-map-"
<br/>
Here you see the status details of your pod as well as its configuration.  Take a minute here and look at what details are available.
</blockquote>
<img src="../images/ocp-lab-devman-poddetails.png" width="600"><br/>

<blockquote>
Click the "Logs" button
</blockquote>
<img src="../images/ocp-lab-devman-podslogs.png" width="600"><br/>
Now you can see, in the output window, the details of your app starting up, and any status messages that it has reported since it started.

{{% /panel %}}
{{< /panel_group >}}

## How about we set some environment variables?
Whether it's a database name or a configuration variable, most applications make use of environment variables.  It's best not to bake these into your containers because they do change and you don't want to rebuild an image just to change an environment variable.  Good news!  You don't have to.  OpenShift let's you specify environment variables in your deployment configuration and they get passed along through the pod to the container.  Let's try doing that.

{{< panel_group >}}
{{% panel "CLI Steps" %}}

Let's have a little fun.  The app has some easter eggs that get triggered when certain environment variables are set to 'true'.
<blockquote>
<i class="fa fa-terminal"></i> Goto the terminal and type the following:
</blockquote>

```bash
$ oc set env deploymentconfig/dc-metro-map -e BEERME=true
```

```bash
$ oc get pods -w
```

Due to the deployment config strategy being set to "Rolling" and the "ConfigChange" trigger being set, OpenShift auto deployed a new pod as soon as you updated the environment variable.  If you were quick enough, you might have seen this happening, with the "oc get pods -w" command

<blockquote>
<i class="fa fa-terminal"></i> Type Ctrl+C to stop watching the pods
</blockquote>

<blockquote>
<i class="fa fa-info-circle"></i> You can set environment variables, across all deployment configurations, with 'dc --all', instead of specifying a specific DC.
</blockquote>

{{% /panel %}}

{{% panel "Web Console Steps" %}}

<blockquote>
Click on "Workloads", and last, click on "Deployment Configs", in the left-side menu.
</blockquote>
This is going to show basic details for all build configurations in this project

<blockquote>
Click the "dc-metro-map" build config.
</blockquote>

<blockquote>
Click the "Environment" tab next to the "Pods" tab .
</blockquote>
<img src="../images/ocp-lab-devman-deploymentconfigdetails-config.png" width="600"><br/>
This opens up a tab with the environment variables for this deployment config.

<blockquote>
Add an environment variable with the name BEERME and a value of 'true'
</blockquote>
<img src="../images/ocp-lab-devman-deployconfigdetails-populated.png" width="600">
<br/>

<blockquote>
Click "Workloads", and then "Pods", from the left-side menu.
<br/>
If you are quick enough, you will see a new pod spin up, and the old pod spin down.  This is due to the deployment config strategy being set to "Rolling", and having a "ConfigChange" trigger. Thus, OpenShift auto deployed a new pod as soon as you updated with the environment variable.
</blockquote>
<img src="../images/ocp-lab-devman-BuildRunning.png" width="600">

{{% /panel %}}
{{< /panel_group >}}

With the new environment variables set the app should look like this in your web browser (with beers instead of busses):

<img src="../images/ocp-lab-devman-beerme.png" width="900"><br/>


## What about passwords and private keys?
Environment variables are great, but sometimes we don't want sensitive data exposed in the environment.  We will get into using **secrets** later when you do the lab: Keep it Secret, Keep it Safe


## Getting into a pod
There are situations when you might want to jump into a running pod, and OpenShift lets you do that pretty easily.  We set some environment variables, in this lab, so let's jump onto our pod to inspect them.  

{{< panel_group >}}
{{% panel "CLI Steps" %}}

<blockquote>
<i class="fa fa-terminal"></i> Goto the terminal and type the following:
</blockquote>

```bash
$ oc get pods
```

Find the pod name for your Running pod

```bash
$ oc exec -it [POD NAME] /bin/bash
```
 
You are now interactively attached to the container in your pod.  Let's look for the environment variables we set:

```bash
$ env | grep BEER
```

That should return the **BEERME=true** matching the value that we set in the deployment config.

```bash
$ exit
```

{{% /panel %}}

{{% panel "Web Console Steps" %}}

<blockquote>
Click on "Workloads" and then click on "Pods"
</blockquote>

<blockquote>
Click the pod that starts with "dc-metro-map-" and has a status of Running
</blockquote>

<blockquote>
Click the "Terminal" button
</blockquote>
<img src="../images/ocp-lab-devman-terminal.png" width="600"><br/>

## Let's look for the environment variables we set

<blockquote>
Inside the web page's terminal type this:
</blockquote>
```bash
$ env | grep BEER
```

That should return **BEERME=true**, matching the value that we set in the deployment config.

{{% /panel %}}
{{< /panel_group >}}

## Good work, let's clean this up
> <i class="fa fa-terminal"></i> Let's clean up all this to get ready for the next lab:

```bash
$ oc delete all -l app=dc-metro-map
$ oc delete secrets dc-metro-map-generic-webhook-secret dc-metro-map-github-webhook-secret    
```
  
# Summary
In this lab you've seen how to trace running software back to its roots, how to see details on the pods running your software, how to update deployment configurations, how to inspect logs files, how to set environment variables consistently across your environment, and how to interactively attach to running containers.  All these things should come in handy for any developer working in an OpenShift platform.

To dig deeper into the details behind the steps you performed in this lab, check out the OpenShift [developer's guide][1].

[1]: https://docs.openshift.com/container-platform/3.4/dev_guide/index.html

{{< importPartial "footer/footer.html" >}}
