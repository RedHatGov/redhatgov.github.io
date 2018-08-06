---
title: Lab 07 - Test Stage
workshops: secure_software_factory
workshop_weight: 17
layout: lab
---

# Add Test Stage

Add the configuration for the Test Stage below to your pipeline text file.

<img src="../images/pipeline_test.png" width="900" />

Maven will run the test stage in the life cycle that we skipped at the previous stages.

Maven will place the test results in the surefire-reports folder.  The maven surefire-reports plugin allows for the generation of reports for your unit tests.

<br>

# Append to Jenkins Pipeline Configuration

In Builds > Pipelines > tasks-pipeline > Actions > Edit

<img src="../images/pipeline_actions_edit.png" width="900" />

Append the text below to the bottom of the Jenkins Pipeline Configuration.  Please make sure to append to the beginning of the next line.  

```
    stage('Test') {
      steps {
        sh "${mvnCmd} test"
        step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*.xml'])
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
