---
title: OpenShift 4 101 w/Dynatrace
menu:
  main:
    parent: workshops
    pre: fa fa-map-o
---

# OpenShift 4 101 w/Dynatrace

## Description 

This workshop will have you deploying and creating native docker images for a Node.js based website and learning to leverage the power of OpenShift 4 to build, deploy, scale, and automate. Additionaly, you will learn how to monitor the applications through the deployment of a Dynatrace OneAgent Operator.

## Who should attend

- Anyone who has had any exposure to Containers
- Architects
- Developers
- Technical leads
- Operations Engineers


## What you will learn

- Enabling Dynatrace OneAgent Operator and integration with Dynatrace ActiveGate (optional)
- S2I
- Rollback Replication and Recovery
- Using Labels
- CI/CD pipeline
- Blue/Green Deployment


## Introduction
Welcome to the workshop! This particular workshop will have you deploying with native docker images as well as using OpenShift to create docker images for a Node.js based website. You will also be leveraging the power of OpenShift to build, deploy, scale, and automate. In addition a Dynatrace OneAgent Operator will be installed and configured to show off the power of using Application Performance Mangement.

If you are on-site with us, the instructor will walk you through and kick off each lab.  Otherwise, if you're running this on your own, just go through the list of labs below in order (as some build off of each other).


## Labs

{{< labs openshift_4_101_dynatrace >}}

<br>


Labs 3, 4, and 6 are based on a series of labs hosted at <a href>https://github.com/marcredhat/dynatrace</a>.<br/>

{{% alert info %}}
These labs have been tailored for OpenShift v4.3
{{% /alert %}}

{{< importPartial "footer/footer.html" >}}
