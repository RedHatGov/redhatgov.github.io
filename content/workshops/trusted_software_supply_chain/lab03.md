---
title:  Lab 03 - Jenkins Pipeline
workshops: trusted_software_supply_chain
workshop_weight: 13
layout: lab
---
# Jenkins and OpenShift

Jenkins can be integrated with OpenShift in 3 ways.  Today, you'll be working with a containerized Jenkins Server that's fully integrated with OpenShift.

<img src="../images/jenkins_integrated.png" width="900" />

# Login through SSO with Jenkins

Go into your CICD project and find the running Jenkins Pod.

Click the external route to go into your Jenkins Server

<img src="../images/jenkins_pod.png" width="900" />

Click Login with OpenShift.

Login with your OpenShift Credentials.  

<img src="../images/jenkins_ocp_login.png" width="500" />

You will be asked to authorize access to the jenkins service account.  Go ahead and Allow selected permissions.

# Jenkins

You should now see the Jenkins Home Page

<img src="../images/jenkins_home.png" width="900" />

Jenkins follows a master/slave architecture.  Your pipeline will run on node/slaves process called a Jenkins executor.  A Jenkins executor is one of the basic building blocks which allow a build to run on a node/slave (e.g. build server). Think of an executor as a single “process ID”, or as the basic unit of resource that Jenkins executes on your machine to run a build.

# Building  your Trusted Software Supply Chain

Today, you will be building  your Trusted Software Supply Chain using a Jenkins Pipeline that is integrated with OpenShift.

In addition to standard Jenkins Pipeline Syntax, the OpenShift Jenkins image provides the OpenShift Domain Specific Language (DSL) (through the OpenShift Jenkins Client Plug-in), which aims to provide a readable, concise, comprehensive, and fluent syntax for rich interactions with an OpenShift API server, allowing for even more control over the build, deployment, and promotion of applications on your OpenShift cluster.

Please refer to these examples for more info.

- https://github.com/openshift/jenkins-client-plugin#examples

# Writing your Pipeline

Get out your favorite text editor.  In the next few labs, we will be writing your pipeline in a text editor.  Once written, we will be importing your pipeline file into OpenShift.  Make sure to Save your work as we go along.

# Create BuildConfig
We will be create a BuildConfig that employs the Jenkins pipeline strategy for our Trusted Software Supply Chain.



```
apiVersion: v1
kind: BuildConfig
metadata:
    annotations:
      pipeline.alpha.openshift.io/uses: '[{"name": "jenkins", "namespace": "", "kind": "DeploymentConfig"}]'
    labels:
      app: cicd-pipeline
      name: cicd-pipeline
    name: tasks-pipeline
spec:
    triggers:
      - type: GitHub
        github:
          secret: ${WEBHOOK_SECRET}
      - type: Generic
        generic:
          secret: ${WEBHOOK_SECRET}
    runPolicy: Serial
    source:
      type: None

```
# Update your user Dev and Stage projects

Add the following Jenkins Pipeline Strategy.

In your pipeline text file, make sure <user> reflects your user #

```
strategy:
  jenkinsPipelineStrategy:
    env:
    - name: DEV_PROJECT
      value: dev-<user>
    - name: STAGE_PROJECT
      value: stage-<user>
```
# Add your Jenkins File.  

We will be launching a maven node/slave to execute our pipeline.

You will also be declaring variables such as version and mvnCmd to be used later int he pipeline.

The .xml file refers to maven configurations for your application.  The file can be seen here:

https://github.com/epe105/openshift-tasks/blob/master/configuration/cicd-settings-nexus3.xml

```
        jenkinsfile: |-
          def version, mvnCmd = "mvn -s configuration/cicd-settings-nexus3.xml"
          pipeline {
            agent {
              label 'maven'
            }
```

# Verify Your Pipeline File

Your Pipeline Text File should look like this:

```
apiVersion: v1
kind: BuildConfig
metadata:
    annotations:
      pipeline.alpha.openshift.io/uses: '[{"name": "jenkins", "namespace": "", "kind": "DeploymentConfig"}]'
    labels:
      app: cicd-pipeline
      name: cicd-pipeline
    name: tasks-pipeline
spec:
    triggers:
      - type: GitHub
        github:
          secret: ${WEBHOOK_SECRET}
      - type: Generic
        generic:
          secret: ${WEBHOOK_SECRET}
    runPolicy: Serial
    source:
      type: None
    strategy:
      jenkinsPipelineStrategy:
        env:
        - name: DEV_PROJECT
          value: dev-<user>
        - name: STAGE_PROJECT
          value: stage-<user>
        jenkinsfile: |-
          def version, mvnCmd = "mvn -s configuration/cicd-settings-nexus3.xml"
          pipeline {
            agent {
              label 'maven'
            }
```
