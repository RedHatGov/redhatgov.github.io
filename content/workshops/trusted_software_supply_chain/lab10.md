---
title: Lab 10 - Create Dev
workshops: trusted_software_supply_chain
workshop_weight: 20
layout: lab
---
# Add Create Dev Stage

Add Create Dev Stage into Pipeline Text File

We first check if an deployment config for the Dev Project already exists.  If it does not exists, a new application is created and deployment config is defined for the Dev Project.

Before a trigger is created, the pipeline sleeps for 10 seconds.  A deployment configuration can contain triggers, which drive the creation of new deployment processes in response to events inside the cluster.  In this case, the trigger is set to a manual deployment of the tasks deployment config.  The deployment will happen in Deploy Stage. 

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
