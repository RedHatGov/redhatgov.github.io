---
title:  Lab 02 - Trusted Software Supply Chain
workshops: trusted_software_supply_chain
workshop_weight: 12
layout: lab
---

#  Overview of the Trusted Software Supply Chain

In this lab, you'll be building a Trusted Software Supply Chain that is depicted in the following

<img src="../images/pipeline.png" width="900"><br/>

# The Flow of the Trusted Software Supply Chain is the Following

- Code is cloned from Gogs, built, tested and analyzed for bugs and bad patterns
- The WAR artifact is pushed to Nexus Repository manager
- A container image (tasks:latest) is built based on the Tasks application WAR artifact deployed on JBoss EAP
- The Tasks container image is deployed in a fresh new container in DEV project
- If tests successful, the DEV image is tagged with the application version (tasks:7.x) in the STAGE project
- The staged image is deployed in a fresh new container into the STAGE project

# View CICD Project and running PODS
In the OpenShift Console go to the CICD Project to the right.

Once inside the CICD Project, you will see the following PODS running.

- che
- gogs
- nexus
- jenkins
- sonarqube

<img src="../images/cicd-pods.png" width="900"><br/>
