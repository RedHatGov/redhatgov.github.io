---
title: Lab 17 - Clair Vulnerability Scan
workshops: secure_software_factory
workshop_weight: 30
layout: lab
---
# Add Clair Container Scan

Add the configuration for the Container Vulnerability Scan below to your pipeline text file.

<img src="../images/pipeline_container_scan.png" width="900"><br/>

<br>

# Append to Jenkins Pipeline Configuration

In Builds > Pipelines > tasks-pipeline > Actions > Edit

<img src="../images/pipeline_actions_edit.png" width="900" />

In your pipeline, add and update the following variables after the version and mvnCmd definitions.  Please fill in the values between the quotes.

- ocuser : the openshift user given to you by your insturctor
- ocpass : the openshift password given to you by your insturctor
- ocp : the openshift host given to you by your instuctor
- quayuser : the quay user you created previously
- quaypass : the quay password you created previously
- quayrepo : the quay repo you will push your app image to i.e. tasks


```
def ocuser = " "
def ocpass = " "
def ocp = " "
def quayuser = " "
def quaypass = " "
def quayrepo = " "
```

For Example:

```
def ocuser = "user{{< span2 "userid" "YOUR#" >}}"
def ocpass = "openshift"
def ocp = "{{< urishortfqdn "" "master" "" >}}"
def quayuser = "user{{< span2 "userid" "YOUR#" >}}"
def quaypass = "openshift"
def quayrepo = "jboss-eap70-openshift"
```

In your pipeline, replace the Jenkins agent 'maven' with 'jenkins-slave-image-mgmt'.

```
pipeline {
  agent {
    label 'jenkins-slave-image-mgmt'
  }
```

In your pipeline, add the Vulnerability Scan Stage after the Build Image Stage.

```
    stage('Clair Container Vulnerability Scan') {
      steps {
            sh "oc login -u $ocuser -p $ocpass --insecure-skip-tls-verify https://$ocp 2>&1"
            sh 'skopeo --debug copy --src-creds="$(oc whoami)":"$(oc whoami -t)" --src-tls-verify=false --dest-tls-verify=false' + " --dest-creds=$quayuser:$quaypass docker://docker-registry.default.svc:5000/cicd-$ocuser/jboss-eap70-openshift:1.5 docker://quay-enterprise-quay-enterprise.apps.$ocp/$quayuser/$quayrepo:1.5"
        }
    }
```

Save your Jenkins file

# Run Pipeline

Go to Builds > Pipeline

Click Start Pipeline for the pipeline you just created called tasks-pipeline.

Your pipeline should now execute through all the stages you created.  

Go ahead and click View Log.  This will take you to the Jenkins logs and you can follow the various stages in your pipeline.

When it asks to promote to stage, go ahead and promote it.

<img src="../images/pipeline_execution.png" width="900"><br/>

<br>

# View Clair Container Scan Report in Quay

Select the Repository that was created

<img src="../images/quay_repo.png" width="900"><br/>

<br>

Select Repository Tags on the left hand menu

  - If your scan is queued, you will need to wait for the scan to finish to view the report

Select the Security Scan for your Image

<img src="../images/quay_repo_tags.png" width="900"><br/>

<br>

View the Security Scan Report

<img src="../images/quay_scan.png" width="900"><br/>
{{< importPartial "footer/footer.html" >}}
