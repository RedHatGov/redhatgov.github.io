---
title: Observability - Grafana
workshops: openshift_service_mesh_v1.0
workshop_weight: 32
layout: lab
---

# Service Mesh Metrics with Grafana

[Grafana][1] is a monitoring tool that can be integrated with Istio for metric observation.  Using Grafana, you can look at metrics associated with services in your mesh.  Let's use Grafana to get more information about the user profile service.

## Explore Grafana

First, let's explore the Grafana user interface.

<blockquote>
<i class="fa fa-terminal"></i>
Open the Grafana console.  Retrieve the endpoint for Grafana:
</blockquote>

```
GRAFANA_CONSOLE=$(oc get route grafana -n istio-system --template='https://{{.spec.host}}')
echo $GRAFANA_CONSOLE
```
<p><i class="fa fa-info-circle"></i> Click 'Allow selected permissions' if prompted to authorized access.</p>

<blockquote>
<i class="fa fa-desktop"></i>
Navigate to this URL in the browser.  Login with the same credentials you were provided to access OpenShift. 
</blockquote>

Once logged in, you should be presented with the Grafana console:

<img src="../images/grafana-welcome.png" width="600"><br/>
*Grafana Welcome*

<br>

<blockquote>
<i class="fa fa-desktop"></i>
On the left bar, hover over the second icon from the top (Dashboards) and select 'Manage'.  Expand the 'istio' folder.
</blockquote>

It should look like this:

<img src="../images/grafana-istio.png" width="1024"><br/>
*Grafana Istio Dashboards*

<br>

You need to send load to the application before viewing any metrics.

<blockquote>
<i class="fa fa-terminal"></i>
Send load to the application user interface:
</blockquote>

```
while true; do curl -s -o /dev/null $GATEWAY_URL; done
```

<br>

While that is running, let's look at some dashboards.

<blockquote>
<i class="fa fa-desktop"></i>
Select 'Istio Mesh Dashboard' in Grafana.
</blockquote>

It should look like this:

<img src="../images/grafana-istio-mesh.png" width="1024"><br/>
*Grafana Istio Mesh Dashboard*

<br>

This gives you a holistic view of your services and metrics associated with those services.  For example, you can see that globally there are no error responses, and you get a quick snapshot of the throughput and latencies for each service.  But we're missing data on the user profile service so let's send some load to that service.

<blockquote>
<i class="fa fa-terminal"></i>
Open another tab in the terminal. Send load to the user profile service:
</blockquote>

```
GATEWAY_URL=$(oc get route istio-demogateway-$(oc project -q) --template='http://{{.spec.host}}')
while true; do curl -s -o /dev/null $GATEWAY_URL/profile; done
```

The mesh dashboard should dynamically update.  It should look like this now:

<img src="../images/grafana-istio-mesh-updated.png" width="1024"><br/>
*Grafana Istio Mesh Dashboard Updated*

<br>

Notice the userprofile service has two different workloads: userprofile (version 1) and userprofile-2.  Calls to userprofile-2 are vastly slower.  You can further inspect the metrics associated with the service by selecting the service dashboard.

<blockquote>
<i class="fa fa-desktop"></i>
In the Service column, hover over the userprofile FQDN and select it.
</blockquote>

That will take you to the service view, it looks like this:

<img src="../images/grafana-istio-service.png" width="1024"><br/>
*Grafana Istio Service Dashboard*

<br>

These are metrics specific to the user profile service.  Scroll down under 'Service Workloads' and you can see a breakdown of how the different workload versions differ for that service.

<blockquote>
<i class="fa fa-desktop"></i>
Hover over the Incoming Request Duration by Source under 'Service Workloads'.
</blockquote>

It should look like this:

<img src="../images/grafana-istio-service-duration.png" width="1024"><br/>
*Grafana Istio Service Dashboard - Request Duration*

<br>

This provides a visual representation of the latencies we saw on the Mesh Dashboard, and it is clear that the version 2 latencies are much higher.

<br>


[1]: https://grafana.com

{{< importPartial "footer/footer.html" >}}