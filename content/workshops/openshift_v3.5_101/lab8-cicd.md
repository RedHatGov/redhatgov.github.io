---
title: Lab 8 - CI / CD Pipeline
workshops: openshift_3.5_101
workshop_weight: 17
layout: lab
---

# CI/CD Defined
In modern software projects many teams utilize the concept of Continuous Integration (CI) and Continuous Delivery (CD). By setting up a tool chain that continuously builds, tests, and stages software releases a team can ensure that their product can be reliably released at any time. OpenShift can be an enabler in the creation and management of this tool chain.

In this lab we walk through creating a simple example of a CI/CD [pipeline][1] utlizing Jenkins, all running on top of OpenShift! The Jenkins job will trigger OpenShift to build and deploy a test version of the application, validate that the deployment works, and then tag the test version into production.

## Create a new project
Create a new project named “cicd”.

{{< panel_group >}}

{{% panel "CLI Steps" %}}

```
$ oc new-project cicd
```
{{% /panel %}}

{{% panel "Web Console Steps" %}}

<blockquote>
Browse to original landing page, and click "New Project".
</blockquote>
<img src="/static/openshift_101_dcmetromap/ocp-lab-cicd-new-project.png" width="200"><br/>

<blockquote>
Fill in the Name and Display Name of the project as "cicd" and click "Create"
</blockquote>
<img src="/static/openshift_101_dcmetromap/ocp-lab-cicd-new-project-detail.png" width="600"><br/>
{{% /panel %}}

{{< /panel_group >}}

## Use the cicd project

```
$ oc project cicd
```

## Instantiate a Jenkins server in your project

{{< panel_group >}}

{{% panel "CLI Steps" %}}

```
$ oc new-app jenkins-ephemeral
```
{{% /panel %}}

{{% panel "Web Console Steps" %}}

<blockquote>
Click "Add to Project", select "Browse Catalog" tab and filter on "jenkins". Then select "Jenkins (Ephemeral)".
</blockquote>

<img src="/static/openshift_101_dcmetromap/ocp-lab-cicd-jenkins-instantiate.png" width="900"><br/>

<blockquote>
Scroll to the bottom of this page and click "Create"
</blockquote>

<img src="/static/openshift_101_dcmetromap/ocp-lab-cicd-jenkins-create-1.png" width="900"><br/>

<blockquote>
Select "Continue to overview" to display the following overview page.
</blockquote>

<img src="/static/openshift_101_dcmetromap/ocp-lab-cicd-jenkins-overview.png" width="900"><br/>

{{% /panel %}}

{{< /panel_group >}}

## Create a sample application configuration

Use the "oc new-app" command to create a simple nodejs application from a template file:

```
$ oc new-app -f https://raw.githubusercontent.com/openshift/origin/master/examples/jenkins/application-template.json
```
> Click on "Overview" within the OpenShift console to display the sample application configuration

<img src="/static/openshift_101_dcmetromap/ocp-lab-cicd-app-create.png" width="900"><br/>

## Manage and view a Jenkins build

> Access Jenkins

{{< panel_group >}}

{{% panel "CLI Steps" %}}

<blockquote>
<i class="fa fa-terminal"></i> Get the route to the Jenkins server
</blockquote>

```
$ oc get route
NAME       HOST/PORT                            PATH      SERVICES   PORT      TERMINATION     WILDCARD
frontend   frontend-cicd.192.168.42.27.xip.io             frontend   <all>     edge            None
jenkins    jenkins-cicd.192.168.42.27.xip.io              jenkins    <all>     edge/Redirect   None
```
Use Jenkins HOST/PORT to access through web browser
{{% /panel %}}

{{% panel "Web Console Steps" %}}

<blockquote>
Click the URL that is listed in the jenkins header
</blockquote>

<img src="/static/openshift_101_dcmetromap/ocp-lab-cicd-jenkins-overview.png" width="900"><br/>

{{% /panel %}}

{{< /panel_group >}}

> Select "Login with OpenShift" from Jenkins login page

<img src="/static/openshift_101_dcmetromap/ocp-lab-cicd-jenkins-login-1.png" width="400">
</br>

The OpenShift login page is displayed in a new browser tab.

> Login with your OpenShift user name and password

<img src="/static/openshift_101_dcmetromap/ocp-login.png" width="600">
<br/>

Once logged in you should see the Jenkins console 

> In the Jenkins console, open the "OpenShift Sample" menu and select "Configure"

<img src="/static/openshift_101_dcmetromap/ocp-lab-cicd-jenkins.png" width="900">
<br/>

You'll see a series of Jenkins build steps defined. These build steps are from the Jenkins plugin for Openshift. Refer to the [OpenShift Jenkins plugin][2] documentation for details on the various functionality provided.

> The default values for each of the various build steps listed for the sample job are sufficient for our demonstration. Click "Save" to save the job settings and the Project OpenShift Sample page will be displayed. 

<img src="/static/openshift_101_dcmetromap/ocp-lab-cicd-jenkins-config.png" width="600"><br/>

> Select "Build Now" from the Jenkins console and note the Build History pane updating

<img src="/static/openshift_101_dcmetromap/ocp-lab-cicd-jenkins-buildNow-history.png" width="600"><br/>

> Hover over the build number of the current build, for example "#1", open the drop down menu and select "Console Output"

<img src="/static/openshift_101_dcmetromap/ocp-lab-cicd-jenkins-console-output.png" width="900"><br/>

The Jenkins build has triggered an OpenShift build of the application. Jenkins waits for the build to result in a deployment and then confirms the new deployment works.</br>
If so, Jenkins "tags" the image for production. This tagging will trigger another deployment, this time creating/updating the production service FRONTEND-PROD.

<img src="/static/openshift_101_dcmetromap/ocp-lab-cicd-jenkins-app-overview.png" width="900"><br/>

## Confirm both the test and production services are available

> Browse to both services

{{< panel_group >}}

{{% panel "CLI Steps" %}}

<blockquote>
<i class="fa fa-terminal"></i> Use the "oc get service" command to get the internal IP and port needed to access the frontend and frontend-prod services:
</blockquote>

```
$ oc get services -n cicd | grep frontend
frontend        172.30.151.206   <none>        8080/TCP    40m
frontend-prod   172.30.230.228   <none>        8080/TCP    40m
```
Use IPs and ports to access services through web browser
{{% /panel %}}

{{% panel "Web Console Steps" %}}

<blockquote>
Select services' links from Overview page.
</blockquote>

<img src="/static/openshift_101_dcmetromap/ocp-lab-cicd-jenkins-app-overview.png" width="900"><br/>

{{% /panel %}}

{{< /panel_group >}}

Service web page displayed:

<img src="/static/openshift_101_dcmetromap/ocp-lab-cicd-app-test.png" width="900"><br/>

# Summary
In this lab you have very quickly and easily constructed a basic Build/Test/Deply pipeline. Although our example was very basic it introduces you to a powerful DevOps feature of OpenShift through the leveraging of Jenkins. This can be extended to support complex real-world continuous delivery requirements. Read more about the use of Jenkins on OpenShift [here][3] and more about Jenkins [here][4].

[1]: https://jenkins.io/doc/book/pipeline/
[2]: https://github.com/openshift/jenkins-plugin
[3]: https://docs.openshift.com/enterprise/latest/using_images/other_images/jenkins.html
[4]: https://jenkins.io/doc

