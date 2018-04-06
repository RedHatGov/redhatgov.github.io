---
title: Lab 8 - CI / CD Pipeline
workshops: openshift_101_dcmetromap
workshop_weight: 17
layout: lab
---

# CI/CD Defined
In modern software projects many teams utilize the concept of Continuous Integration (CI) and Continuous Delivery (CD). By setting up a tool chain that continuously builds, tests, and stages software releases a team can ensure that their product can be reliably released at any time. OpenShift can be an enabler in the creation and management of this tool chain.

In this lab we walk through creating a simple example of a CI/CD [pipeline][1] utlizing Jenkins, all running on top of OpenShift! The Jenkins job will trigger OpenShift to build and deploy a test version of the application, validate that the deployment works, and then tag the test version into production.

In the steps below replace 'YOUR#' with your student number (if applicable).

## Create a new project
Create a new project named “cicd-{{< span "userid" "YOUR#" >}}”.

{{< panel_group >}}

{{% panel "CLI Steps" %}}

## Create the project cicd-{{< span "userid" "YOUR#" >}}

<code>
$ oc new-project cicd-{{< span "userid" "YOUR#" >}}
</code>

{{% /panel %}}

{{% panel "Web Console Steps" %}}

<blockquote>
Browse to original landing page by clicking by "OpenShift Container Platform" in the top left hand corner
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

## Use the cicd-{{< span "userid" "YOUR#" >}} project

```bash
$ oc project cicd-{{< span "userid" "YOUR#" >}}
```

## Instantiate a Jenkins server in your project

{{< panel_group >}}

{{% panel "CLI Steps" %}}

```bash
$ oc new-app jenkins-ephemeral
```
{{% /panel %}}

{{% panel "Web Console Steps" %}}

<blockquote>
Click "Add to Project", select "Browse Catalog" tab and search on "jenkins". Then select "Jenkins (Ephemeral)".
</blockquote>

<img src="../images/ocp-lab-cicd-jenkins-instantiate.png" width="600"><br/>

<img src="../images/ocp-lab-cicd-jenkins-instantiate1.png" width="700"><br/>

<blockquote>
Select Next
</blockquote>

<img src="../images/ocp-lab-cicd-jenkins-instantiate2.png" width="700"><br/>

<blockquote>
Select the Project cicd-{{< span "userid" "YOUR#" >}} from "Add to Project"
</blockquote>

<img src="../images/ocp-lab-cicd-jenkins-instantiate3.png" width="700"><br/>

<blockquote>
Select the Create
</blockquote>

<img src="../images/ocp-lab-cicd-jenkins-instantiate4.png" width="700"><br/>

<blockquote>
Click the "Continue to the project overview" link
</blockquote>

<img src="../images/ocp-lab-cicd-jenkins-overview.png" width="900"><br/>

{{% /panel %}}

{{< /panel_group >}}

## Create a sample application configuration

Use the "oc new-app" command to create a simple nodejs application from a template file:

```bash
$ oc new-app -f https://raw.githubusercontent.com/openshift/origin/master/examples/jenkins/application-template.json
```
> Click on "Overview" within the OpenShift console to display the sample application configuration

<img src="../images/ocp-lab-cicd-app-create.png" width="900"><br/>

## Manage and view a Jenkins build

> Access Jenkins

{{< panel_group >}}

{{% panel "CLI Steps" %}}

<blockquote>
<i class="fa fa-terminal"></i> Get the route to the Jenkins server
</blockquote>

```bash
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

<img src="../images/ocp-lab-cicd-jenkins-overview.png" width="900"><br/>

{{% /panel %}}

{{< /panel_group >}}

> Select "Login with OpenShift" from Jenkins login page

<img src="../images/ocp-lab-cicd-jenkins-login-1.png" width="400">
</br>

The OpenShift login page is displayed in a new browser tab.

> Login with your OpenShift user name and password

<img src="../images/ocp-login.png" width="600">
<br/>

Once logged in, click the [Allow selected permissions] button and you should see the Jenkins console 

## Begin pipeline section 
## Create a pipeline

The first step is to create a build configuration that is based on a Jenkins pipeline strategy. The pipeline is written in the format of a Jenkinsfile 
using the GROOVY language.

Using either the webconsole or CLI, copy and paste the following code to create an OpenShift build configuration object.

```bash
kind: "BuildConfig"
apiVersion: "v1"
metadata:
  name: "pipeline"
spec:
  strategy:
    jenkinsPipelineStrategy:
      jenkinsfile: |-
        node() {
          stage 'buildFrontEnd'
          openshiftBuild(buildConfig: 'frontend', showBuildLogs: 'true')
  
          stage 'deployFrontEnd'
          openshiftDeploy(deploymentConfig: 'frontend')
  
          stage "promoteToProd"
          input message: 'Promote to production ?', ok: '\'Yes\''
          openshiftTag(sourceStream: 'origin-nodejs-sample', sourceTag: 'latest', destinationStream: 'origin-nodejs-sample', destinationTag: 'prod')
  
          stage 'scaleUp'
          openshiftScale(deploymentConfig: 'frontend-prod',replicaCount: '2')
        }
```
{{< panel_group >}}

{{% panel "CLI Steps" %}}

```bash
oc create -f - <<EOF
<Copy and paste the YAML code from above>
EOF
```

Expected output:

```bash
buildconfig "pipeline" created
```
{{% /panel %}}

{{% panel "Web Console Steps" %}}

Choose *Add to project* -> *Import YAML*

<img src="../images/ocp-lab-cicd-import-yaml.png" width="900">

{{% /panel %}}

{{< /panel_group >}}

## Start the pipeline

<img src="../images/ocp-lab-cicd-start-pipeline.png" width="900">

Now watch the pipeline execute.

<img src="../images/ocp-lab-cicd-pipeline-input.png" width="900">

Click on *Input Required" and you should get redirected to the Jenkins Web Console to 
approve the promotion to production.

<img src="../images/ocp-lab-cicd-jenkins-promote.png" width="900">

Now return to the OpenShift Web Console and watch the pipeline finish.

<img src="../images/ocp-lab-cicd-pipeline-stages.png" width="900">

Confirm the *frontend-prod* has deployed 2 pods. 

<img src="../images/ocp-lab-cicd-create-route.png" width="900">

Next, *create a secure route* with TLS edge termination so the application can be visited.

<img src="../images/ocp-lab-cicd-route-tls.png" width="900">

## Edit the pipeline.

Now make a change to the pipeline. For example, in the *scaleUp* stage, change the number
of replicas to 3. 

{{< panel_group >}}

{{% panel "CLI Steps" %}}

If you are comfortable using the **vi** editor:

~~~bash
oc edit bc/pipeline
~~~

{{% /panel %}}

{{% panel "Web Console Steps" %}}

<img src="../images/ocp-lab-cicd-pipeline-edit.png" width="900">

{{% /panel %}}

{{< /panel_group >}}

Save your changes and run the pipeline again to confirm the *frontend-prod* deployment has 
deployed 3 pods.

## End pipeline section

> In the Jenkins console, open the "OpenShift Sample" menu and select "Configure"

<img src="../images/ocp-lab-cicd-jenkins.png" width="900">
<br/>

You'll see a series of Jenkins build steps defined. These build steps are from the Jenkins plugin for Openshift. Refer to the [OpenShift Jenkins plugin][2] documentation for details on the various functionality provided.

> The default values for each of the various build steps listed for the sample job are sufficient for our demonstration. Click "Save" to save the job settings and the Project OpenShift Sample page will be displayed. 

<img src="../images/ocp-lab-cicd-jenkins-config.png" width="600"><br/>

> Select "Build Now" from the Jenkins console and note the Build History pane updating

<img src="../images/ocp-lab-cicd-jenkins-buildNow-history.png" width="600"><br/>

> Hover over the build number of the current build, for example "#1", open the drop down menu and select "Console Output"

<img src="../images/ocp-lab-cicd-jenkins-console-output.png" width="900"><br/>

The Jenkins build has triggered an OpenShift build of the application. Jenkins waits for the build to result in a deployment and then confirms the new deployment works.</br>
If so, Jenkins "tags" the image for production. This tagging will trigger another deployment, this time creating/updating the production service FRONTEND-PROD.

<img src="../images/ocp-lab-cicd-jenkins-app-overview.png" width="900"><br/>

## Confirm both the test and production services are available

> Browse to both services

{{< panel_group >}}

{{% panel "CLI Steps" %}}

<blockquote>
<i class="fa fa-terminal"></i> Use the "oc get service" command to get the internal IP and port needed to access the frontend and frontend-prod services:
</blockquote>

<code>
$ oc get services -n cicd-{{< span "userid" "YOUR#" >}} | grep frontend</br>
frontend        172.30.151.206   <none>        8080/TCP    40m</br>
frontend-prod   172.30.230.228   <none>        8080/TCP    40m</br>
</code>

Use IPs and ports to access services through web browser
{{% /panel %}}

{{% panel "Web Console Steps" %}}

<blockquote>
Select services' links from Overview page.
</blockquote>

<img src="../images/ocp-lab-cicd-jenkins-app-overview.png" width="900"><br/>

{{% /panel %}}

{{< /panel_group >}}

Service web page displayed:

<img src="../images/ocp-lab-cicd-app-test.png" width="900"><br/>

# Summary
In this lab you have very quickly and easily constructed a basic Build/Test/Deply pipeline. Although our example was very basic it introduces you to a powerful DevOps feature of OpenShift through the leveraging of Jenkins. This can be extended to support complex real-world continuous delivery requirements. Read more about the use of Jenkins on OpenShift [here][3] and more about Jenkins [here][4].

[1]: https://jenkins.io/doc/book/pipeline/
[2]: https://github.com/openshift/jenkins-plugin
[3]: https://docs.openshift.com/enterprise/latest/using_images/other_images/jenkins.html
[4]: https://jenkins.io/doc

{{< importPartial "footer/footer.html" >}}
