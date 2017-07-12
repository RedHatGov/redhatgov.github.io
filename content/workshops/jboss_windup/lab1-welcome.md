---
title: Lab 1 - Welcome
workshops: jboss_windup
workshop_weight: 11
layout: lab
---

# Welcome to JBoss Windup!
This lab introduces you to the key tool for assessing activities needed to migrate to JBoss EAP.  The labs will provide you various ways to initiate the assessment using the console to help you get familiar with the user interface.  These labs are designed for engineers, consultants, and others who plan to use Windup to migrate Java applications or other components.

# Key Terms
We will be using the following terms throughout the workshop labs so here are some basic definitions you should be familiar with.  You'll learn more terms along the way, but these are the basics to get you started.

* **Rule** - A piece of code that performs a single unit of work during the migration process. Depending on the complexity of the rule, it may or may not include configuration data. Extensive configuration information may be externalized into external configuration, for example, a custom XML file. The following is an example of a Java-based rule added to the JDKConfig RuleProvider class.

{{< panel_group >}}
{{% panel "Example Rule" %}}

~~~~
.addRule()

.when(JavaClass.references("java.lang.ClassLoader$").at(TypeReferenceLocation.TYPE))
    .perform(Classification.as("Java Classloader, must be migrated.")
    .with(Link.to( "Red Hat Customer Portal: How to get resources via the ClassLoader in a JavaEE application in JBoss EAP", "https://access.redhat.com/knowledge/solutions/239033"))
     .withEffort(1))
~~~~

{{% /panel %}}
{{< /panel_group >}}


* **RuleProvider** - An implementation of OCPSoft ConfigurationProvider class specifically for Windup. It provides Rule instances and the relevant RuleProviderMetadata for those Java-based and XML-based Rule instances.
* **Ruleset** - A ruleset is a group of one or more RuleProviders that targets a specific area of migration, for example, Spring → Java EE 6 or WebLogic → JBoss EAP . A ruleset is packaged as a JAR and contains additional information needed for the migration, such as operations, conditions, report templates, static files, metadata, and relationships to other rulesets. The following Windup projects are rulesets: rules-java-ee and rules.xml
* **Rules Metadata** - Information about whether a particular ruleset applies to a given situation. The metadata can include the source and target platform and frameworks.
* **Rules Pipeline** - A collection of rules that feed information into the knowledge graph.
* **Level of Effort** - The effort required to complete the migration task.  Level of effort is represented as story points in the Windup reports.
* **Story Point** - A term commonly used in Scrum Agile software development methodology to estimate the level of effort needed to implement a feature or change. It does not necessarily translate to man-hours, but the value should be consistent across tasks. 

# What is Windup?
Windup is an extensible and customizable rule-based tool that helps simplify migration of Java applications. Windup examines application artifacts, including project source directories and applications archives, then produces an HTML report highlighting areas that need changes. Windup can be used to migrate Java applications from previous versions of Red Hat JBoss Enterprise Application Platform or from other containers, such as Oracle WebLogic Server or IBM® WebSphere® Application Server.

##  How Does Windup Simplify Migration?
Windup looks for common resources and highlights technologies and known “trouble spots” when migrating applications. The goal is to provide a high level view into the technologies used by the application and provide a detailed report organizations can use to estimate, document, and migrate enterprise applications to Java EE and JBoss EAP.


##  Features of Windup
### Shared Data Model
Windup creates a shared data model graph that provides the following benefits.
* It enables complex rule interaction, allowing rules to pass findings to other rules.
* It enables 3rd-party plug-ins to interact with other plug-ins, rules and reports.
* The findings in data graph model can be searched and queried during rule execution and used for reporting purposes.

### Extensibility
Windup can be extended by developers, users, and 3rd-party software.
* It provides a plug-in API to inject other applications into Windup.
* It enables 3rd-parties to create simple POJO plug-ins that can interact with the data graph.
* Means we don’t have to invent everything. Users with domain knowledge can implement their own rules.

### Better Rules
Windup provides more powerful and complex rules.
* XML-based rules are simple to write and and easy to implement.
* Java-based rule add-ons are based on OCPsoft Rewrite and provide greater flexibility and power creating when rules
* Rules can now be nested to handle more complex situations. This means you can nest simple statements rather than use complex XPATH or REGEX expressions. *Rules can be linked using and/or statements 

### Automation
Windup has the ability to automate some of the migration processes.
* Windup is integrated with Forge 2, meaning it can generate projects, libraries, and configuration files.
* Rules can create Forge inputs and put them into the data graph.
* During the automation phase, the data graph inputs can be processed to generate a new project.

### Work Estimation
Estimates for the level of effort are based on the skills required and the classification of migration work needed. Level of effort is represented as story points in the Windup reports.

### Better Reporting
Windup reports are now targeted for specific audiences.
* IT Management - Applications are ranked by cost of migration.
* Project Management - Reports detail the type of work and estimation of effort to complete the tasks.
* Developers - An Eclipse plug-in provides hints and suggested code changes within the IDE.

# Summary
You should now be ready to get hands-on with our workshop labs.
