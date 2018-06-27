---
title: Lab 13 - Deploy Dev
workshops: trusted_software_supply_chain
workshop_weight: 23
layout: lab
---

# Deploy Dev Stage

Enter the Deploy Dev Stage to your pipeline text file.  

<img src="../images/pipeline_deploy_dev.png" width="900" />

OpenShift deploys the application and it's deployment configuration to Dev as previously defined from the Create Dev Stage.

Append the text below to your text file or into the YAML/JSON field for tasks-pipeline in the OpenShift Console. 

```
              stage('Deploy DEV') {
                steps {
                  script {
                    openshift.withCluster() {
                      openshift.withProject(env.DEV_PROJECT) {
                        openshift.selector("dc", "tasks").rollout().latest();
                      }
                    }
                  }
                }
              }
```
