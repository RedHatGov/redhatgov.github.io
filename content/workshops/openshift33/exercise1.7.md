---
title: Exercise 1.7 - CI / CD Pipelines
workshops: openshift33
workshop_weight: 170
layout: lab
---

### Overview
In modern software projects many teams utilize the concept of continuous integration and continuous delivery (CI/CD).  By setting up a tool chain that continuously builds, tests, and stages software releases a team can ensure that their product can be reliably released at any time.  OpenShift can be an enabler in the creation and management of this tool chain.  In this lab we will walk through creating a simple example of a CI/CD [pipeline][1] utilizing Jenkins, all running on top of OpenShift!


### Start by creating a new project
To begin, we will create a new project. Name the new project "cicd".

{{< panel_group >}}
{{% panel "CLI Steps" %}}

<blockquote>
<i class="fa fa-terminal"></i> Goto the terminal and type the following:
</blockquote>

```bash
oc new project cicd
```

{{% /panel %}}
{{% panel "Web Console Steps" %}}

<blockquote>Browse to original landing page, and click "New Project".</blockquote>
<p><img src="../images/ose-lab-cicd-new-project.png" width="100"/></p>

<blockquote>Fill in the name of the project as "cicd" and click "Create"</blockquote>
<p><img src="../images/ose-lab-cicd-new-project-detail.png" width="500"/></p>

{{% /panel %}}
{{< /panel_group >}}


### Start by installing Jenkins
First we will start by installing Jenkins to run in a pod within your workshop project.  Because this is just a workshop we use the ephemeral template to create our Jenkins sever (for a enterprise system you would probably want to use the persistent template).  Follow the steps below:

{{< panel_group >}}
{{% panel "CLI Steps" %}}

<blockquote>
<i class="fa fa-terminal"></i> Go to the terminal and type the following:
</blockquote>

```bash
oc new-app --template=jenkins-ephemeral -e JENKINS_PASSWORD=password
oc expose svc jenkins
oc policy add-role-to-user edit -z default
```

<blockquote>Copy hostname and paste in browser's address bar...</blockquote>

```bash
oc get routes | grep 'jenkins' | awk '{print $2}'
```

{{% /panel %}}
{{% panel "Web Console Steps" %}}

<blockquote>Click "Add to Project", click "Browse Catalog" select "jenkins-ephemeral".</blockquote>
<p><img src="../images/ose-lab-cicd-jenkins-ephemeral.png" width="500"/></p>

<blockquote>Click "continue to overview", wait for it to start</blockquote>
<p><img src="../images/ose-lab-cicd-jenkins-start.png" width="500"/></p>

<blockquote>Click the service link to open jenkins, login as admin/password</blockquote>
<p><img src="../images/ose-lab-cicd-jenkins-login.png" width="500"/></p>

{{% /panel %}}
{{< /panel_group >}}


### The OpenShift pipeline plugin
Now let's make sure we have the OpenShift Pipeline [plugin][2] properly installed within Jenkins.  It will be used to define our application lifecycle and to let our Jenkins jobs perform commands on our OpenShift cluster. It is possible that the plugin is already installed in your environment, so use these steps to verify if it is installed and install it if is not.

{{< panel_group >}}
{{% panel "Install OSE Plugin Steps" %}}

<blockquote>Click "Manage Jenkins"</blockquote>
<p><img src="../images/ose-lab-cicd-manage-jenkins.png" width="100" height="100"/></p>

<blockquote>Click on "Manage Plugins"</blockquote>
<p><img src="../images/ose-lab-cicd-manage-plugins.png" width="500" /></p>

<blockquote>Click on "Available" tab, and filter on "openshift". Find the"Openshift Pipeline Jenkins Plugin". If it is not installed, then install it.</blockquote>
<p><img src="../images/ose-lab-cicd-jenkins-plugin.png" width="700" /></p>

{{% /panel %}}
{{< /panel_group >}}

You can read more about the plugin [here][3].


### Our deployments
In this example pipeline we will be building, tagging, staging and scaling a Node.js webapp.  We wrote all the code for you already, so don't worry you won't be coding in this lab.  You will just use the code and unit tests to see how CI/CD pipelines work.  And keep in mind that these principles are relevant whether your programming in Node.js, Ruby on Rails, Java, PHP or any one of today's popular programming languages.

<blockquote>Fork the project into your own GitHub account</blockquote>
<p><img src="../images/ose-lab-cicd-fork.png" width="700" /></p>

<blockquote>Create a dev deployment based on the forked repo
</blockquote>
<blockquote><i class="fa fa-terminal"></i> Goto the terminal and type the following:</blockquote>
<p>

```bash
oc new-app https://github.com/YOUR_ACCOUNT/openshift-workshops.git \
           --name=dev --context-dir=dc-metro-map
oc expose svc/dev
```
</p>

<blockquote>Create a test deployment based on a tag of the dev ImageStream
</blockquote>
<blockquote><i class="fa fa-terminal"></i> Goto the terminal and type the following:</blockquote>
<p>

```bash
oc new-app dev:readyToTest --name=test --allow-missing-imagestream-tags
oc expose dc/test --port 8080
oc expose svc/test
```
</p>


#### Setup Jenkins jobs to use their OpenShift image stream (which is off your GitHub fork)
{{< panel_group >}}
{{% panel "Steps to Create Jenkins Job" %}}

<blockquote>Click "New Item"</blockquote>
<p><img src="../images/ose-lab-cicd-new-item.png" width="500" /></p>

<blockquote>Call it yourname-ci-devel, select freestyle, click OK</blockquote>
<p><img src="../images/ose-lab-cicd-name-job.png" width="500" /></p>

<blockquote>Click add build step and choose "Tag OpenShift Image". Enter in all the info, tag as "readyToTest"</blockquote>
<p><img src="../images/ose-lab-cicd-new-tag.png" width="700" /></p>

<blockquote>In the "Post-build actions" subsection click "Add post-build action" and select "Build other projects".  Type in "yourname-ci-deploytotest"</blockquote>
<p><img src="../images/ose-lab-cicd-build-other-project.png" width="500" /></p>

<blockquote>Click "Save", don't worry about the error here, we are about to build that Jenkins job.</blockquote>

<p>
<!-- :notebook: You will not need the URL of the OpenShift API endpoint or the Authorization Token to get this to work. -->
</p>
**NOTE:** You will not need the URL of the OpenShift API endpoint or the Authorization Token to get this to work.

{{% /panel %}}
{{< /panel_group >}}


#### Connecting the pipeline for dev->test
{{< panel_group >}}
{{% panel "Steps to Connect Pipeline" %}}

<blockquote>Click "Back to dashboard"</blockquote>

<blockquote>Click "New Item"</blockquote>

<blockquote>Call it "yourname-ci-deploytotest", select "freestyle", click "OK"</blockquote>
<p><img src="../images/ose-lab-cicd-deploy-to-test.png" width="500" /></p>

<blockquote>Click add build step and choose "Execute shell"</blockquote>
<p><img src="../images/ose-lab-cicd-add-exec.png" width="200" /></p>

Additional steps could go here. For now let's just add some bash to the text area:

```bash
echo "inside my jenkins job"
```

<blockquote>Click add build step and choose "Trigger OpenShift Deployment".</blockquote>
<p><img src="../images/ose-lab-cicd-trigger-deployment.png" width="700" /></p>

<blockquote>Click add build step and choose "Scale OpenShift Deployment".</blockquote>
<p><img src="../images/ose-lab-cicd-scale-deployment.png" width="700" /></p>

<blockquote>Click "Save".</blockquote>
<p><img src="../images/ose-lab-cicd-save.png" width="200" /></p>

{{% /panel %}}
{{< /panel_group >}}


### Watch me release!
At this point you should see the following scenario play out:

  * Inside of Jenkins, you will click the dev pipline that was created we created. On the left-hand side you will see an option to <img src="../images/ose-lab-cicd-build-now.png" width="100" />. When you click this, the first job will begin to run.

  * This first job will use the OpenShift Pipeline plugin to create a new tag of the image called "readyToTest".

  * When this job completes, a second job will execute. This second job cause the deployment to initiate of our test application and then scale the test application to 2 pods.

  * You can see the history of this new tag by browsing to initiate two jobs in the pipeline with the final step being the new tag of "readyToTest". The new tag can then be used for automatic or manual builds of the new test application. You can view the status of the new tag in OpenShift by browsing to Builds -> Images -> your image stream

  <p><img src="../images/ose-lab-cicd-image-stream-view.png" width="700" /></p>


### Summary
Coming soon...  Read more about usage of [Jenkins on OpenShift here][4].  Read more about the concepts behind [pipelines in Jenkins here][1].


[1]: https://jenkins.io/doc/pipeline/
[2]: https://wiki.jenkins-ci.org/display/JENKINS/OpenShift+Pipeline+Plugin
[3]: https://github.com/openshift/jenkins-plugin/
[4]: https://docs.openshift.com/container-platform/3.3/using_images/other_images/jenkins.html
[5]: https://en.wikipedia.org/wiki/Continuous_delivery
[6]: https://github.com/openshift/origin/blob/master/examples/jenkins/README.md
[7]: https://docs.openshift.com/container-platform/3.3/creating_images/s2i_testing.html#creating-images-s2i-testing
