---
title: Key Terms
workshops: openshift_4_101
workshop_weight: 2
layout: lab
---

# Key Terms
We will be using the following terms throughout the workshop labs; so, here are some basic definitions you should be familiar with.  You'll learn more terms along the way; but, these are the basics to get you started.

* Container - Your software wrapped in a complete filesystem containing everything it needs to run
* Image - We are talking about docker images; read-only and used to create containers
* Image Stream - An image stream comprises one or more OCI images identified by tags. 
* Pod - One or more docker containers that run together
* Service - Provides a common DNS name to access a pod (or replicated set of pods)
* Project - A project is a group of services that are related logically
* Deployment - an update to your application triggered by a image change or config change
* Build - The process of turning your source code into a runnable image
* BuildConfig - configuration data that determines how to manage your build
* Route - a labeled and DNS mapped network path to a service from outside OpenShift
* Operator - A method of packaging, deploying and managing a Kubernetes application
* Cluster masters - The foreman of the OpenShift architecture, the master schedules operations, watches for problems, and orchestrates everything
* Cluster worker - Where the compute happens, your software is run on worker nodes

