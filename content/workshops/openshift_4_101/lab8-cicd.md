---
title: Lab 8 - CI / CD Pipeline
workshops: openshift_4_101
workshop_weight: 17
layout: lab
---

# CI/CD Defined
In modern software projects many teams utilize the concept of Continuous Integration (CI) and Continuous Delivery (CD). By setting up a tool chain that continuously builds, tests, and stages software releases, a team can ensure that their product can be reliably released at any time. OpenShift can be an enabler in the creation and management of this tool chain.

In this lab we walk through creating a simple example of a CI/CD [pipeline][1] utlizing Jenkins, all running on top of OpenShift! The Jenkins job will trigger OpenShift to build and deploy a test version of the application, validate that the deployment works, and then tag the test version into production.

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
$ oc new-app jenkins-ephemeral
```
{{% /panel %}}

{{% panel "Web Console Steps" %}}

<blockquote>
In "Developer" mode, click "+Add"
</blockquote>

<img src="../images/ocp-developer-add.png" width="300"><br/>

<blockquote>
Select the "From Catalog" button, and filter on "Jenkins (Ephemeral)". Then select "Jenkins (Ephemeral)".
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

<img src="../images/ocp-lab-cicd-jenkins-instantiate4.png" width="900"><br/>

{{% /panel %}}

{{< /panel_group >}}

## Create a sample application configuration

{{< panel_group >}}

{{% panel "CLI Steps" %}}

> Let's download a tempate for a sample application, so that we can integrate it into our pipeline

```bash
$ wget https://raw.githubusercontent.com/openshift/origin/master/examples/jenkins/application-template.json 
```

> Next, let's update the template to not use an deprecated container, as it's base. We'll use Red Hat's Universal Base Image as the platform, instead:

```bash
$ sed 's/nodejs-010-centos7/nodejs-10/g' application-template.json > NEW-Template.json
```

> And last, we'll instantiate the template.

```bash
$ oc create -f NEW-Template.json
```

{{% /panel %}}

{{% panel "Web Console Steps" %}}

<blockquote>
Click "Home" and "Search"
</blockquote>

<img src="../images/ocp-lab-cicd-app-search.png" width="900"><br/>

<blockquote>
From the "Select Resource" (which defaults to Service) dropdown menu, select "Template"
</blockquote>

<img src="../images/ocp-lab-cicd-app-search-template.png" width="900"><br/>

<blockquote>
Click "..." and select "Edit Template"
</blockquote>

<img src="../images/ocp-lab-cicd-app-resources-edit.png" width="700"><br/>

<blockquote>
Find and replace "nodejs-010-centos7" with "nodejs-10"
</blockquote>

<img src="../images/ocp-lab-cicd-app-edit-yaml-template.png" width="800"><br/>

<blockquote>
Click "Save"
</blockquote>

{{% /panel %}}

{{< /panel_group >}}

## With either editing method, please make sure that your template looks like this, when it is complete:

{{< panel_group >}}

{{% panel "Edited Template" %}}

> Your timestamp and uid will vary

```bash
{
  "kind": "Template",
  "apiVersion": "v1",
  "metadata": {
    "name": "nodejs-helloworld-sample",
    "annotations": {
      "description": "This example shows how to create a simple nodejs application in openshift origin v3",
      "iconClass": "icon-nodejs",
      "tags": "instant-app,nodejs"
    }
  },
  "objects": [
    {
      "kind": "Service",
      "apiVersion": "v1",
      "metadata": {
        "name": "frontend-prod"
      },
      "spec": {
        "ports": [
          {
            "name": "web",
            "protocol": "TCP",
            "port": 8080,
            "targetPort": 8080,
            "nodePort": 0
          }
        ],
        "selector": {
          "name": "frontend-prod"
        },
        "type": "ClusterIP",
        "sessionAffinity": "None"
      },
      "status": {
        "loadBalancer": {}
      }
    },
    {
      "kind": "Route",
      "apiVersion": "v1",
      "metadata": {
        "name": "frontend"
      },
      "spec": {
        "to": {
          "kind": "Service",
          "name": "frontend"
        },
        "tls": {
          "termination": "edge"
        }
      }
    },
    {
      "kind": "DeploymentConfig",
      "apiVersion": "v1",
      "metadata": {
        "name": "frontend-prod"
      },
      "spec": {
        "strategy": {
          "type": "Rolling",
          "rollingParams": {
            "updatePeriodSeconds": 1,
            "intervalSeconds": 1,
            "timeoutSeconds": 120
          }
        },
        "triggers": [
          {
            "type": "ImageChange",
            "imageChangeParams": {
              "automatic": true,
              "containerNames": [
                "nodejs-helloworld"
              ],
              "from": {
                "kind": "ImageStreamTag",
                "name": "origin-nodejs-sample:prod"
              }
            }
          },
          {
            "type": "ConfigChange"
          }
        ],
        "replicas": 1,
        "selector": {
          "name":"frontend-prod"
        },
        "template": {
          "metadata": {
            "labels": {
              "name": "frontend-prod"
            }
          },
          "spec": {
            "containers": [
              {
                "name": "nodejs-helloworld",
                "image": " ",
                "ports": [
                  {
                    "containerPort": 8080,
                    "protocol": "TCP"
                  }
                ],
                "resources": {
                  "limits": {
                    "memory": "${MEMORY_LIMIT}"
                  }
                },
                "terminationMessagePath": "/dev/termination-log",
                "imagePullPolicy": "IfNotPresent",
                "securityContext": {
                  "capabilities": {},
                  "privileged": false
                }
              }
            ],
            "restartPolicy": "Always",
            "dnsPolicy": "ClusterFirst"
          }
        }
      }
    },
    {
      "kind": "Service",
      "apiVersion": "v1",
      "metadata": {
        "name": "frontend"
      },
      "spec": {
        "ports": [
          {
            "name": "web",
            "protocol": "TCP",
            "port": 8080,
            "targetPort": 8080,
            "nodePort": 0
          }
        ],
        "selector": {
          "name": "frontend"
        },
        "type": "ClusterIP",
        "sessionAffinity": "None"
      }
    },
    {
      "kind": "ImageStream",
      "apiVersion": "v1",
      "metadata": {
        "name": "origin-nodejs-sample"
      }
    },
    {
      "kind": "ImageStream",
      "apiVersion": "v1",
      "metadata": {
        "name": "origin-nodejs-sample2"
      }
    },
    {
      "kind": "ImageStream",
      "apiVersion": "v1",
      "metadata": {
        "name": "origin-nodejs-sample3"
      }
    },
    {
      "kind": "ImageStream",
      "apiVersion": "v1",
      "metadata": {
        "name": "nodejs-10"
      },
      "spec": {
        "dockerImageRepository": "${NAMESPACE}/nodejs-10"
      }
    },
    {
      "kind": "BuildConfig",
      "apiVersion": "v1",
      "metadata": {
        "name": "frontend",
        "labels": {
          "name": "nodejs-sample-build"
        }
      },
      "spec": {
        "triggers": [
          {
            "type": "GitHub",
            "github": {
              "secret": "secret101"
            }
          },
          {
            "type": "Generic",
            "generic": {
              "secret": "secret101"
            }
          }
        ],
        "source": {
          "type": "Git",
          "git": {
            "uri": "https://github.com/openshift/nodejs-ex.git"
          }
        },
        "strategy": {
          "type": "Source",
          "sourceStrategy": {
            "from": {
              "kind": "ImageStreamTag",
              "name": "nodejs-10:latest"
            }
          }
        },
        "output": {
          "to": {
            "kind": "ImageStreamTag",
            "name": "origin-nodejs-sample:latest"
          }
        },
        "resources": {}
      }
    },
    {
      "kind": "DeploymentConfig",
      "apiVersion": "v1",
      "metadata": {
        "name": "frontend"
      },
      "spec": {
        "strategy": {
          "type": "Rolling",
          "rollingParams": {
            "updatePeriodSeconds": 1,
            "intervalSeconds": 1,
            "timeoutSeconds": 120
          }
        },
        "triggers": [
          {
            "type": "ImageChange",
            "imageChangeParams": {
              "automatic": false,
              "containerNames": [
                "nodejs-helloworld"
              ],
              "from": {
                "kind": "ImageStreamTag",
                "name": "origin-nodejs-sample:latest"
              }
            }
          },
          {
            "type": "ConfigChange"
          }
        ],
        "replicas": 1,
        "selector": {
          "name":"frontend"
          },
        "template": {
          "metadata": {
            "labels": {
              "name": "frontend"
            }
          },
          "spec": {
            "containers": [
              {
                "name": "nodejs-helloworld",
                "image": " ",
                "ports": [
                  {
                    "containerPort": 8080,
                    "protocol": "TCP"
                  }
                ],
                "resources": {
                  "limits": {
                    "memory": "${MEMORY_LIMIT}"
                  }
                },
                "terminationMessagePath": "/dev/termination-log",
                "imagePullPolicy": "IfNotPresent",
                "securityContext": {
                  "capabilities": {},
                  "privileged": false
                }
              }
            ],
            "restartPolicy": "Always",
            "dnsPolicy": "ClusterFirst"
          }
        }
      }
    }
  ],
  "parameters": [
    {
      "name": "MEMORY_LIMIT",
      "displayName": "Memory Limit",
      "description": "Maximum amount of memory the container can use.",
      "value": "512Mi"
    },
    {
      "name": "NAMESPACE",
      "displayName": "Namespace",
      "description": "The OpenShift Namespace where the ImageStream resides.",
      "value": "openshift"
    },
   {
      "name": "ADMIN_USERNAME",
      "displayName": "Administrator Username",
      "description": "Username for the administrator of this application.",
      "generate": "expression",
      "from": "admin[A-Z0-9]{3}"
    },
    {
      "name": "ADMIN_PASSWORD",
      "displayName": "Administrator Password",
      "description": "Password for the administrator of this application.",
      "generate": "expression",
      "from": "[a-zA-Z0-9]{8}"
    }
  ],
  "labels": {
    "template": "application-template-stibuild"
  }
}
```

{{% /panel %}}

{{< /panel_group >}}

## Create a sample application from template

> Use the "oc process" command to create a simple nodejs application from the template file:

```bash
$ oc process nodejs-helloworld-sample -p NAMESPACE=registry.access.redhat.com/ubi7 | oc create -f -
service/frontend-prod created
route.route.openshift.io/frontend created
deploymentconfig.apps.openshift.io/frontend-prod created
service/frontend created
imagestream.image.openshift.io/origin-nodejs-sample created
imagestream.image.openshift.io/origin-nodejs-sample2 created
imagestream.image.openshift.io/origin-nodejs-sample3 created
imagestream.image.openshift.io/nodejs-10 created
buildconfig.build.openshift.io/frontend created
deploymentconfig.apps.openshift.io/frontend created
```

> Click on "Workloads" and then "Deployment Configs", within the OpenShift console, to display the sample application configuration

<img src="../images/ocp-lab-cicd-app-create.png" width="900"><br/>

## Confirm you can access Jenkins

{{< panel_group >}}

{{% panel "CLI Steps" %}}

<blockquote>
<i class="fa fa-terminal"></i> Get the route to the Jenkins server. Your HOST/PORT values will differ
from the example below.
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

## Create a Jenkins pipeline using OpenShift

We will be creating the following very simple (4) stage Jenkins pipeline.

1. Build the application from source.
2. Deploy the test version of the application.
3. Submit for approval, then tag the image for production, otherwise abort.
4. Scale the application.

The first step is to create a build configuration that is based on a Jenkins pipeline strategy. The pipeline is written
in the GROOVY language using a Jenkins file format.

> Use the OpenShift CLI or Web Console to create an OpenShift build configuration object.

{{< panel_group >}}

{{% panel "CLI Steps" %}}

Copy and paste the following into bash.

```bash
oc create -f - <<EOF
kind: "BuildConfig"
apiVersion: "v1"
metadata:
  name: "pipeline"
spec:
  strategy:
    jenkinsPipelineStrategy:
      jenkinsfile: |-
        pipeline {
          agent any
          stages {
            stage('buildFrontEnd') {
              steps {
                script {
                  openshift.withCluster() {
                    openshift.withProject() {
                      openshift.selector("bc", "frontend").startBuild("--wait=true", "--follow")
                    }
                  }
                }
              }
            }
            stage('deployFrontEnd') {
              steps {
                script {
                  openshift.withCluster() {
                    openshift.withProject() {
                      openshift.selector("dc", "frontend").rollout().latest()
                    }
                  }
                }
              }
            }
            stage('promoteToProd') {
              steps {
                script {
                  timeout(time: 15, unit: 'MINUTES') {
                    input message: "Promote to PROD?", ok: "Promote"
                  }
                  openshift.withCluster() {
                    openshift.withProject() {
                      openshift.tag("origin-nodejs-sample:latest", "origin-nodejs-sample:prod")
                    }
                  }
                }
              }
            }
            stage('scaleUp') {
              steps {
                script {
                  openshift.withCluster() {
                    openshift.withProject() {
                      openshift.selector("dc", "frontend-prod").scale("--replicas=2")
                    }
                  }
                }
              }
            }
          }
        }
EOF
```

Expected output:

```bash
buildconfig.build.openshift.io/pipeline created
```
{{% /panel %}}

{{% panel "Web Console Steps" %}}

> Use the following OpenShift build configuration to create the pipeline.

```bash
kind: "BuildConfig"
apiVersion: "build.openshift.io/v1"
metadata:
  name: "pipeline"
spec:
  strategy:
    jenkinsPipelineStrategy:
      jenkinsfile: |-
        pipeline {
          agent any
          stages {
            stage('buildFrontEnd') {
              steps {
                script {
                  openshift.withCluster() {
                    openshift.withProject() {
                      openshift.selector("bc", "frontend").startBuild("--wait=true", "--follow")
                    }
                  }
                }
              }
            }
            stage('deployFrontEnd') {
              steps {
                script {
                  openshift.withCluster() {
                    openshift.withProject() {
                      openshift.selector("dc", "frontend").rollout().latest()
                    }
                  }
                }
              }
            }
            stage('promoteToProd') {
              steps {
                script {
                  timeout(time: 15, unit: 'MINUTES') {
                    input message: "Promote to PROD?", ok: "Promote"
                  }
                  openshift.withCluster() {
                    openshift.withProject() {
                      openshift.tag("origin-nodejs-sample:latest", "origin-nodejs-sample:prod")
                    }
                  }
                }
              }
            }
            stage('scaleUp') {
              steps {
                script {
                  openshift.withCluster() {
                    openshift.withProject() {
                      openshift.selector("dc", "frontend-prod").scale("--replicas=2")
                    }
                  }
                }
              }
            }
          }
        }
```

> Choose *+Add* -> *YAML*, from *Developer* mode

<img src="../images/ocp-lab-cicd-import-yaml.png" width="900">

> Then copy and paste the above build configuration definition and choose "Create".

<img src="../images/ocp-lab-cicd-import-yaml-dialog.png" width="900">

{{% /panel %}}

{{< /panel_group >}}

## Start the pipeline

> Using the OpenShift Web Console, in "Administrator" mode, choose *Builds* -> *Build Configs*, and then click on "pipeline"

<img src="../images/ocp-lab-cicd-start-pipeline.png" width="900">

> From the "Actions" menu, choose "Start Build"

<img src="../images/ocp-lab-cicd-pipeline-actions-start_build.png" width="200">

When the pipeline starts, OpenShift uploads the pipeline to the Jenkins server for execution. As it runs, the various stages trigger OpenShift to build and deploy the frontend microservice. After a Jenkins user approves the frontend deployment, Jenkins triggers OpenShift to tag the image stream with the ":prod" tag then scales the frontend-prod deployment for (2) replicas.

The Jenkins dashboard should indicate that a new build is executing.

<img src="../images/ocp-lab-cicd-jenkins-build-exec-status.png">

Back in the OpenShift Web Console, watch the pipeline execute. Once the "deployFrontEnd" stage completes, you should be able to visit the route for the frontend service in a web browser.

<img src="../images/ocp-lab-cicd-pipeline-input.png">

> Click on "Input Required" and you should get redirected to the Jenkins Web Console

> Click on "Paused for Input", in the left-side menu

<img src="../images/oc-lab-cicd-jenkins-pausedForInput.png">

> You can now approve the deployment to the PROD environment

<img src="../images/ocp-lab-cicd-jenkins-promote.png">

> Now return to the OpenShift Web Console and watch the pipeline finish.

<img src="../images/ocp-lab-cicd-pipeline-stages.png">

> Confirm the *frontend-prod* has deployed 2 pods.

<img src="../images/ocp-lab-cicd-dc-frontend-prod.png" width="900">

> Now *create a secure route* with TLS edge termination the *frontend-prod* service so the application can be visited.

> Go to *Networking* -> *Routes*, and click 
<img src="../images/ocp-create-route-button.png" width="100">

<img src="../images/ocp-lab-cicd-routes.png" width="900">

> Fill out the form, as shown, and then click
<img src="../images/ocp-create-button.png" width="100">

<img src="../images/ocp-lab-cicd-route-tls.png" width="900">

## Confirm both the test and production services are available

> Browse to both services

{{< panel_group >}}

{{% panel "CLI Steps" %}}

Use the `oc get routes` command to get the HOST/PORT (URLs) needed to access the frontend and frontend-prod services. Your HOST/PORT values will differ
from the example below.

```bash
$ oc get routes
NAME            HOST/PORT                                          PATH   SERVICES        PORT    TERMIN
ATION     WILDCARD
frontend        frontend-cicd-1.apps.alexocp43.redhatgov.io               frontend        <all>   edge
          None
frontend-prod   frontend-prod-cicd-1.apps.alexocp43.redhatgov.io          frontend-prod   web     edge/R
edirect   None
jenkins         jenkins-cicd-1.apps.alexocp43.redhatgov.io                jenkins         <all>   edge/R
edirect   None
```

Use a web browser to visit the HOST/PORT (URLs) for the frontend and frontend-prod services. Don't forget the ```https://``` prefix.

Alternately, you can use *curl*, right from your terminal

```bash
$ curl -k https://frontend-prod-cicd-1.apps.alexocp43.redhatgov.io 2>/dev/null | head -6
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <title>Welcome to OpenShift</title>
```

{{% /panel %}}

{{% panel "Web Console Steps" %}}

<blockquote>
In "Developer" mode, select the "cicd-1" project, and click on "Topology"
</blockquote>

<img src="../images/ocp-lab-cicd-jenkins-app-overview.png" width="900"><br/>

<blockquote>
Click on the arrow, at the upper right corner of the "frontend-prod" icon, to launch the web page
<img src="../images/ocp-launch-button.png" width="50"><br/>
</blockquote>

{{% /panel %}}

{{< /panel_group >}}

Service web page displayed:

<img src="../images/ocp-lab-cicd-app-test.png"><br/>

## Edit the pipeline.

> Now make a change to the pipeline. For example, in the *scaleUp* stage, change the number
of replicas to 3.

Technically speaking, a rebuild from source is not needed to scale up a deployment. We use
this simple example to illustrate how a pipeline may be edited within OpenShift.

{{< panel_group >}}

{{% panel "CLI Steps" %}}

If you are comfortable using the **vi** editor:

~~~bash
oc edit bc/pipeline
~~~

Here is an excerpt from the file, showing the necessary change:

```bash
            stage('scaleUp') {
              steps {
                script {
                  openshift.withCluster() {
                    openshift.withProject() {
                      openshift.selector("dc", "frontend-prod").scale("--replicas=3")
```

{{% /panel %}}

{{% panel "Web Console Steps" %}}

<img src="../images/ocp-lab-cicd-pipeline-edit.png">

{{% /panel %}}

{{< /panel_group >}}

> Save your changes and run the pipeline again to confirm the *frontend-prod* deployment has
deployed 3 pods.

<img src="../images/ocp-lab-cicd-app-3-pods.png" width="900">

# Summary
In this lab you have very quickly and easily constructed a basic Build/Test/Deploy pipeline. Although our example was very basic it introduces you to a powerful DevOps feature of OpenShift through the leveraging of Jenkins. This can be extended to support complex real-world continuous delivery requirements. Read more about the use of Jenkins on OpenShift [here][3] and more about Jenkins [here][4].

[1]: https://jenkins.io/doc/book/pipeline/
[2]: https://github.com/openshift/jenkins-plugin
[3]: https://docs.openshift.com/enterprise/latest/using_images/other_images/jenkins.html
[4]: https://jenkins.io/doc

{{< importPartial "footer/footer.html" >}}
