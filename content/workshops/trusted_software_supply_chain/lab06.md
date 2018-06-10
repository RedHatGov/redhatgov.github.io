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
Once we build the full pipeline and run it, we will log into SonarQube and view the various metrics, stats, and code coverage.
