---
title: Lab 13 - Deploy Stage
workshops: trusted_software_supply_chain
workshop_weight: 23
layout: lab
---
# Add Deploy Stage

Add Deploy Stage into your Pipeline Text File

```
              stage('Deploy STAGE') {
                steps {
                  script {
                    openshift.withCluster() {
                      openshift.withProject(env.STAGE_PROJECT) {
                        if (openshift.selector('dc', 'tasks').exists()) {
                          openshift.selector('dc', 'tasks').delete()
                          openshift.selector('svc', 'tasks').delete()
                          openshift.selector('route', 'tasks').delete()
                        }

                        openshift.newApp("tasks:${version}").narrow("svc").expose()
                      }
                    }
                  }
                }
              }
            }
          }
      type: JenkinsPipeline
```      
If the deployment config for the application already exists in Stage the deployment config , service, and route are deleted.

Then the new-app is recreate in the Stage Environment from an entry in the container registry.

Congratulations, this should be the final step in your Trusted Software Supply Chain.  Go on to the next lab to verify and run the pipeline.
