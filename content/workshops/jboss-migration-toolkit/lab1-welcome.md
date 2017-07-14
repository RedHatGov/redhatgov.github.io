---
title: Lab 1 - Welcome
workshops: jboss-migration-toolkit
workshop_weight: 11
layout: lab
---

# Welcome to JBoss Migration Toolkit!
This lab introduces you to the key tool for assessing activities needed to migrate to JBoss EAP.  The labs will provide you various ways to initiate the assessment using the console to help you get familiar with the user interface.  These labs are designed for engineers, consultants, and others who plan to use Windup to migrate Java applications or other components.

##  What is Red Hat Application Migration Toolkit?
Red Hat Application Migration Toolkit is an assembly of open source tools that enables large-scale application migrations and modernizations. The tooling consists of multiple individual components that provide support for each phase of a migration process. The migrations supported include application platform upgrades, migrations to a cloud-native deployment environment, and also migrations from several commercial products to the Red Hat JBoss Enterprise Application Platform.

###  Command Line Tooling
The Command line interface provides an advanced interface for performing batch analysis of many applications in an automated manner. This interface can provide detailed assessment reports that can be fed into a full assessment of the applications for prioritization and planning.

###  Web Console
The Web Console provides a simplified interface for managing large volumes of applications for assessment and analysis purposes. With this tool, the user can manage a large number of applications in order to efficiently prioritize and plan which applications to migrate, as well as to assess the difficulty involved in each migration.

###  Eclipse Tooling
Eclipse Plugin provides interactive, implementation time assistance for developers. This streamlines the process of migrating applications by providing inline help as well as fully automated quick fixes that automate complex steps within the migration and modernization process.

## How Does Red Hat Application Migration Toolkit Simplify Migration?
Red Hat Application Migration Toolkit looks for common resources and highlights technologies and known trouble spots when migrating applications. The goal is to provide a high-level view into the technologies used by the application and provide a detailed report organizations can use to estimate, document, and migrate enterprise applications to Java EE and Red Hat JBoss Enterprise Application Platform. 

# RHMAT Features
Red Hat Application Migration Toolkit (RHAMT) provides a number of capabilities to assist with planning and executing migration projects. 

##  Planning and work estimation
RHAMT assists project managers by detailing the type of work and estimation of effort to complete the tasks. Level of effort is represented in RHAMT reports as story points. Actual estimates will be based on the skills required and the classification of migration work needed. 

##  Identifying migration issues and providing solutions
RHAMT identifies migration issues and highlights specific points in the code where an issue occurs. RHAMT suggests code changes and provides additional resources to help engineers resolve the specific issue. 

##  Detailed Reporting
RHAMT produces numerous reports to give both high-level views of the migration effort and details of specific migration tasks. You can view migration issues across all applications, charts and summary information about issues in an application, a breakdown of issues by module in the application, reports of technologies used, and dependencies on other applications and services. You can also examine source files to see the line of code where an issue occurs. See the [CLI Guide][1] for more information on the available RHAMT reports. 

##  Built-in rules and migration paths
RHAMT comes with a core set of rules to provide migration assistance for several common [migration paths][2]. These rules identify the use of proprietary functionality from other application servers or deprecated subsystems from previous versions of JBoss EAP. RHAMT also contains rules to identify common migration issues, such as hard-coded IP addresses and JNDI lookups. 

##  Rule extensibility and customization
RHAMT provides the ability to create powerful and complex rules. You can expand upon the core set of rules provided by RHAMT and create rules to identify additional issues that are important for your migration project. You can also override core rules and create custom rule categories. See the [Rules Development Guide][3] for more information on customizing RHAMT rules. 

##  Ability to analyze source code or application archives
RHAMT can evaluate application archives or source code, and can evaluate multiple applications together. It can identify archives that are shared across multiple applications, which can help with more accurate effort estimation. 

# RHMAT Rules
 Red Hat Application Migration Toolkit (RHAMT) contains rule-based migration tools that analyze the APIs, technologies, and architectures used by the applications you plan to migrate. In fact, the RHAMT analysis process is implemented using RHAMT rules. RHAMT uses rules internally to extract files from archives, decompile files, scan and classify file types, analyze XML and other file content, analyze the application code, and build the reports.

RHAMT builds a data model based on the rule execution results and stores component data and relationships in a graph database, which can then be queried and updated as needed by the migration rules and for reporting purposes. 

RHAMT rules use the following rule pattern: 

~~~~
  when(condition)
      perform(action)
  otherwise(action)
~~~~

RHAMT provides a comprehensive set of standard migration rules out-of-the-box. Because applications may contain custom libraries or components, RHAMT allows you to write your own rules to identify use of components or software that may not be covered by the existing ruleset. If you plan to write your own custom rules, see the [Rules Development Guide][3] for detailed instructions. 

# Who is this worksop designed to inform?
This workshop is for engineers, consultants, and others who want to use Red Hat Application Migration Toolkit (RHAMT) to migrate Java applications or other components. It provides an overview of the Red Hat Application Migration Toolkit and how to get started using the tools to plan and execute your migration. 

# Story Points
Story points are an abstract metric commonly used in Agile software development to estimate the level of effort needed to implement a feature or change.

Red Hat Application Migration Toolkit uses story points to express the level of effort needed to migrate particular application constructs, and the application as a whole. It does not necessarily translate to man-hours, but the value should be consistent across tasks. 

## How Story Points are Estimated in Rules
Estimating the level of effort for the story points for a rule can be tricky. The following are the general guidelines RHAMT uses when estimating the level of effort required for a rule.

| Level of Effort | Story Points  | Description                                                                                         | 
| --------------- | :-----------: | --------------------------------------------------------------------------------------------------- |
| Information     | 0             | An informational warning with very low or no priority for migration.                                |
| Trivial         | 1             | The migration is a trivial change or a simple library swap with no or minimal API changes.          |
| Complex         | 3             | The changes required for the migration task are complex, but have a documented solution.            |
| Redesign        | 5             | The migration task requires a redesign or a complete library change, with significant API changes.  |
| Rearchitecture  | 7             | The migration requires a complete rearchitecture of the component or subsystem.                     |
| Unknown         | 13            | The migration solution is not known and may need a complete rewrite.                                |

## Task Severity
In addition to the level of effort, you can categorize migration tasks to indicate the severity of the task. The following categories are used to indicate whether a task must be completed or can be postponed. 

### Mandatory
The task must be completed for a successful migration. If the changes are not made, the resulting application will not build or run successfully. Examples include replacement of proprietary APIs that are not supported in the target platform. 
### Optional
If the migration task is not completed, the application should work, but the results may not be the optimal. If the change is not made at the time of migration, it is recommended to put it on the schedule soon after migration is completed. An example of this would be the upgrade of EJB 2.x code to EJB 3. 

For more information on categorizing tasks, see [Using Custom Rule Categories][4] in the [Rules Development Guide][3]. 

# Summary
You should now be ready to get hands-on with our workshop labs.

[1]: https://access.redhat.com/documentation/en-us/red_hat_application_migration_toolkit/4.0.beta2/html-single/cli_guide/
[2]: https://access.redhat.com/documentation/en-us/red_hat_application_migration_toolkit/4.0.beta2/html/getting_started_guide/supported_configurations#migration_paths
[3]: https://access.redhat.com/documentation/en-us/red_hat_application_migration_toolkit/4.0.beta2/html-single/rules_development_guide/
[4]: https://access.redhat.com/documentation/en-us/red_hat_application_migration_toolkit/4.0.beta2/html-single/rules_development_guide/#rule_categories

