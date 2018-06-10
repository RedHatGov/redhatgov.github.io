---
title: Lab 05 - Test Stage
workshops: trusted_software_supply_chain
workshop_weight: 15
layout: lab
---

# Add Test Stage into Pipeline Text File

Add the configuration for the Test Stage below to your pipeline text file.

```
              stage('Test') {
                steps {
                  sh "${mvnCmd} test"
                  step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*.xml'])
                }
              }
```

Maven will run up to the test stage in the lifecycle.
