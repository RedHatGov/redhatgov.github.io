---
title: 'Lab 7: Verify Environment'
workshops: openshift_install
layout: lab
workshop_weight: 70
---

## Summary

During this lab, we will verify that the OpenShift components in our environment
are deployed as expceted and are up and running.

Go ahead and navigate to the Web Console for your cluster to ensure that you
are able to access the login screen.

The URL to your Web Console will be in the format of https://studentXX.example.com/.

## Cluster Admin

To start, you need to create a user with the `cluster-admin` role that can be
used to see all of the OpenShift components and projects.

During installation, a user with the `cluster-admin` role is created for you,
but this use is only available from the OpenShift **master** node and uses
certificates to login. The username for this user is `system:admin`.

The `system:admin` user can be used from the CLI on the **master** node, but
you cannot use this user to login to the Web Console as that requires a password,
which the `system:admin` user does not have.

### Create User

Since we used the `HTPasswd` identity provider for this installation, you are
going to create user credentials for your cluster. The file that contains the
users for your `HTPasswd` identity provider is located at
`/etc/origin/master/htpasswd` on the **master** node.

Connect to your **master** node via SSH and run the following command to create a
user in your `/etc/origin/master/htpasswd` file.

{{< highlight bash >}}
sudo htpasswd -b /etc/origin/master/htpasswd admin openshift123
{{< /highlight >}}

You can now log into the Web Console using the username `admin` and password
`openshift123`.

### Attach Role

When you login using the user you created above, you'll notice that you do
not have any projects of your own and you cannot see the projects used for the
OpenShift components.

You must attach the `cluster-admin` role to your `admin` user.

Connect to your **master** node via SSH and run the following command to attach
the `cluster-admin` role to your `admin` user.

{{< highlight bash >}}
oc adm policy add-cluster-role-to-user cluster-admin admin
{{< /highlight >}}

If you take a look at your browser, you should now see several projects appear
that contain the OpenShift components. One of these projects should be named
`default`.

## Verify OpenShift Components

Let's verify that each of the deployed OpenShift components are running as
expected.

In the sections below, you will see the way to check for each component via
the CLI as well as the Web Console. Click on the **CLI** or **Web Console**
header to show and hide that section.

### Registry and Router

The OpenShift Registry, including Registry Console, and the OpenShift router
run in the `default` project.

Verify that each of them has successfully started.

{{< panel_group >}}
{{% panel "CLI" %}}
To verify the `registry`, `registry-console`, and `router` are running,
take a look at the `DeploymentConfig` for each of them.

The `DESIRED` and `CURRENT` values should match for each.

{{< highlight bash >}}
oc get deploymentconfig -n default
{{< /highlight >}}

Expected output:

{{< highlight bash "hl_lines=3-5" >}}
[ec2-user@master ~]$ oc get deploymentconfig -n default
NAME               REVISION   DESIRED   CURRENT   TRIGGERED BY
docker-registry    1          1         1         config
registry-console   1          1         1         config
router             1          1         1         config
{{< /highlight >}}

As an additional check, take a look at the `Pod` for each of them.

The `STATUS` should be `Running` and `READY` should be `1/1`.

{{< highlight bash >}}
oc get pod -n default
{{< /highlight >}}

Expected output:

{{< highlight bash "hl_lines=3-5" >}}
[ec2-user@master ~]$ oc get pod -n default
NAME                       READY     STATUS    RESTARTS   AGE
docker-registry-1-xhhk0    1/1       Running   0          12m
registry-console-1-sxzft   1/1       Running   0          8m
router-1-pbvw3             1/1       Running   0          13m
{{< /highlight >}}

{{% /panel %}}
{{% panel "Web Console" %}}
To verify the `registry`, `registry-console`, and `router` are running using
the Web Console, select the `default` project from the dropdown at the top of
the page and look at the things running in that project.

You should see `1 pod` beside a dark blue circle beside each of the deployments
as shown in the example below.

{{< figure src="../images/verify_registry_router.png" class="img-thumbnail" >}}

{{% /panel %}}
{{< /panel_group >}}

### Logging

The OpenShift aggregated logging stack runs in the `logging` project.

Verify that each of the components of the logging stack has successfully started.

{{< panel_group >}}
{{% panel "CLI" %}}
To verify that the components of the logging stack are running, take a look at
the `DeploymentConfig` for each of them.

The `DESIRED` and `CURRENT` values should match for each.

{{< highlight bash >}}
oc get deploymentconfig -n logging
{{< /highlight >}}

Expected output:

{{< highlight bash "hl_lines=3-5 9-15" >}}
[ec2-user@master ~]$ oc get deploymentconfig -n logging
NAME                              REVISION   DESIRED   CURRENT   TRIGGERED BY
logging-curator                   1          1         1         config
logging-es-data-master-gepxkxe9   1          1         1         config
logging-kibana                    1          1         1         config
{{< /highlight >}}

As an additional check, take a look at the `Pod` for each of them.

The `STATUS` should be `Running` and `READY` should be `1/1`.

You'll also notice some additional pods running named `logging-fluentd-<uid>`.
These are the daemons that run on each node in the cluster to collect logs from
that node. You should have one for each node, which in the case of this
workshop you should have four (4) of them.

{{< highlight bash >}}
oc get pod -n logging -o wide
{{< /highlight >}}

Expected output:

{{< highlight bash "hl_lines=3-9" >}}
[ec2-user@master ~]$ oc get pod -n logging -o wide
NAME                                      READY     STATUS    RESTARTS   AGE
logging-curator-1-x2c77                   1/1       Running   0          38m
logging-es-data-master-gepxkxe9-1-bwn03   1/1       Running   0          39m
logging-fluentd-5ljbj                     1/1       Running   0          38m
logging-fluentd-6l5v3                     1/1       Running   0          38m
logging-fluentd-p0b4r                     1/1       Running   0          38m
logging-fluentd-vfkfz                     1/1       Running   0          38m
logging-kibana-1-3d3hd                    2/2       Running   0          39m
{{< /highlight >}}

To further show the `logging-fluentd-<uid>` pods running on each node, you can
add the `-o wide` option to the previous command to show which node each pod
is running on.

{{< highlight bash "hl_lines=5-8" >}}
[ec2-user@master ~]$ oc get pod -n logging -o wide
NAME                                      READY     STATUS    RESTARTS   AGE       IP            NODE
logging-curator-1-x2c77                   1/1       Running   0          54m       10.129.0.28   ip-10-36-114-166.ec2.internal
logging-es-data-master-gepxkxe9-1-bwn03   1/1       Running   0          55m       10.129.0.24   ip-10-36-114-166.ec2.internal
logging-fluentd-5ljbj                     1/1       Running   0          54m       10.130.0.2    ip-10-36-135-94.ec2.internal
logging-fluentd-6l5v3                     1/1       Running   0          54m       10.128.0.3    ip-10-36-245-6.ec2.internal
logging-fluentd-p0b4r                     1/1       Running   0          54m       10.131.0.2    ip-10-36-216-28.ec2.internal
logging-fluentd-vfkfz                     1/1       Running   0          54m       10.129.0.29   ip-10-36-114-166.ec2.internal
logging-kibana-1-3d3hd                    2/2       Running   0          55m       10.129.0.26   ip-10-36-114-166.ec2.internal

{{< /highlight >}}

{{% /panel %}}
{{% panel "Web Console" %}}
To verify that the components of the logging stack are running using the Web
Console, select the `logging` project from the dropdown at the top of the page
and look at the things running in that project.

You should see `1 pod` beside a dark blue circle beside each of the deployments
as shown in the example below.

{{< figure src="../images/verify_logging.png" class="img-thumbnail" >}}

If you also followed the CLI steps, you'll notice that the view in the Web
Console does not show the additional pods running named `logging-fluentd-<uid>`.

To view these, you can click the **Applications** button in the left column and
select **Pods** to view the running pods. You should have one for each node,
which in the case of this workshop you should have four (4) of them.

{{< figure src="../images/verify_logging_pods.png" class="img-thumbnail" >}}

{{% /panel %}}
{{< /panel_group >}}

### Metrics

The OpenShift metrics stack runs in the `openshift-infra` project.

Verify that each of the components of the metrics stack has successfully started.

{{< panel_group >}}
{{% panel "CLI" %}}
To verify that the components of the metrics stack are running, take a look at
the `DeploymentConfig` for each of them.

The `DESIRED` and `CURRENT` values should match for each.

{{< highlight bash >}}
oc get replicationcontroller -n openshift-infra
{{< /highlight >}}

Expected output:

{{< highlight bash "hl_lines=3-5" >}}
[ec2-user@master ~]$ oc get replicationcontroller -n openshift-infra
NAME                   DESIRED   CURRENT   READY     AGE
hawkular-cassandra-1   1         1         1         46m
hawkular-metrics       1         1         1         46m
heapster               1         1         1         46m
{{< /highlight >}}

As an additional check, take a look at the `Pod` for each of them.

The `STATUS` should be `Running` and `READY` should be `1/1`.

{{< highlight bash >}}
oc get pod -n openshift-infra
{{< /highlight >}}

Expected output:

{{< highlight bash "hl_lines=3-5" >}}
[ec2-user@master ~]$ oc get pod -n openshift-infra
NAME                         READY     STATUS    RESTARTS   AGE
hawkular-cassandra-1-cfn61   1/1       Running   0          46m
hawkular-metrics-473rj       1/1       Running   0          46m
heapster-3qzs0               1/1       Running   0          46m
{{< /highlight >}}

{{% /panel %}}
{{% panel "Web Console" %}}
To verify that the components of the metrics stack are running using the Web
Console, select the `openshift-infra` project from the dropdown at the top of
the page and look at the things running in that project.

You should see `1 pod` beside a dark blue circle beside each of the deployments
as shown in the example below.

{{< figure src="../images/verify_metrics.png" class="img-thumbnail" >}}

{{% /panel %}}
{{< /panel_group >}}
