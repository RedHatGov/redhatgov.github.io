---
title: Lab 14 - Promote to Stage
workshops: trusted_software_supply_chain
workshop_weight: 24
layout: lab
---
# Add Promote to Stage
Enter the Promote to STAGE below into your pipeline.

<img src="../images/pipeline_promote.png" width="900" />

We set an approval to promote to the application to the Stage Project.  The approval process is a good feature for various gates of your deployments.  We also set a 15 minute timeout on the approval.  You also tag the tasks image with latest and the version from the pom file.

Append the text below to your text file or into the YAML/JSON field for tasks-pipeline in the OpenShift Console. 

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
