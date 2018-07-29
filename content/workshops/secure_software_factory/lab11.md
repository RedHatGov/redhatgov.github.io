---
title:  Lab 11 - Build Image
workshops: secure_software_factory
workshop_weight: 21
layout: lab
---
# Add Build Image Stage

Add the Build Image Stage into your pipeline.

<img src="../images/pipeline_oc_build_image.png" width="900" />

The "sh" are shell commands in your pipeline that are executed on the Jenkins Slave.  Maven built the openshift-tasks.war in it the target directory and it will be copied into the created oc-builds directory.

The startBuild stage is kicked off from Openshift and pointing to the local directory "oc-build" on the Jenkins slave.

<br>
# Append to Jenkins Pipeline Configuration

In Builds > Pipelines > tasks-pipeline > Actions > Edit

<img src="../images/pipeline_actions_edit.png" width="900" />

Append the text below to the bottom of the Jenkins Pipeline Configuration.  Please make sure to append to the beginning of the next line.  

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
# Test Your Pipeline
If you'd like to do a test of first pipeline stage, add the following brackets at the end of your Jenkinsfile. Make sure to append to the beginning of the last line.

```
  }
}
```

Save your Jenkinsfile.

Go back to Builds > Pipelines

Click Start Pipeline

# Delete Brackets
Please delete the brackets you just added once testing is complete. We can add them later if you'd like to test your pipeline as you go along.

```
  }
}
```
Click Save
