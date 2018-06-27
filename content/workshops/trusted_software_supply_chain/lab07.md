---
title: Lab 07 - Test Stage
workshops: trusted_software_supply_chain
workshop_weight: 17
layout: lab
---

# Add Test Stage

Add the configuration for the Test Stage below to your pipeline text file.

<img src="../images/pipeline_test.png" width="900" />

Maven will run the test stage in the life cycle that we skipped at the previous stages.

Maven will place the test results in the surefire-reports folder.  The maven surefire-reports plugin allows for the generation of reports for your unit tests.

Append the text below to your text file or into the YAML/JSON field for tasks-pipeline in the OpenShift Console.

```
              stage('Test') {
                steps {
                  sh "${mvnCmd} test"
                  step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*.xml'])
                }
              }
```
