---
title: Lab 2 - Install Windup
workshops: jboss_migration_toolkit
workshop_weight: 20
layout: lab
---

# Get Started
1.  If you installed previous versions of Windup, delete the ${user.home}/.windup/ directory. Otherwise you may see errors when you execute Windup.
2.  Download the latest Windup ZIP distribution.
3.  Extract the ZIP file in to a directory of your choice.

# Execute Windup
These instructions use the replaceable variable WINDUP_HOME to refer to the fully qualified path to your Windup installation. For more information, see About the WINDUP_HOME Variable.

{{< panel_group >}}
{{% panel "About the WINDUP_HOME Variable" %}}

This documentation uses the WINDUP_HOME replaceable value to denote the path to the Windup distribution. When you encounter this value in the documentation, be sure to replace it with the actual path to your Windup installation.  
* If you download and install the latest distribution of Windup from the JBoss Nexus repository, WINDUP_HOME refers to the windup-distribution-2.3.0-Final folder extracted from the downloaded ZIP file.  
* If you build Windup from GitHub source, WINDUP_HOME refers to the windup-distribution-2.3.0-Final folder extracted from the windup-distribution/target/windup-distribution-2.3.0-Final.zip file.

{{% /panel %}}
{{< /panel_group >}}

## Run Windup
1.  Open a terminal and navigate to the WINDUP_HOME directory.
2.  The command to run Windup uses the following syntax.

~~~~
$ bin/windup --input INPUT_ARCHIVE --output OUTPUT_REPORT --packages PACKAGE_1 PACKAGE_2 PACKAGE_N
~~~~

3.  This command takes arbitrary options processed by different add-ons. The list of options in the core Windup distribution can be found in the Javadoc . Most commonly used command
line arguments are:

### --input  INPUT_ARCHIVE_OR_FOLDER
This is the fully qualified path of the application archive or folder you plan to migrate

### --output  OUTPUT_REPORT_DIRECTORY (optional)
This is the fully qualified path to the folder that will contain the the report information produced by Windup.  If omitted, the report will be generated in a INPUT_ARCHIVE_OR_FOLDER.report folder.

If the output directory exists, you will see the following error.
~~~~
***ERROR*** Files exist in /home/username/OUTPUT_REPORT_DIRECTORY, but --overwrite not specified. Aborting!
~~~~

You must specify the --overwrite argument to proceed. This forces Windup to delete and recreate the folder.
{{% alert warning %}}
Be careful not to specify a report output directory that contains important information!
{{% /alert %}}


### --source  (optional)
One or more source technologies, servers, platforms, or frameworks to migrate from.

# Summary
After successfully executing Windup against the application archive, you should now be ready to review the assessment report.
