---
title: Lab 10 - Blue | Green Deployment Pipeline
workshops: openshift_v3_5_101
workshop_weight: 20
layout: lab
---

# Blue/Green deployments using Pipelines
In this lab we walk through creating a simple example of a CI/CD [pipeline][1] utlizing Jenkins, to automate a blue/green deployment strategy. The bluegreen-pipeline.yaml template contains a pipeline that demonstrates alternating blue/green deployments with a manual approval step. The template contains three routes, one main route, and 2 other routes; one prefixed by blue and the other one prefixed by green. Each time the pipeline is run, it will alternate between building the green or the blue service. You can verify the running code by browsing to the route that was just built. Once the deployment is approved, then the service that was just built becomes the active one.

## Before starting
Before we get started with the Blue/Green Deployment Pipeline lab, lets clean up some of the projects from the previous lab. 

```
$ oc delete all -l app=jenkins-ephemeral
$ oc delete all -l app=nodejs-helloworld-sample
```

## Lets deploy a set of applications using the import template function of OpenShift
The bluegreen-pipeline.yaml template contains a pipeline that demonstrates alternating blue/green deployments with a manual approval step.

You can deploy the entire set od resources using the import json/yaml feature within OpenShift

> <i class="fa fa-terminal"></i> Goto the terminal and type these commands:

```
$ oc new-app -f https://raw.githubusercontent.com/DLT-Solutions-JBoss/nodejs-ex/master/bluegreen-pipeline.yaml
```

## Review the results of the template processing
Wait for the "jenkins" application to become avialable before proceeding.


## Switch from Green to Blue
Now that we are satisfied with our change we can do the Green/Blue switch.  With OpenShift services and routes, this is super simple.  Follow the steps below to make the switch:

{{< panel_group >}}
{{% panel "CLI Steps" %}}
      
<blockquote>
<i class="fa fa-terminal"></i> Goto the terminal and type the following:
</blockquote>

```
$ oc edit route green
```

This will bring up the Route configuration yaml. Edit the element spec: to: name and change it's value from "green" to "blue".

{{% /panel %}}

{{% panel "Web Console Steps" %}}

<blockquote>
Click "Add to Project"
</blockquote>
<img src="../images/ocp-addToProjectButton.png" width="200"><br/>

<blockquote>
Click "Import JSON/YAML" tab and copy contents of https://raw.githubusercontent.com/DLT-Solutions-JBoss/nodejs-ex/master/bluegreen-pipeline.yaml opened in a separate browser tab.

</blockquote>
<img src="../images/ocp-lab-s2i-filternode.png" width="900"><br/>

<blockquote>
Scroll to the bottom and click "Create"
</blockquote>

>Navigate to the Pipelines (under Builds) view from the left-hand menu:

<img src="../images/ocp-lab-bluegreen-navtoroutes.png" width="900"><br/>

>In your Pipelines page, click on the "Start Pipeline" button on the right:

<img src="../images/ocp-lab-bluegreen-routesoverview.png" width="900">
<br/>

>You should see your pipline start to execute with a Build step:

<img src="../images/ocp-lab-bluegreen-routedetail.png" width="900"><br/>

>Edit the Route: select the name dropdown and change the value from "green" to "blue":

<img src="../images/ocp-lab-bluegreen-edit.png" width="900"><br/>
      
{{% /panel %}}
{{< /panel_group >}}

> This should be the result of your re-direction:

<img src="../images/ocp-lab-post-bluegreen-edit.png" width="900"><br/>

# Summary
Using pipelines for your applications provides visibility to your build, test, deploy executions and facilitates cooperation between various IT groups and can be used as a continuous improvement tool in order to create a higher quality software product and assist your agency in becoming a DevOps shop!

If you want to read more about Blue/Green check out [this post][2] with a longer description as well as links to additional resources.

[1]: https://jenkins.io/doc/book/pipeline/
[2]: http://martinfowler.com/bliki/BlueGreenDeployment.html

