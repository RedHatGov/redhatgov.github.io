---
title: Lab 05 - Test Stage
workshops: trusted_software_supply_chain
workshop_weight: 15
layout: lab
---

# Add Test Stage into Pipeline Text File

Add the configuration for the Test Stage below to your pipeline text file.  Maven will run the test stage in the lifecycle that we skipped at the previous stages.

Maven will place the test results in the surefire-reports folder.  The maven surefire-reports plugin allows for the generation of reports for your unit tests.

```
              stage('Test') {
                steps {
                  sh "${mvnCmd} test"
                  step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*.xml'])
                }
              }
```
