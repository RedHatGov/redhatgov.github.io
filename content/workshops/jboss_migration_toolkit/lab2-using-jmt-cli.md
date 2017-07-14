---
title: Lab 2 - Using RHMAT CLI
workshops: jboss-migration-toolkit
workshop_weight: 20
layout: lab
---

# About Red Hat Application Migration Toolkit CLI
The CLI is a command-line tool in the Red Hat Application Migration Toolkit that allows users to assess and prioritize migration and modernization efforts for applications. It provides numerous reports that highlight the analysis results. The CLI is for advanced users with highly customized needs looking for fine-grained control of RHAMT analysis options or to integrate with external automation tools. 

{{% alert warning %}}
These instructions are only when you are doing this lab outside of the controlled workshop.  The workshop environment has downloaded, installed, and configured your student environments prior to commencement of this workshop session.
{{% /alert %}}

# Set Up
1. Install the Java SE Development Kit (JDK) version 8. We recommend using the OpenJDK or the Oracle JDK.
2. Install the RHAMT CLI.
  a. Download the [ZIP archive][1].
  b. Extract the ZIP archive.

~~~~
$ unzip migrationtoolkit-rhamt-cli-4.0.0.Beta2.1.zip
~~~~

# Analyze your first application
Now that the RHAMT CLI is installed, you’re ready to try it out. We’ll show you how to run the CLI to analyze a sample WebLogic application to identify the changes necessary to migrate it to JBoss EAP 7.

1.  Download the sample application, [simple-sample-app.ear][2], to your file system.
2.  Run the CLI with the necessary options.
  a. Navigate into the rhamt-cli-4.0.0/bin/ directory
  b. Execute the CLI with the necessary options.

~~~~
$ ./rhamt-cli --input /path/to/simple-sample-app.ear --output /path/to/output/ --source weblogic --target eap:7 --packages com.acme
~~~~

  This command uses the following options:
  * --input: Path to the application to analyze.
  * --output: Output directory for the generated reports.
  * --source: Source technology of the application.
  * --target: Target technology for the application migration.
  * --packages: List of packages to evaluate.

> Refer to [RHMAT Command-Line Arguments][3] for a full list of available capabilities.

3.  Open the generated report.
  a. The location of the report is displayed in your terminal once the execution is complete.

~~~~
Report created: /var/www/html
   Access it at this URL: file:///path/to/output/
~~~~

  b. Open the report in a browser http://jboss-migration-toolkit.{student number}.demo-dlt.com 

4.  Review the reports.
  a. In the Application List, take note of the story points identified for the simple-sample-app.ear application. This helps you assess the level of effort required to migrate this application.
  b. Click the simple-sample-app.ear link.
  c. Click the Migration Issues link in the top navigation bar. This report shows a summary of all migration issues identified in the application.
  d. Click on an issue to show the list of files that contain the issue.
  e. Click the file name to view the file contents.
  f. The line of code affected by the issue is highlighted and information about the issue and how to resolve it are displayed.
  g. See the Review the Reports section of the [RHAMT CLI Guide][2] to learn more about examining other available reports.

# Summary
After successfully executing RHMAT against the application archive, you should now be ready to review the assessment report.

[1]: https://developers.redhat.com/download-manager/file/migrationtoolkit-rhamt-cli-4.0.0.Beta2.1-offline.zip
[2]: https://access.redhat.com/documentation/en-us/red_hat_application_migration_toolkit/4.0.beta2/html-single/cli_guide/#review_reports
[3]: https://access.redhat.com/documentation/en-us/red_hat_application_migration_toolkit/4.0.beta2/html-single/cli_guide/#command_line_arguments
