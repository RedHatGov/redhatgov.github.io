---
title: Lab 6 - Create an XML-Based Rule
workshops: jboss_migration_toolkit
workshop_weight: 60
layout: lab
---

# Create an XML-Based Rule

The JEE application that was analyzed by Windup in the lab for the first module of this course contains a web application with a servlet filter called `com.acme.anvil.AuthenticateFilter`. This servlet filter makes use of proprietary Weblogic functionality.  In this lab, you create a Windup rule that identifies this proprietary functionality and offers a helpful hint about migrating this servlet to a JBoss container.

* Review Windup reports
* Create custom XML-based rules that capture crucial migration points
* Analyze warnings in a Windup report

## Prerequisites

* Completion of the XXX lab

## Step 1.  You begin this lab by evaluating in more detail the Windup report generated in the lab for module XXX. The focus is on a customer servlet filter that makes use of proprietary Weblogic functionality.

1. Open a browser and navigate to the index.html of the Windup report generated in the module XXX lab.

2. Scroll down to the panel that details results regarding the web application `jee-example-app-1.0.0.ear/jee-example-web.war`.

3. Verify that Windup identified three story points.

4. Click the `WEB-INF/web.xml` file and notice that it defines the web filter `com.acme.anvil.AuthenticateFilter`.

5. Look at the panel for the `jee-example-web.war` web archive, and notice that one warning was issued regarding the use of a propriety `weblogic.i18n.logging.NonCatalogLogger` class. This warning was generated from a Windup rule that was included in the Windup coordinates installed in the previous lab.

## Step 2. Create an XML-Based Windup Rule

Windup comes with many out-of-the-box migration rules. Windup also allows you to create custom rules. In this section of the lab, you create a custom rule that flags the use of an additional proprietary Weblogic class: `weblogic.servlet.security.ServletAuthentication`.

1. On your local workstation, navigate to the `$HOME/.windup/rules` directory.

2. Create a new file called `sample.windup.xml`.

3. Paste the following contents in this new file:
~~~~
<?xml version="1.0"?>
<ruleset id="xmltestrules_1" xmlns="http://windup.jboss.org/v1/xml">
  <rules>
    <rule> 
      <when>
        <javaclass references="weblogic.servlet.security.ServletAuthentication"/>
      </when>
      <perform>
        <hint message="Weblogic security does not function in JBoss. Replace with PicketLink.">
          <link description="Learn how to use PicketLink at jboss.org" href="http://docs.jboss.org/"/>
        </hint>
        <classification classification="Security Component"/>
      </perform>
    </rule>
    <rule> 
      <when>
        <xmlfile matches="/w:web-app/w:filter/w:filter-class[text() = 'com.acme.anvil.AuthenticateFilter']">
          <namespace prefix="w" uri="http://java.sun.com/xml/ns/j2ee"/>
        </xmlfile>
      </when>
      <perform>
        <hint effort="10" message="ACME AuthenticateFilter is obsolete and must be replaced by PicketLink"/>
      </perform>
    </rule>
  </rules>
</ruleset>
~~~~

4. Observe that two additional rules are defined in this new Windup rule file. The first rule, in particular, identifies all occurrences of the proprietary `weblogic.servlet.security.ServletAuthentication` class.

## Step 3. Generate a New Windup Report

1. Execute Windup on the lab1 project again via the command line:
~~~~
windup --input jee-example-app-1.0.0.ear --output windup_output --packages com.acme,org.apache --target eap
~~~~

## Step 4. Analyze Results

The Windup report you generated should flag use of the proprietary Weblogic class in the same JEE artifact.

1. In your browser, navigate to and open the `index.html` file of the Windup output.

2. Scroll to the jee-example-app-1.0.0.ear/jee-example-web.war section and observe the following:

* The number of story points has increased to 13.
* There is an additional warning in the `com.acme.anvil.AuthenticateFilter` class.

3. Click the `WEB-INF/web.xml` link and observe the inclusion of the hint introduced in your custom rule.

4. Click the back button in your browser to return to the `jee-example-app-1.0.0.ear/jee-example-web.war` section of the `index.html` file.

5. Click the `com.acme.anvil.AuthenticateFilter` link and observe the inclusion of an additional warning in this this class.

# Conclusion
Congratulations! You reviewed a Windup report and created a new custom XML-based Windup rule.

