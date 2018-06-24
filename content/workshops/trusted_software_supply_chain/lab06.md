---
title: Lab 06 - Code Analysis and Vulnerability Scanning
workshops: trusted_software_supply_chain
workshop_weight: 16
layout: lab
---

# Add Code Analysis Stage and Vulnerability Scanning.

Add Code Analysis Stage into pipeline text file.  We leverage the maven sonar plugin to run SonarQube scanning against our source code.

SonarQube is an open source static code analysis tool that we can automate running security scan against your source code to further improve the security of you application.  So every time you have a code check-in, SonarQube will scan the quality and threat analysis of that code.

We leverage the sonarqube maven plugin and specfify the maven goal "sonar:sonar" to run our project leveraging the sonarqube api.

SonarQube's security rules orginate from these standards:

* [CWE Database][1] - Common Weakness Enumeration (CWE™) is a formal list or dictionary of common software weaknesses that can occur in software's architecture, design, code or implementation that can lead to exploitable security vulnerabilities.

* [SANS Top 25][2] - The SANS Top 25 list is a collection of the 25-most dangerous errors listed in the CWE, as compiled by the SANS organization.

* [OWASP Top 10][3] - The OWASP Top 10 is a list of broad categories of weaknesses, each of which can map to many individual rules.

```
              stage('Code Analysis') {
                steps {
                  script {
                    sh "${mvnCmd} sonar:sonar -Dsonar.host.url=http://sonarqube:9000 -DskipTests=true"
                  }
                }
              }
```


Once we build the full pipeline and run it, we will log into SonarQube and view the various metrics, stats, and code coverage as seen from the screenshot below.

<img src="../images/sonarqube-analysis.png" width="900"><br/>

[1]: http://cwe.mitre.org/about/index.html
[2]: https://www.sans.org/top25-software-errors/
[3]: https://www.owasp.org/index.php/Top_10-2017_Top_10
