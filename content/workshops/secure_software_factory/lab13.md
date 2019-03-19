---
title: Lab 13 - Promote and Deploy to Stage
workshops: secure_software_factory
workshop_weight: 24
layout: lab
---
# Add Promote to Stage
Enter the Promote to STAGE below into your pipeline.

<img src="../images/pipeline_promote.png" width="900" />

We set an approval to promote to the application to the Stage Project.  The approval process is a good feature for various gates of your deployments.  We also set a 15 minute timeout on the approval.  You also tag the tasks image with latest and the version from the pom file.

<br>
# Append to Jenkins Pipeline Configuration

In Builds > Pipelines > tasks-pipeline > Actions > Edit

<img src="../images/pipeline_actions_edit.png" width="900" />

Append the text below to the bottom of the Jenkins Pipeline Configuration.  Please make sure to append to the beginning of the next line.  

```
    stage('Promote to STAGE?') {
      steps {
        timeout(time:15, unit:'MINUTES') {
            input message: "Promote to STAGE?", ok: "Promote"
        }

        script {
          openshift.withCluster() {
            openshift.tag("${env.DEV_PROJECT}/tasks:latest", "${env.STAGE_PROJECT}/tasks:${version}")
          }
        }
      }
    }
```

# Add Deploy Stage

Add the Deploy Stage into your pipeline.

<img src="../images/pipeline_deploy_stage.png" width="900" />

If the deployment config for the application already exists in the Stage Project or Environment the deployment config , service, and route are deleted.  This allows for the pipeline to be rerun.

The new-app is recreated in the Stage Environment from the image that you tagged in the previous stage.  The image also has a route created for with the svc.expose command.


<br>
# Append to Jenkins Pipeline Configuration

In Builds > Pipelines > tasks-pipeline > Actions > Edit

<img src="../images/pipeline_actions_edit.png" width="900" />

Append the text below to the bottom of the Jenkins Pipeline Configuration.  Please make sure to append to the beginning of the next line.  


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
```      

Congratulations, this should be the final step in your Trusted Software Supply Chain.  Go on to the next lab to verify and run the pipeline.
{{< importPartial "footer/footer.html" >}}
