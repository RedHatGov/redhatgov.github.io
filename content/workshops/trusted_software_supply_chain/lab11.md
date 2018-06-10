---
title: Lab 11 - Deploy Dev
workshops: trusted_software_supply_chain
workshop_weight: 21
layout: lab
---

# Enter Deploy Dev Stage

Enter Deploy Dev Stage to your pipeline Text File.  

OpenShift deploys the application and it's deployment configuration to Dev.

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
