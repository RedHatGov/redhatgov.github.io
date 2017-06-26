---
title: Lab 5 - Create a Java-Based Rule Addon
workshops: jboss_migration_toolkit
workshop_weight: 50
layout: lab
---

# Create a Java-Based Rule Addon Goals

In the XXX lab, you created a Windup report from a sample JEE application called `jee-example-app-1.0.0.ear`. This sample JEE application includes a Java class file called `com.acme.anvil.service.jms.LogEventSubscriber`. This class is a JEE Message Driven Bean component. During this lab, you create a custom Java-based Windup rule that is triggered when encountering this class file.  This lab guides you through the process of building a custom Java-based Windup rule, deploying the new rule, running Windup with the new rule, and viewing the results in a refreshed Windup report.

* Learn how to create a Windup addon
* Generate a Java-based custom Windup rule
* Install and test the custom Windup rule

## Prerequisites

* Completion of the XXX lab
* Familiarization with the following documentation and examples:
    * `OCPsoft Rewrite` - Windup rules are based on the OCPsoft Rewrite project. For more information about this project, see [here][1].
    * `Windup API JavaDoc` - The JavaDoc for the Windup API is located [here][2].
    * `Example Java-based Windup rules` - Working examples of Java-based rules can be found in the [here][3] GitHub repository.

## Step 1.  Analyze Existing Windup Report
Start by viewing the results of executing Windup in the XXX lab.

1. Open a browser and navigate to the `index.html` file of the generated Windup Report.

2. Search for the following class in `index.html`:
~~~~
com.acme.anvil.service.jms.LogEventSubscriber
~~~~

3. Click its link.

4. Observe the following:
* There are no classifications or hints for the Windup report section that are specific to this class.

* The use of proprietary Weblogic classes.

## Step 2. Create a Maven Project

In this section you create a custom Java rule that gets triggered on this Java class and provides a migration team with a story point.

1. Create a simple maven project using the following `pom.xml`:
~~~~
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.sample</groupId>
  <artifactId>example-java-rule</artifactId>
  <version>0.0.1-SNAPSHOT</version>
</project>
~~~~

## Step 3. Create the RuleProvider

1. Within the new com.example:example-java-rule:0.0.1-SNAPSHOT Maven project, create a Java package:
    1. Name the package com.example

2. To be a CDI-compliant addon that can be loaded by Furnace, you must include a beans.xml file:
    1. Navigate to example-java-rule -> src/main/resources.
    2. Add a folder with the name META-INF
    3. Change to the META-INF folder and create an empty file named beans.xml.

<insert explorer dropdown>

3. Create a new Java class within the `com.example package` and name it `MyCustomRuleProvider`.

4. Navigate to `MyCustomRuleProvider.java` and add the content to your custom rule.  The project should now appear as follows:

<insert new explorer dropdown >

## Step 4. Understand MyCustomRuleProvider

The rule `com.example.MyCustomRuleProvider` is a high-level rule that uses high-level conditions (JavaClass) and operations (Classification).

The class defines five story points regarding the inheritance of `weblogic.ejb.GenericMessageDrivenBean`.

The class also defines two story points that suggest the removal of proprietary import statements.

## Step 5. Analyze MyCustomRuleProvider

~~~~
public class MyCustomRuleProvider extends WindupRuleProvider {                                               1

public Configuration getConfiguration(GraphContext arg0) {                                                   2

return ConfigurationBuilder.begin()                                                                          3
  .addRule()
  .when(                                                                                                     4
    JavaClass.references("weblogic.ejb.GenericMessageDrivenBean")
             .at(TypeReferenceLocation.INHERITANCE)
  )
  .perform(                                                                                                  5

       Hint.withText("WebLogic Server Generic Bean Template Inheritance")
       .with(Link.to("Message Driven Bean",
                     "https://access.redhat.com/documentation/en-US/MDB.html"))
       .withEffort(5)
       .and(Classification.as("Remove the WebLogic generic Message Driven Bean template inheritance."))

  )
  .addRule()                                                                                                 6
  .when(
    JavaClass.references("weblogic.ejb.GenericMessageDrivenBean")
             .at(TypeReferenceLocation.IMPORT)
  )

  .perform(

       Hint.withText("WebLogic Server Generic Bean Template Import")
       .with(Link.to("Message Driven Bean",
                     "https://access.redhat.com/documentation/en-US/MDB.html"))
       .withEffort(2)
       .and(Classification.as("Remove the WebLogic generic Message Driven Bean template import.")));
}
}
~~~~

1. This line shows that Java custom rules extend `WindupRuleProvider` and override some methods.
2. This is the main method to add your custom rules.
3. `ConfigurationBuilder` is the class that permits you to add your rules with the `addRule()` method.
4. The `when` section is where you define constraints to match a given case to be analyzed. In this example, the case is the `weblogic.ejb.GenericMessageDrivenBean` inheritance used in Weblogic.
5. The `perform` section is where you add classifications and hints when the pattern matches the `when` condition. Classifications can include links to a specific URL. Hints can be added with a level of effort needed to execute the migration task.
6. This rule catches events of `weblogic.ejb.GenericMessageDrivenBean`, but as an import statement.

## Step 5. Install the Java-Based Rule Addon

1. In JBoss Developer Studio, start Forge by entering CTRL + 4 or Command + 4 (OS X).

2. Select `Build and Install an Addon`.

## Step 6. Test the Java-Based Rule Addon

1. Run Windup via Forge in JBoss Developer Studio by pressing CTRL + 4 or Command + 4 (OS X).

2. Select Windup Migrate App.

3. For the Input field, click Browse and select the jee-example-app-1.0.0.ear file you downloaded earlier.

4. For the Output field, add a location on your local workstation.

5. Define Scan Java Packages with these values:

    * com.acme
    * org.apache

6. Click Finish.

7. After executing Windup, verify that the report was generated and that the index.html file is available.

8. Find the com.acme.anvil.service.jms.LogEventSubscriber reference and open it’s specific report.

9. Observe that there are now two hints and two classifications for a total of seven story points.

# Conclusion
Nice job! You created a custom Java Windup rule.

[1]: http://www.ocpsoft.org/rewrite
[2]: http://windup.github.io/windup/docs/javadoc/latest/
[3]: https://github.com/windup/windup-quickstarts
