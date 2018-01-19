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

You can deploy the entire set of resources using the import yaml/json feature within OpenShift OR skiip this step and go to web console!!!

> <i class="fa fa-terminal"></i> Goto the terminal and type these commands:

```
$ oc new-app -f https://raw.githubusercontent.com/DLT-Solutions-JBoss/nodejs-ex/master/bluegreen-pipeline.yaml
```

Review the results of the template processing via the console.

## To establish the pipline via the web console
<blockquote>
Click "Add to Project"
</blockquote>
<img src="../images/ocp-addToProjectButton.png" width="200"><br/>

<blockquote>
Select the "Import YAML/JSON" tab and copy contents of https://raw.githubusercontent.com/DLT-Solutions-JBoss/nodejs-ex/master/bluegreen-pipeline.yaml opened in a separate browser tab.
</blockquote>

<img src="../images/ocp-lab-cicd-pipeline-template-import.png" width="900"><br/>

<blockquote>
Click "Create".  The following dialog box will appear.
</blockquote>

<img src="../images/ocp-lab-cicd-pipeline-template-process.png" width="400"><br/>

<blockquote>
Click "Continue" with the "Process the template" checkbox selected.
</blockquote>

>The template will be processed and display the application configuration page.

<img src="../images/ocp-lab-cicd-pipeline-template-create.png" width="900"><br/>

>Use all the default values, scroll down and select "Create", Your application will be created and its overview page will appear.

<img src="../images/ocp-lab-cicd-pipeline-template-summary.png" width="900"><br/>

>Click the "Continue to overview" link.

<img src="../images/ocp-lab-cicd-pipeline-template-overview.png" width="900"><br/>

>This takes you to the Overview page in the console where you see the resources created for your application.  However, you do not have any builds yet as the are produced using the OpenShift pipeline function. From the left side menu, Select "Builds", then "Pipelines" menu option on the left. The created pipeline will appear. 

<img src="../images/ocp-lab-cicd-pipeline-template-pipeline-start.png" width="900"><br/>
      
>Select the "Start Pipeline" button on the right.  This will start your build pipeline.

<img src="../images/ocp-lab-cicd-pipeline-template-pipeline-started.png" width="900"><br/>

>You can see the pipeline start.  Select the "View Log" link beneath the Build #1 node. You will be prompted to log in via Jenkins as you did in the previous lab.  Accept all permissions and/or exceptions as you did previously as you log in with your OpenShift credentials.

<img src="../images/ocp-lab-cicd-pipeline-template-pipeline-jenkins-console.png" width="900"><br/>

>After seeing your console output in Jenkins, go back to your OpenShift console tab, and wait for the "Input Required" step and select it.  You will see the following page.

<img src="../images/ocp-lab-cicd-pipeline-template-pipeline-input-required.png" width="900"><br/>

>If you stayed within Jenkins, the console output will show the "Input Required" step as shown.

<img src="../images/ocp-lab-cicd-pipeline-template-pipeline-proceed.png" width="900"><br/>

>After proceeding with the build, go back to your web console Overview page.  You should see that the green version of your application is build and traffic is being directed at it.  Your blue version has not been built.

<img src="../images/ocp-lab-cicd-pipeline-template-pipeline-first-green.png" width="900"><br/>

>Repeat the steps to start your pipleine again and you'll see the blue version get built and traffic being directed toward it now.

<img src="../images/ocp-lab-cicd-pipeline-template-pipeline-second-blue.png" width="900"><br/>

> You can repeat these steps over and over and the pipeline will toggle between green and blue!

# Summary
Using pipelines for your applications provides visibility to your build, test, deploy executions and facilitates cooperation between various IT groups and can be used as a continuous improvement tool in order to create a higher quality software product and assist your agency in becoming a DevOps shop!


[1]: https://jenkins.io/doc/book/pipeline/
[2]: http://martinfowler.com/bliki/BlueGreenDeployment.html

