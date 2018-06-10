---
title:  Lab 09 - Build Image
workshops: trusted_software_supply_chain
workshop_weight: 19
layout: lab
---
# Add Build Image Stage

Add Build Image Stage into your pipeline text file

```
              stage('Build Image') {
                steps {
                  sh "rm -rf oc-build && mkdir -p oc-build/deployments"
                  sh "cp target/openshift-tasks.war oc-build/deployments/ROOT.war"

                  script {
                    openshift.withCluster() {
                      openshift.withProject(env.DEV_PROJECT) {
                        openshift.selector("bc", "tasks").startBuild("--from-dir=oc-build", "--wait=true")
                      }
                    }
                  }
                }
              }
```

The shell commands in your pipelien are executed on  commands are executed on Jenkins Slave

The start build stage is kicked off from Openshift and pointing to the directory on the Jenkins slave.
