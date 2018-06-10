---
title: Lab 12 - Promote to Stage
workshops: trusted_software_supply_chain
workshop_weight: 22
layout: lab
---
# Add Promote to Stage into Pipeline Text File
```
              stage('Promote to STAGE?') {
                steps {
                  timeout(time:15, unit:'MINUTES') {
                      input message: "Promote to STAGE?", ok: "Promote"
                  }

                  script {
                    openshift.withCluster() {
                      openshift.tag("${env.DEV_PROJECT}/tasks:latest", "${env.STAGE_PROJECT}/tasks:${version}")
                    }
                  }
                }
              }
```
- Approve is needed to promote to Stage
