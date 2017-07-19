---
title: Lab 5 - Using RHMAT Web Console
workshops: jboss-migration-toolkit
workshop_weight: 50
layout: lab
---

# About Red Hat Application Migration Toolkit CLI
The web console for Red Hat Application Migration Toolkit is a web-based system that allows a team of users to assess and prioritize migration and modernization efforts for a large number of applications. It allows you to group applications into projects for analysis and provides numerous reports that highlight the results. 

{{% alert warning %}}
The following instructions are only when you are doing this lab outside of the controlled workshop.  The workshop environment has downloaded, installed, and configured your student environments prior to commencement of this workshop session.
{{% /alert %}}

# Set Up
1. Install the Java SE Development Kit (JDK) version 8. We recommend using the OpenJDK or the Oracle JDK.
2. Install the RHAMT web console.
  a. Download the [ZIP archive][1].
  b. Extract the ZIP archive.

~~~~
$ unzip migrationtoolkit-rhamt-web-console-4.0.0.Beta2.1.zip
~~~~

## Step 1. Start the web console.

~~~~
$ ./rhamt-web-distribution-4.0.0.Beta2.1/run_rhamt.sh
~~~~

## Step 2. Access the web console.
Go to http://jboss-migration-toolkit.{student number}.demo-dlt.com:8080/rhmat-web

<img src="../images/web-login.png" width="1000" />

By default, the web console uses a rhamt user to automatically authenticate. See [Configuring Authentication][1] for the Web Console to require individual users to authenticate in order to access the web console. 

## Step 3. Analyze your migration project
Now that the RHAMT web console is installed, you’re ready to try it out. We’ll show you how to set up a project, add a sample WebLogic application, and analyze the application to identify the changes necessary to migrate it to JBoss EAP 7.

In order to use the web console to analyze applications, you must create a project, which is a way to group applications for analysis. Each project specifies the settings to use during the analysis of its applications. Reports that provide information about the changes necessary for a migration or modernization effort are generated during the analysis. 

1. Download the sample application, simple-sample-app.ear, to your file system.

2. Add a migration project.
> When you first access the web console, you will be prompted to set up a new project.

<img src="../images/web-no-projects.png" width="1000" />

  a. From the welcome page, click New Project.

<img src="../images/web-add-project.png" width="1000" />

  b. Enter a name for the project and press Next.

3. Add the sample application to the project.
Specify the applications to add to this project. You can either upload applications or register a server path that contains applications.  You can can use the Choose files button to select applications, or you can drag and drop applications into the area provided. This uploads the selected applications to the server. 

<img src="../images/web-add-apps.png" width="1000" />

  a. Click Choose files, select the downloaded simple-sample-app.ear file, and click Next.

<ALERT>
You could also select the Server Path tab and enter a path on the server that contains applications to be included in this project. If the specified directory contains multiple applications, be sure to check the Directory Contains Multiple Apps checkbox. 
</ALERT>

4. Specify the settings for the analysis.

<img src="../images/web-configure-analysis.png" width="1000" />

  a. Select the Migration to Red Hat JBoss EAP 7 transformation path.

  b. Click the checkboxes to include the com.acme package.

  c. Once the packages have loaded, click the checkboxes to select the com.acme package for this analysis.

> You can also check the Cloud readiness analysis checkbox to assess your applications for cloud and container environments. 

5. Click Save & Run to execute the analysis.

6. View the results of the analysis.

<img src="../images/web-analysis-list.png" width="1000" />

  a. From the Analysis page, you can watch the progress of the execution.

  b. Click on the analysis ID to review details from the analysis execution, such as its status and log output.

  c. From the Analysis page, click the graph icon in the Actions column to open the reports.

7. Review the reports.

  a. In the Application List, take note of the story points identified for the simple-sample-app.ear application. This helps you assess the level of effort required to migrate this application.

  b. Click the simple-sample-app.ear link.

  c. Click the Migration Issues link in the top navigation bar. This report shows a summary of all migration issues identified in the application.

  d. Click on an issue to show the list of files that contain the issue.

  e. Click the file name to view the file contents.

  f. The line of code affected by the issue is highlighted and information about the issue and how to resolve it are displayed.

  g. See the [Review the Reports][2] section of the RHAMT CLI Guide to learn more about examining other available reports.

# Summary
Now that you’ve learned how to use the web console to analyze a sample application, start setting up your projects in the web console to analyze your applications for your migration or modernization effort!

[1]: https://access.redhat.com/documentation/en-us/red_hat_application_migration_toolkit/4.0.beta2/html-single/web_console_guide/#config_auth
[2]: https://access.redhat.com/documentation/en-us/red_hat_application_migration_toolkit/4.0.beta2/html-single/cli_guide/#review_reports
[3]: https://access.redhat.com/documentation/en-us/red_hat_application_migration_toolkit/4.0.beta2/html-single/cli_guide/#command_line_arguments
