---
title: Lab 4 - Analyze Rule Structure
workshops: jboss_windup
workshop_weight: 40
layout: lab
---

# Analyze Rule Structure Goals

* Locate the source code of out-of-the-box Windup rules

* Analyze the sections of a Windup rule

## Prerequisites

* Internet access to github.com

## Step 1. Locate Out-of-the-Box Windup Rules
Windup includes a substantial and increasing number of XML-based rules to provide initial execution and analysis for common migration scenarios. Many of these rules are written by the open source community of Windup users.

1. Open a browser and navigate to the [out-of-the-box rule GitHub repository][2]   `https://github.com/windup/windup-rulesets/tree/master/rules` 

2. Notice that the out-of-the-box Windup rules are categorized by technology.

<img src="../images/lab4-1.png" width="269" />

{{% alert info %}}
Windup analyzes only XML files with names ending in `.windup.xml`. Use this naming convention when creating your own custom XML-based Windup rules. In the next module, you create your own custom XML-based Windup rules.
{{% /alert %}}

3. (Optional) Fork the `https://github.com/windup/windup-rulesets` repository in your own GitHub account.

4. (Optional) Make additions to your forked `windup-rulesets` (or improvements to existing Windup rules) and submit a `Pull Request`. Your contributions may be accepted by the Windup core maintainers.

## Step 2. Dissect a Windup Rule

The callouts in this rules file are explained below in the sample.
~~~~
<?xml version="1.0" encoding="UTF-8"?>
<ruleset id="customruleprovider"
         xmlns="http://windup.jboss.org/v1/xml">                                       1
  <phase>DISCOVERY</phase>                                                             2
  <rules>                                                                              3
    <rule>                                                                             4
      <when>                                                                           5
        <javaclass references="javax.servlet.http.HttpServletRequest">                 6
          <location>METHOD_PARAMETER</location>                                        7
        </javaclass>
      </when>
      <perform>                                                                        8
        <hint>                                                                         9
          <message>Message from XML Rule</message>                                     10
          <link description="Description from XML Hint Link"
                href="http://example.com"/>                                            11
        </hint>
        <log message="test log message"/>                                              12
      </perform>
      <otherwise>                                                                      13
        <!--  -->
      </otherwise>
    </rule>
    <rule>
      <when>
        <xmlfile xpath="/w:web-app/w:resource-ref/w:res-auth[text() = 'Container']">   14 
          <namespace prefix="w"
                     uri="http://java.sun.com/xml/ns/javaee"/>
        </xmlfile>
      </when>
      <perform>
        <hint>
          <message>Container Auth</message>
        </hint>
        <xslt description="Example XSLT Conversion"
              extension="-converted-example.xml"
              xsltFile="/exampleconversion.xsl"/>                                      15
        <log message="test log message"/>
      </perform>
      <otherwise>
        <!--  -->
      </otherwise>
    </rule>
  </rules>
</ruleset>
~~~~

1. This specifies the XML namespace of XML-based Windup rules.
2. The `phase` element specifies the life cycle phase during which the rules in this ruleset should fire.
3. The `rules` element is the XML collection element that contains the individual rules.
4. The `rule` element is a child of the `rules` element. One or more rules can be defined for a ruleset. Each rule contains at a minimum `when` and `perform` elements.
5. The `when` element defines the condition to match on.
6. The `javaclass` element defines the target resource as a Java class. The `references` attribute determines the value to search on. Wildcard values for the `references` attribute are allowed.
7. The `location` element specifies where the reference is found in a Java source file. For more details, and information about valid values, go [here][1].
8. The `perform` element is invoked when the condition is met.
9. When the condition is met, the value of the `hint` attribute appears in the final Windup Report.
10. The `message` element defines the text for the hint.
11. An optional `url` element further describes the hint.
12. The `log` child element of `perform` is used to log a message. It takes the `message` attribute to define the text message.
13. The `otherwise` element is invoked when the condition is not met.
14. Searching for XML files in an enterprise application is also possible. The `xmlfile` element defines the target resource as an XML file. The `xpath` attribute defines which value is searched in the XML elements structure.
15. Windup allows for the automated transformation of vendor-specific descriptor files to equivalent JBoss EAP descriptor files. In this example, the `xslt` element defines the attribute `xsltFile`. This `xslt` does the transform of vendor-specific configuration files to JBoss EAP equivalents. This is described in detail later in the workshop.

# Conclusion
As demonstrated in this lab, you still have to do the work, but Windup provides guidance and assistance to help the migration go smoothly and predictably.

You may have noticed opportunities in the lab where Windup could have reported more information. In subsequent labs, you discover how to make Windup reports more helpful by adding to the rulebase.

[1]: http://windup.github.io/windup/docs/javadoc/latest/org/jboss/windup/rules/apps/java/scan/ast/TypeReferenceLocation.html
[2]: https://github.com/windup/windup-rulesets/tree/master/rules
