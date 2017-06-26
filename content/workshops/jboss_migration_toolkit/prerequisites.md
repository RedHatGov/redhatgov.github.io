---
title: Prerequisites
workshops: jboss_migration_toolkit
workshop_weight: 10
layout: lab
---

:imagesdir: /workshops/jboss_migration_toolkit/images
:source-highlighter: highlight.js
:source-language: yaml

# Getting Started

Windup is a rule-based migration tool that analyzes the APIs, technologies, and architectures used by the applications you plan to migrate. In fact, the Windup tool executes its own core set of rules through all phases of the migration process. It uses rules to extract files from archives, decompile files, scan and classify file types, analyze XML and other file content, analyze the application code, and build the reports.

Windup builds a data model based on the rule execution results and stores component data and relationships in a graph database, which can then be queried and updated as needed by the migration rules and for reporting purposes.  Windup rules use the following familiar rule pattern:

~~~~
  when(condition)
      perform(action)
  otherwise(action)
~~~~

Windup provides comprehensive set of standard migration rules out-of-the-box. Because applications may contain custom libraries or components, Windup allows you to write your own rules to identify use of components or software that may not be covered by the existing ruleset. If you plan to write your own custom rules, see the [Windup Rules Development Guide][1] for detailed instructions.

## System Requirements

### Software

* Java Platform, Enterprise Edition 7
* Windup is tested on Linux, Mac OS X, and Windows. Other Operating Systems with Java 7 support should work equally well.

### Hardware

The following memory and disk space requirements are the minimum needed to run Windup. If your application is very large or you need to evaluate multiple applications, you may want to increase these values to improve performance. 

* A minimum of 4 GB RAM. For better performance, a 4-core processor with 8 GB RAM is recommended. This allows 3 - 4 GB RAM for use by the JVM.
* A minimum of 4 GB of free disk space. A fast disk, especially a Solid State Drive (SSD), will improve performance.

All of that is being handled for you and you can **focus on the content of your workshop**.

[1]: https://access.redhat.com/documentation/en/red-hat-jboss-migration-toolkit/version-2.3/windup-rules-development-guide
