---
title: Lab 06 - Code Analysis
workshops: trusted_software_supply_chain
workshop_weight: 16
layout: lab
---

# Add Code Analysis State

Add Code Analysis State into pipeline text file.

```
              stage('Code Analysis') {
                steps {
                  script {
                    sh "${mvnCmd} sonar:sonar -Dsonar.host.url=http://sonarqube:9000 -DskipTests=true"
                  }
                }
              }
```

SonarQube is an open source static code analysis tool that we can automate running security scan against your source code to further improve the security of you application.  So every time you have a code check-in, SonarQube will scan the quality and threat analysis of that code.

Once we build the full pipeline and run it, we will log into SonarQube and view the various metrics, stats, and code coverage.
