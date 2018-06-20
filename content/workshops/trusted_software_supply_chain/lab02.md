---
title:  Lab 02 - CICD Project and Pods
workshops: trusted_software_supply_chain
workshop_weight: 12
layout: lab
---

# Overview of the CICD Project and running PODS
In this Workshop, you'll be building a Trusted Software Supply Chain leveraging several containerized tools such as Gogs, Nexus, Jenkins, Sonarqube, and Che.

In the OpenShift Console go to the CICD Project to the right.

Once inside the CICD Project, you will see the following PODS running.  This PODS are all leveraged in building our application.

- Che pod - Eclipse Che is an open source browser based IDE.
- Gogs pod - Gogs is an open source git server written in Go.
- Nexus pod - Nexus is an artiface repository
- Jenkins pod - Jenkins is an open source CICD tool
- Sonarqube pod - SonarQube is an open source static code analysis tool

<img src="../images/cicd-pods.png" width="900"><br/>


# The Flow of the Trusted Software Supply Chain

- Jenkins is the CICD tool that will execute the project.
- The Code is cloned from Gogs onto the Jenkins Executor Node.
- The Code is built by Jenkins using Maven
- JUnit Test are executed against the source code
- In parallel, the source code is analyzed for vulnerabilities, bugs, and bad patterns by SonarQube
- The WAR artifact is pushed to Nexus Repository manager
- A container image (tasks:latest) is built based on the tasks application WAR artifact deployed on JBoss EAP
- The tasks container image is deployed in a fresh new container in DEV project
- The DEV image is tagged with the application version (tasks:7.x) in the STAGE project
- The staged image is deployed in a fresh new container into the STAGE project

<img src="../images/pipeline.png" width="900"><br/>
