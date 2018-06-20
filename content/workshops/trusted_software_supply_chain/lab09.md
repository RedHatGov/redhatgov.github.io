---
title:  Lab 09 - Build Image
workshops: trusted_software_supply_chain
workshop_weight: 19
layout: lab
---
# Add Build Image Stage

Add the Build Image Stage into your pipeline text file

The "sh" are shell commands in your pipeline that are executed on the Jenkins Slave.  Maven built the openshift-tasks.war in it the target directory and it will be copied into the created oc-builds directory.

The startBuild stage is kicked off from Openshift and pointing to the local directory "oc-build" on the Jenkins slave.


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
