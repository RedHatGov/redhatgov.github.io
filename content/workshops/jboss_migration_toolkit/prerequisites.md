---
title: Prerequisites
workshops: jboss_migration_toolkit
workshop_weight: 10
layout: lab
---

:imagesdir: /workshops/jboss_migration_toolkit/images
:source-highlighter: highlight.js
:source-language: yaml

# System Requirements

## Software

* Java Platform, JRE 8+
* RHAMT is tested on Linux, Mac OS X, and Windows. Other operating systems with Java 8+ support should work equally well. 

## Hardware
The following memory and disk space requirements are the minimum needed to run RHAMT. If your application is very large or you need to evaluate multiple applications, you may want to increase these values to improve performance.

For tips on how to optimize performance, see the Optimize RHAMT Performance section of the [RHAMT CLI Guide][1]. 

* A minimum of 4 GB RAM. For better performance, a quad-core processor with 8 GB RAM is recommended. This allows 3 - 4 GB RAM for use by the JVM. 
* A minimum of 4 GB of free disk space. A fast disk, especially a solid-state drive (SSD), should improve performance. 

{{% alert info %}}
All of that is being handled for you and you can **focus on the content of your workshop**.
{{% /alert %}}


# Supported Migration Paths
RHAMT supports application migration from several platforms to Red Hat JBoss Enterprise Application Platform (JBoss EAP). See the below table for which JBoss EAP version is currently supported by RHAMT for direct migration from your source platform. 

| Source Platform | Migration to JBoss EAP 6 | Migration to JBoss EAP 7 |
| --------------- |:------------------------:|:------------------------:|
| Oracle Weblogic |       [checkmark]        |       [checkmark]        |
| IBM WebSphere   |       [checkmark]        |       [checkmark]        |
| JBoss EAP 4     |       [checkmark]        |       X                  |
| JBoss EAP 5     |       [checkmark]        |       [checkmark]        |
| JBoss EAP 6     |       N/A                |       [checkmark]        |

X - Although RHAMT does not currently provide rules for this migration path, Red Hat Consulting can assist with migration from any source platform.

[1]: https://access.redhat.com/documentation/en-us/red_hat_application_migration_toolkit/4.0.beta2/html-single/cli_guide/#optimize_performance
