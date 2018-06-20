---
title: Lab 06 - Code Analysis and Vulnerability Scanning
workshops: trusted_software_supply_chain
workshop_weight: 16
layout: lab
---

# Add Code Analysis Stage and Vulnerability Scanning.

Add Code Analysis Stage into pipeline text file.  We leverage the maven sonar plugin to run SonarQube scanning against our source code.

SonarQube is an open source static code analysis tool that we can automate running security scan against your source code to further improve the security of you application.  So every time you have a code check-in, SonarQube will scan the quality and threat analysis of that code.


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
