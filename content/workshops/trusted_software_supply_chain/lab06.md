---
title:  Lab 06 - Build App Stage
workshops: trusted_software_supply_chain
workshop_weight: 16
layout: lab
toc: true
---

# Add Build App Stage to Pipeline Text File

Next, you will add the Build App Stage to your pipeline.

<img src="../images/pipeline_build.png" width="900" />

The git branch step will clone the openshift-tasks project with the git branch locally from your gogs server to your jenkins node.  The jenkins node is leveraging the [git jenkins plugin][1] to communicate to gogs.

Please note that we are leveraging the eap-7 branch in our git project and not the master branch.

Append the text below to your text file or into the YAML/JSON field for tasks-pipeline in the OpenShift Console.

```
            stages {
              stage('Build App') {
                steps {
                  git branch: 'eap-7', url: 'http://gogs:3000/gogs/openshift-tasks.git'
                  script {
                      def pom = readMavenPom file: 'pom.xml'
                      version = pom.version
                  }
                  sh "${mvnCmd} install -DskipTests=true"
                }
              }
```



View your gogs pod and click select the route (https://gogs...) to log into your gogs server.

Use the user name and password given to you by your instructor.

<img src="../images/gogs_route.png" width="900"><br/>

View the source of the openshift-tasks project in your gogs server.  

<br>

<img src="../images/gogs_home.png" width="900"><br/>

Maven install will run through the [Maven lifecycle][2] and skip the tests.  We will execute tests later in the pipeline.

- validate - validate the project is correct and all necessary information is available
- compile - compile the source code of the project
- test - test the compiled source code using a suitable unit testing framework. These tests should not require the code be packaged or deployed
- package - take the compiled code and package it in its distributable format, such as a JAR.
- verify - run any checks on results of integration tests to ensure quality criteria are met
- install - install the package into the local repository, for use as a dependency in other projects locally
- deploy - done in the build environment, copies the final package to the remote repository for sharing with other developers and projects.

[1]: https://jenkins.io/doc/pipeline/steps/git/
[2]: https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html
