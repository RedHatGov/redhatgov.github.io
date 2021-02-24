---
title: Lab 8 - CI / CD Pipeline
workshops: openshift_4_101
workshop_weight: 17
layout: lab
---

# CI/CD Defined
In modern software projects many teams utilize the concept of Continuous Integration (CI) and Continuous Delivery (CD). By setting up a tool chain that continuously builds, tests, and stages software releases, a team can ensure that their product can be reliably released at any time. OpenShift can be an enabler in the creation and management of this tool chain.

In this lab we walk through creating a simple example of a CI/CD [pipeline] utilizing Jenkins, all running on top of OpenShift! The Jenkins job will trigger OpenShift to build and deploy a test version of the application, validate that the deployment works, and then tag the test version into production.

## Create a new project
Create a new project named “cicd-{{< span "userid" "YOUR#" >}}”.

{{< panel_group >}}

{{% panel "CLI Steps" %}}

<i class="fa fa-terminal"></i> Create the project cicd-{{< span "userid" "YOUR#" >}}

<code>
$ oc new-project cicd-{{< span2 "userid" "YOUR#" >}}
</code>

{{% /panel %}}

{{% panel "Web Console Steps" %}}

<blockquote>
Switch modes to 
<img src="../images/ocp-administrator-mode.png" width="257">
</blockquote>

<img src="../images/ocp-lab-cicd-new-project-landing.png" width="300"><br/>

<blockquote>
click "Create Project".
</blockquote>

<img src="../images/ocp-lab-cicd-new-project.png" width="400"><br/>

<blockquote>
Fill in the Name and Display Name of the project as "cicd-{{< span "userid" "YOUR#" >}}" and click "Create"
</blockquote>
<img src="../images/ocp-lab-cicd-new-project-detail.png" width="500"><br/>
{{% /panel %}}

{{< /panel_group >}}

## Instantiate a Jenkins server in your project

{{< panel_group >}}

{{% panel "CLI Steps" %}}

```bash
$ oc new-app jenkins-ephemeral --as-deployment-config=true
$ oc logs -f dc/jenkins
```

Wait for logs to return "Success".

{{% alert info %}}
NOTE: this may take some time
{{% /alert %}}

{{% /panel %}}

{{% panel "Web Console Steps" %}}

<blockquote>
In "Developer" mode, click "+Add"
</blockquote>

<br><img src="../images/ocp-developer-add.png" width="300"><br/>

<blockquote>
Select the "From Catalog" button, Select "Template"
</blockqote>
<br><img src="../images/ocp-developer-add-template.png" width="150"><br/>
<blockquote>
Filter on "Jenkins (Ephemeral)". Then select "Jenkins (Ephemeral)".
</blockquote>

<img src="../images/ocp-lab-cicd-jenkins-instantiate.png" width="900"><br/>

<img src="../images/ocp-lab-cicd-jenkins-instantiate1.png" width="900"><br/>

<blockquote>
Click
<img src="../images/ocp-instantiate-template-button.png" width="165"><br/>
</blockquote>

<img src="../images/ocp-lab-cicd-jenkins-instantiate2.png" width="900"><br/>

<blockquote>
Select the Project cicd-{{< span "userid" "YOUR#" >}} from "Namespace"
</blockquote>

<img src="../images/ocp-lab-cicd-jenkins-instantiate3.png" width="900"><br/>

<blockquote>
Scroll down to the bottom, and click 
<img src="../images/ocp-create-button.png" width="75">
</blockquote>

<br><img src="../images/ocp-lab-cicd-jenkins-instantiate4.png" width="900"><br/>

<blockquote>
Go to "Topology", select the deployment configuration for jenkins, under details ... wait to pod scales to 1.
<br><img src="../images/ocp-lab-cicd-jenkins-instantiate-wait.png" width="900"><br/>
</blockquote>

{{% /panel %}}

{{< /panel_group >}}

## Create a sample application configuration


```bash
$ oc create -f https://raw.githubusercontent.com/openshift/origin/master/examples/jenkins/pipeline/nodejs-sample-pipeline.yaml
```

## Confirm you can access Jenkins

{{< panel_group >}}

{{% panel "CLI Steps" %}}

<blockquote>
<i class="fa fa-terminal"></i> Get the route to the Jenkins server:
</blockquote>

```bash
$ oc get route | grep jenkins | awk '{ print $2 }'
```

Copy the above URL, and paste it in your web browser, to access Jenkins.
{{% /panel %}}

{{% panel "Web Console Steps" %}}

<blockquote>
In "Developer" mode, under "Topology", click the arrow, in the upper right corner of the "jenkins" icon
</blockquote>

<img src="../images/ocp-lab-cicd-jenkins-overview.png" width="500"><br/>

{{% /panel %}}

{{< /panel_group >}}

> Select "Login with OpenShift" from Jenkins login page

<img src="../images/ocp-lab-cicd-jenkins-login-1.png" width="400">
</br>

The OpenShift login page is displayed in a new browser tab.

> Login with your OpenShift user name and password

<img src="../images/ocp-login.png" width="600">
<br/>

Once logged in, click the [Allow selected permissions] button and you should see the Jenkins dashboard.

## Start the pipeline

{{< panel_group >}}

{{% panel "CLI Steps" %}}

<i class="fa fa-terminal"></i> Launch the pipeline:

```bash
$ oc start-build nodejs-sample-pipeline
```

{{% /panel %}}

{{% panel "Web Console Steps" %}}


> Using the OpenShift Web Console, in "Administrator" mode, choose *Builds* -> *Build Configs*, and then click on "nodejs-sample-pipeline"

<img src="../images/ocp-lab-cicd-start-pipeline.png" width="900">

> From the "Actions" menu, choose "Start Build"

<img src="../images/ocp-lab-cicd-pipeline-actions-start_build.png" width="200">

{{% /panel %}}

{{< /panel_group >}}

## Monitor the pipeline's progress

When the pipeline starts, OpenShift uploads the pipeline to the Jenkins server for execution. 

The Jenkins dashboard should indicate that a new build is executing.

<img src="../images/ocp-lab-cicd-jenkins-build-exec-status.png" width=600>

Back in the OpenShift Web Console, watch the pipeline execute. 

## Confirm that the application is available

<blockquote>
In "Developer" mode, select the "cicd-{{< span2 "userid" "YOUR#" >}}" project, and click on "Topology"
</blockquote>

<img src="../images/ocp-lab-cicd-jenkins-app-overview.png" width="900"><br/>

<blockquote>
Click on the arrow, at the upper right corner of the "nodejs-mongodb6-example" icon, to launch the web page
<img src="../images/ocp-launch-button.png" width="50"><br/>
</blockquote>


Service web page displayed:

<img src="../images/ocp-lab-cicd-app-test.png" width=700><br/>

# Summary
In this lab you have very quickly and easily constructed a basic pipeline. 


{{< importPartial "footer/footer.html" >}}
