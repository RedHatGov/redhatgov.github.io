---
title: Kiali
workshops: openshift_service_mesh
workshop_weight: 23
layout: lab
---

# Introducing Kiali for Observability

All of your microservices are running in the service mesh.  Now, you need a way to visualize the service mesh topology.  That is, what's running in your service mesh and how are they connected?

Istio provides [Kiali][1], an open source project that gives you a console view of your service mesh.  You can inspect the health of your service mesh, and it has further integrations for metric querying and tracing that we will cover in later labs.

## Explore Kiali

Let's open the Kiali console.  Retrieve the endpoint for Kiali:

```
export KIALI_CONSOLE=$(oc get routes kiali -n istio-system -o jsonpath='{.spec.host}{"\n"}')
echo $KIALI_CONSOLE
```

Output (sample):
```
https://kiali-istio-system.apps.cluster-naa-xxxx.naa-xxxx.example.opentlc.com:6443 
```

Navigate to this URL in the browser.  Login with the same credentials you were provided to access OpenShift.  Once logged in, you should be presented with the Kiali console:

<img src="../images/kiali-welcome.png" width="600"><br/>
 *Kiali Welcome*

Let's take a look at the service mesh topology.  Navigate to 'Graph' in the left navigation bar.  Change the window of the view on the right side from 'Last 1m' to 'Last 1h'.

*Show app graph*

The graph shows the microservices in your service mesh and how they are connected.

> If you don't see connected microservices, navigate to the application UI in another tab via $GATEWAY_URL, add comments to the shared board, and view the profile page.  Refresh Kiali afterwards.  

You can inspect information about the traffic being sent between the services via the edge labels.  Click 'No edge labels' and switch to 'Requests per second'.  You can now see HTTP traffic information between the microservices.

*Show app graph with edge labels*

Let's take a look at the microservices running in your service mesh.  Navigate to  'Applications' in the left navigation bar.

*Show app page*

You can drill down into each microservice from this view.  Select 'app-ui'.

*Show app-ui app page*

You should see the 'Health' of that microservice.  Navigate to the 'Traffic' tab and you should see the inbound and outbound calls made from that microservice.

*Show app-ui inbound/outbound page*

Keep the Kiali console opened in a tab in your browser.  You will use Kiali throughout the remainder of the labs.


[1]: https://kiali.io

{{< importPartial "footer/footer.html" >}}