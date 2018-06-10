---
title: Lab 10 - Create Dev
workshops: trusted_software_supply_chain
workshop_weight: 20
layout: lab
---
# Add Create Dev Stage

Add Create Dev Stage into Pipeline Text File

```
              stage('Create DEV') {
                when {
                  expression {
                    openshift.withCluster() {
                      openshift.withProject(env.DEV_PROJECT) {
                        return !openshift.selector('dc', 'tasks').exists()
                      }
                    }
                  }
                }
                steps {
                  script {
                    openshift.withCluster() {
                      openshift.withProject(env.DEV_PROJECT) {
                        def app = openshift.newApp("tasks:latest")
                        app.narrow("svc").expose();

                        def dc = openshift.selector("dc", "tasks")
                        while (dc.object().spec.replicas != dc.object().status.availableReplicas) {
                            sleep 10
                        }
                        openshift.set("triggers", "dc/tasks", "--manual")
                      }
                    }
                  }
                }
              }
```
The new application is defined for Dev, along with the deployment config is defined for Dev
