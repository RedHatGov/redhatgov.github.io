---
title: Lab 12 - Blue | Green Deployment (Optional)
workshops: openshift_4_101_dynatrace
workshop_weight: 22
layout: lab
---

# Blue/Green deployments
When implementing continuous delivery for your software one very useful technique is called Blue/Green deployments.  It addresses the desire to minimize downtime during the release of a new version of an application to production.  Essentially, it involves running two production versions of your app side-by-side and then switching the routing from the last stable version to the new version once it is verified.  Using OpenShift, this can be very seamless because using containers we can easily and rapidly deploy a duplicate infrastructure to support alternate versions and modify routes as a service.  In this lab, we will walk through a simple Blue/Green workflow with an simple web application on OpenShift.

## Before starting
Before we get started with the Blue/Green deployment lab, lets clean up some of the projects from the previous lab. 

``` bash
$ oc delete all -l app=jenkins-ephemeral
$ oc delete project cicd-{{< span "userid" "YOUR#" >}}
```

## Lets deploy an application
To demonstrate Blue/Green deployments, we'll use a simple application that renders a colored box as an example. Using your GitHub account, please fork the following https://github.com/RedHatGov/openshift-workshops project.

You should be comfortable deploying an app at this point, but here are the steps anyway:

> <i class="fa fa-terminal"></i> Goto the terminal and type these commands:

``` bash
$ oc new-project bluegreen-{{<span2 "userid" "YOUR#" >}}
$ oc new-app --name=green https://github.com/your-github-uid-goes-here/openshift-workshops --context-dir=dc-metro-map
$ oc expose service green
```

Note that we exposed this application using a route named "green". Wait for the application to become available, then navigate to your application and validate it deployed correctly.

## Release a new version of our app and test it in the same environment
What we'll do next is create a new version of the application called "blue". The quickest way to make a change to the code is directly in the GitHub web interface. In GitHub, edit the dc-metro-map/views/dcmetro.jade file in your repo. 

<img src="../images/ocp-lab-bluegreen-editgithub.png" width="900"><br/>

We can change the text labels indicated by name of a color. If you want to change the label for the "Red Line", change line 22 from "Red Line" to  "Silver Line". These changes will be easily viewable on the main screen of the application. 

Use the same commands to deploy this new version of the app, but this time name the service "blue". No need to expose a new route -- we'll instead switch the "green" route to point to the "blue" service once we've verified it.

> <i class="fa fa-terminal"></i> Goto the terminal and type these commands:

``` bash
$ oc new-app --name=blue https://github.com/your-github-uid-goes-here/openshift-workshops --context-dir=dc-metro-map
```

Wait for the "blue" application to become avialable before proceeding.


## Switch from Green to Blue
Now that we are satisfied with our change we can do the Green/Blue switch.  With OpenShift services and routes, this is super simple.  Follow the steps below to make the switch:

{{< panel_group >}}
{{% panel "CLI Steps" %}}
      
<blockquote>
<i class="fa fa-terminal"></i> Goto the terminal and type the following:
</blockquote>

``` bash
$ oc edit route green
```

This will bring up the Route configuration yaml. Edit the element "spec:". On the "to:" "name:" line, change its value from "green" to "blue":

```bash
spec:
  host: green-bluegreen-{{< span "userid" "YOUR#" >}}.apps.alexocp43.redhatgov.io
  port:
    targetPort: 8080-tcp
  to:
    kind: Service
    name: blue
    weight: 100
  wildcardPolicy: None
```

{{% /panel %}}

{{% panel "Web Console Steps" %}}

> As "Administrator", in the "bluegreen-{{< span "userid" "YOUR#" >}}" project, navigate to "Routes", and select "green"

<img src="../images/ocp-lab-bluegreen-routesoverview.png" width="900">
<br/>

>In the Route detail page, click on Actions > Edit:

<img src="../images/ocp-lab-bluegreen-routedetail.png" width="200"><br/>

>Edit the Route: change the "spec:" -> "to:" section "name:" from "green" to "blue", and click "Save"

<img src="../images/ocp-lab-bluegreen-edit.png" width="700"><br/>
      
{{% /panel %}}
{{< /panel_group >}}


# Summary
Pretty easy, right?

If you want to read more about Blue/Green check out [this post][2] with a longer description as well as links to additional resources.

[1]: https://github.com/RedHatGov/openshift-workshops
[2]: http://martinfowler.com/bliki/BlueGreenDeployment.html

{{< importPartial "footer/footer.html" >}}
