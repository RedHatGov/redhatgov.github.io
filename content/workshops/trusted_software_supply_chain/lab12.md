---
title: Lab 12 - Promote to Stage
workshops: trusted_software_supply_chain
workshop_weight: 22
layout: lab
---
# Add Promote to Stage
Enter the Promote to STAGE below into your pipeline text file

We set an approval to promote to the application to the Stage Project.  The approval process is a good feature for various gates of your deployments.  We also set a 15 minute timeout on the approval.  You also tag the tasks image with latest and the version from the pom file.

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
