---
title: Lab 13 - Deploy Stage
workshops: trusted_software_supply_chain
workshop_weight: 23
layout: lab
---
# Add Deploy Stage

Add the Deploy Stage into your Pipeline Text File

If the deployment config for the application already exists in the Stage Project or Environment the deployment config , service, and route are deleted.  This allows for the pipeline to be rerun.

The new-app is recreated in the Stage Environment from the image that you tagged in the previous stage.  The image also has a route created for with the svc.expose command.

Congratulations, this should be the final step in your Trusted Software Supply Chain.  Go on to the next lab to verify and run the pipeline.

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
