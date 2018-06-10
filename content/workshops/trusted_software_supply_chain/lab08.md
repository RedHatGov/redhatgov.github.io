---
title: Lab 08 - Create Image Builder
workshops: trusted_software_supply_chain
workshop_weight: 18
layout: lab
---
# Containers

Containers are an important foundation for your application in building a Trusted Software Supply Chain.  You want a secure and blessed golden container image that your application will inherit security controls for.

Containers can be built using a layered approach. For example, to create a container of a Java web application, you could do so in multiple layers: the OS, the JVM, the web server, and the code itself.

<img src="../images/golden_images.png" width="900" />

# Add Create Image Builder Stage

Add Create Image Builder Stage into your pipeline text file

```
            stage('Create Image Builder') {
                when {
                  expression {
                    openshift.withCluster() {
                      openshift.withProject(env.DEV_PROJECT) {
                        return !openshift.selector("bc", "tasks").exists();
                      }
                    }
                  }
                }
                steps {
                  script {
                    openshift.withCluster() {
                      openshift.withProject(env.DEV_PROJECT) {
                        openshift.newBuild("--name=tasks", "--image-stream=jboss-eap70-openshift:1.5", "--binary=true")
                      }
                    }
                  }
                }
              }
```

New build will be created with this step.  We will be levaring a JBoss EAP 7 container.

The golden image will will be using for our applications is jboss-eap70-openshift:1.5.  Again, you'll want a hardened, secured, patched and up to date container image.
