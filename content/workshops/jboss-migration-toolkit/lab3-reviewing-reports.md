---
title: Lab 3 - Reviewing RHMAT CLI Reports
workshops: jboss-migration-toolkit
workshop_weight: 30
layout: lab
---

# Review the Reports
The report examples shown in the following sections are a result of analyzing the `com.acme and org.apache` packages in the `jee-example-app-1.0.0.ear` example application, which is located in the RHAMT GitHub source repository. The report was generated using the following command. 

## Prerequisites

Successful completion of the previous lab

## Step 1. Open the RHMAT Report Landing Page
Use a browser to open the `http://jboss-migration-toolkit.{student number}.demo-dlt.com/index.html` file located in the report output directory. This opens a landing page that lists the applications that were processed. Each row contains a high-level overview of the story points, number of incidents, and technologies encountered in that application. 

<img src="../images/report-jee-example-application-list-page.png" width="1000" />

1. Click on the name of the application, jee-example-app-1.0.0.ear, to view the application report. The following table lists all of the reports that can be access from this main RHAMT landing page. 

## Step 2. Explore Application Report
The Application Report  The application report page gives an overview of the entire application migration effort. It summarizes:

  * The incidents and story points by category (Mandatory, Optional, or Potential Issues)
  * The incidents and story points by level of effort of the suggested changes
  * The incidents by package 

<img src="../images/report-jee-example-application-report-index-page.png" width="1000" />

At the bottom of the page is a list of reports that contain additional details about the migration of this application. 

> Note that only those reports that are applicable to the current application will be available. 

| Report                 | Description                                                         |
| ---------------------- | --------------------------------------------------------------------|
| Migration Issues        | Provides a concise summary of all issues that require attention.    | 
| Application Details     | Provides a detailed overview of all resources found within the application that may need attention during the migration. |
| Unparsable              | Shows all files that RHAMT could not parse in the expected format. For instance, a file with a .xml or .wsdl suffix is assumed to be an XML file. If the XML parser fails, the issue is reported here and also where the individual file is listed.  |
| Dependencies            | Displays all Java-packaged dependencies found within the application.  |
| Remote Services         | Displays all remote services references that were found within the application.  |
| EJBs                    | Contains a list of EJBs found within the application. |
| JBPM                    | Contains all of the JBPM-related resources that were discovered during analysis. |
| JPA                     | Contains details on all JPA-related resources that were found in the application. |
| Hibernate               | Contains details on all Hibernate-related resources that were found in the application. |
| Server Resources        | Displays all server resources (for example, JNDI resources) in the input application. |
| Spring Beans            | Contains a list of Spring beans found during the analysis. |
| Hard-coded IP Addresses | Provides a list of all hard-coded IP addresses that were found in the application. |
| Ignored Files           | Lists the files found in the application that, based on certain rules and RHAMT configuration, were not processed. See the --userIgnorePath option for more information. |
| About                   | Describes the current version of RHAMT and provides helpful links for further assistance. |

## Step 3. Explore Application Details Report
The Application Details Report lists the story points, the Java incidents by package, and a count of the occurrences of the technologies found in the application. Next is a display of application messages generated during the migration process. Finally, there is a breakdown of this information for each archive analyzed during the process. 

1. Access this report from the report index by clicking the `Application Details` link. 

<img src="../images/report-jee-example-application-details.png" width="1000" />

2. Expand the jee-example-app-1.0.0.ear/jee-example-services.jar to review the story points, Java incidents by package, and a count of the occurrences of the technologies found in this archive. This summary begins with a total of the story points assigned to its migration, followed by a table detailing the changes required for each file in the archive. The report contains the following columns. 

| Column Name  | Description                                                          |
| ------------ | -------------------------------------------------------------------- |
| Name         | The name of the file being analyzed.                                 
| Technology   | The type of file being analyzed, for example: Java Source, Decompiled Java File, Manifest, Properties, EJB XML, Spring XML, Web XML, Hibernate Cfg, Hibernate Mapping  |
| Issues       | Warnings about areas of code that need review or changes.            | 
| Story Points | Level of effort required to migrate the file. See Rule Story Points for more details. |

> Note that if an archive is duplicated several times in an application, it will be listed just once in the report and will be tagged with [Included Multiple Times]. 

<img src="../images/duplicate-archive-app-report.png" width="1000" />

The story points for archives that are duplicated within an application will be counted only once in the total story point count for that application. 

## Step 3. Explore the Source Report
The analysis of the `jee-example-services.jar` lists the files in the JAR and the warnings and story points assigned to each one. 

1. Notice the `com.acme.anvil.listener.AnvilWebLifecycleListener` file, at the time of this test, has 22 warnings and is assigned 16 story points. 

2. Click on the file link to see the detail. 
  * The Information section provides a summary of the story points and notes that the file was decompiled by RHAMT.
  * This is followed by the file source code listing. Warnings appear in the file at the point where migration is required. 

3. Notice the warnings that appear at various import statements, declarations, and method calls. Each warning describes the issue and the action that should be taken. 

<img src="../images/report-jee-example-source-1.png" width="1000" />

## Step 4. Explore the Archives Shared by Multiple Applications Report
Access these reports from the report landing page by clicking the Archives shared by multiple applications link. Note that this link is only available if there are applicable shared archives. 

1. Go to the landing page, review the report.

<img src="../images/shared-archives-app-list.png" width="1000" />

## Step 5. Explore the Rule Provider Execution Report
Access this report from the report landing page by clicking the Executed rules overview link.  This report provides the list of rules that executed when running the RHAMT migration command against the application.

1. Go to the landing page, review the report.

<img src="../images/report-jee-example-ruleprovider.png" width="1000" />

## Step 6. Review the Red Hat Application Migration Toolkit FreeMarker Functions and Directives
Access this report from the report landing page by clicking the Red Hat Application Migration Toolkit FreeMarker methods link. This report lists all the registered functions and directives that were used to build the report. It is useful if you plan to build your own custom report or for debugging purposes. 

1. Go to the landing page, review the report.

<img src="../images/report-jee-example-freemarker-and-directives.png" width="1000" />

## Step 7. Explore the Send Feedback Form
Access this feedback form from the report landing page by clicking the Send feedback link.  This form allows you to rate the product, talk about what you like and suggestions for improvements. 

1. Go to the landing page, review the report.

<img src="../images/report-jee-example-send-feedback.png" width="800" />

## Step 8. Export the Report in CSV Format
RHAMT provides the ability to export the report data, including the classifications and hints, to a flat file on your local file system. The export function currently supports the CSV file format, which presents the report data as fields separated by commas (,).  The CSV file can be imported and manipulated by spreadsheet software such as Microsoft Excel, OpenOffice Calc, or LibreOffice Calc. Spreadsheet software provides the ability to sort, analyze, evaluate, and manage the result data from a RHAMT report. 

1. Export the report. To export the report into a CSV file, run RHAMT with --exportCSV argument. The CSV file will be created in the directory specified by the --output argument. 

Example:

~~~~
$ ./rhamt-cli --input /path/to/jee-example-app-1.0.0.ear --output /path/to/output/ --source weblogic --target eap:7 --packages com.acme --exportCSV 
~~~~

2. The CSV formatted output file contains the following data fields:

| Item         | Description                                                                                                                          |
| ------------ | ------------------------------------------------------------------------------------------------------------------------------------ |
| Rule Id      | The ID of the rule that generated the given item.                                                                                    |
| Problem type | hint or classification                                                                                                               |
| Title        | The title of the classification or hint. This field summarizes the issue for the given item.                                         |
| Description  | The detailed description of the issue for the given item.                                                                            |
| Links        | URLs that provide additional information about the issue. A link consists of two attributes: the link and a description of the link. |
| Application  | The name of the application for which this item was generated.                                                                       |
| File Name    | The name of the file for the given item.                                                                                             |
| File Path    | The file path for the given item.                                                                                                    |
| Line         | The line number of the file for the given item.                                                                                      |
| Story points | The number of story points, which represent the level of effort, assigned to the given item.                                         |

# Conclusion
As demonstrated in this lab, RHMAT provides guidance and assistance to help the migration go smoothly and predictably.

