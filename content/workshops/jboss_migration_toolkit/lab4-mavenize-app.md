---
title: Lab 4 - Mavenize Your Application
workshops: jboss-migration-toolkit
workshop_weight: 40
layout: lab
---

# Overview
RHAMT provides the ability to generate an Apache Maven project structure based on the application provided. This will create a directory structure with the necessary Maven Project Object Model (POM) files that specify the appropriate dependencies.

Note that this feature is not intended to create a final solution for your project. It is meant to give you a starting point and identify the necessary dependencies and APIs for your application. Your project may require further customization. 

## Step 1. Generate the Maven Project Structure
You can generate a Maven project structure for the provided application by passing in the `--mavenize` flag when executing RHAMT. 

1. Run the following RHAMT comand using the `jee-example-app-1.0.0.ear` test application.

~~~~
$ RHAMT_HOME/bin/rhamt-cli --input /path/to/jee-example-app-1.0.0.ear --output /path/to/output --target eap:6 --packages com.acme org.apache --mavenize
~~~~

This generates the Maven project structure in the `/path/to/output/mavenized` directory.

{{% alert info %}}
You can only use the --mavenize option when providing a compiled application for the --input argument. This feature is not available when running RHAMT against source code. 
{{% /alert %}}

## Step 2. Review the Maven Project Structure
The `/path/to/output/mavenized/APPLICATION_NAME/` directory will contain the following items:

* A root POM file. This is the pom.xml file at the top-level directory.
* A BOM file. This is the POM file in the directory ending with -bom.
* One or more application POM files. Each module has its POM file in a directory named after the archive. 

The example `jee-example-app-1.0.0.ear` application is an EAR archive that contains a WAR and several JARs. There is a separate directory created for each of these artifacts. Below is the Maven project structure created for this application. 

~~~~
/path/to/output/mavenized/jee-example-app/
    jee-example-app-bom/pom.xml
    jee-example-app-ear/pom.xml
    jee-example-services2-jar/pom.xml
    jee-example-services-jar/pom.xml
    jee-example-web-war/pom.xml
    pom.xml
~~~~

Review each of the generated files and customize as appropriate for your project. To learn more about Maven POM files, see the Introduction to the POM section of the [Apache Maven documentation][1]. 

### Root POM File
The root POM file for the `jee-example-app-1.0.0.ear` application can be found at `/path/to/output/mavenized/jee-example-app/pom.xml`. This file identifies the directories for all of the project modules.

The following modules are listed in the root POM for the example `jee-example-app-1.0.0.ear` application. 

~~~~
<modules>
  <module>jee-example-app-bom</module>
  <module>jee-example-services2-jar</module>
  <module>jee-example-services-jar</module>
  <module>jee-example-web-war</module>
  <module>jee-example-app-ear</module>
</modules>
~~~~

{{% alert info %}}
Be sure to reorder the list of modules if necessary so that they are listed in an appropriate build order for your project.
{{% /alert %}}

### BOM File
The Bill of Materials (BOM) file is generated in the directory ending in -bom. For the example jee-example-app-1.0.0.ear application, the BOM file can be found at `/path/to/output/mavenized/jee-example-app/jee-example-app-bom/pom.xml`. The purpose of this BOM is to have the versions of third-party dependencies used by the project defined in one place. For more information on using a BOM, see the [Introduction to the Dependency Mechanism][2] section of the Apache Maven documentation. 

The following dependencies are listed in the BOM for the example `jee-example-app-1.0.0.ear` application 

~~~~
<dependencyManagement>
  <dependencies>
    <dependency>
      <groupId>log4j</groupId>
      <artifactId>log4j</artifactId>
      <version>1.2.6</version>
    </dependency>
    <dependency>
      <groupId>commons-lang</groupId>
      <artifactId>commons-lang</artifactId>
      <version>2.5</version>
    </dependency>
  </dependencies>
</dependencyManagement>
~~~~

### BOM File
Each application module that can be mavenized has a separate directory containing its POM file. The directory name contains the name of the archive and ends in a `-jar`, `-war`, or `-ear` suffix, depending on the archive type.

Each application POM file lists that module’s dependencies, including:

* Third-party libraries
* Java EE APIs
* Application submodules 

For example, the POM file for the `jee-example-app-1.0.0.ear` EAR, `/path/to/output/mavenized/jee-example-app/jee-example-app-ear/pom.xml`, lists the following dependencies. 

~~~~
<dependencies>
  <dependency>
    <groupId>log4j</groupId>
    <artifactId>log4j</artifactId>
    <version>1.2.6</version>
  </dependency>
  <dependency>
    <groupId>org.jboss.seam</groupId>
    <artifactId>jee-example-web-war</artifactId>
    <version>1.0</version>
    <type>war</type>
  </dependency>
  <dependency>
    <groupId>org.jboss.seam</groupId>
    <artifactId>jee-example-services-jar</artifactId>
    <version>1.0</version>
  </dependency>
  <dependency>
    <groupId>org.jboss.seam</groupId>
    <artifactId>jee-example-services2-jar</artifactId>
    <version>1.0</version>
  </dependency>
</dependencies>
~~~~

# Conclusion
As demonstrated in this lab, RHAMT provides the ability to generate an Apache Maven project structure based on the application provided. This will create a directory structure with the necessary Maven Project Object Model (POM) files that specify the appropriate dependencies. 

[1]: https://maven.apache.org/guides/introduction/introduction-to-the-pom.html
[2]: https://access.redhat.com/maven-repository
