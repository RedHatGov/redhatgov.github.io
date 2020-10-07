---
title: Traffic Control - Fault Injection
workshops: openshift_service_mesh_v1.0
workshop_weight: 43
layout: lab
---

# Testing Resiliency with Fault Injection

Your application is working great now with the new version of the user profile service.  But the previous version caused performance issues, and future updates may cause issues in other areas of the application.  How can you test how your application behaves when a failure occurs?

You need a way to simulate failure in the service mesh.  By doing so, you can test if your application functions correctly in a degraded state.  This concept is more generally known as [Chaos Engineering][1].  In Chaos Engineering, you test your software by causing breakdowns in the production environment.

Istio provides ways to inject failure at the application layer with [Delay Faults][2] and [Abort Faults][3] using virtual services.  Let's try this with the paste board application.

## Abort Faults

<blockquote>
<i class="fa fa-terminal"></i>
View the virtual service in your favorite editor or via bash:
</blockquote>

```
cat ./istio-configuration/virtual-service-userprofile-503.yaml
```

Output (snippet):
```
...
  http:
  - fault:
      abort:
        httpStatus: 503
        percent: 50
    route:
    - destination:
        host: userprofile
        subset: v3
...
```

This configuration tells Istio to inject 503 errors into 50% of the traffic sent to the user profile service.

<blockquote>
<i class="fa fa-terminal"></i>
Deploy the routing rule:
</blockquote>

```
oc apply -f ./istio-configuration/virtual-service-userprofile-503.yaml
```

<blockquote>
<i class="fa fa-terminal"></i>
If you aren't already (from previous labs) - Send load to the user profile service:
</blockquote>

```
while true; do curl -s -o /dev/null $GATEWAY_URL/profile; done
```

<br>

Inspect the change in Kiali. 
<blockquote>
<i class="fa fa-desktop"></i>
Navigate to 'Graph' in the left navigation bar. 
</blockquote>

<p><i class="fa fa-info-circle"></i> If you lost the URL, you can retrieve it via:</p>

`echo $KIALI_CONSOLE`

<blockquote>
<i class="fa fa-desktop"></i>
Switch to the 'Versioned app graph' view and change to 'Last 1m'.
</blockquote>
<blockquote>
<i class="fa fa-desktop"></i>
Change the 'No edge labels' dropdown to 'Requests percentage'
</blockquote>

<blockquote>
<i class="fa fa-desktop"></i>
Click on the connection between  the 'app-ui' (square) and 'userprofile' service (triangle).  
</blockquote>

On the right, you should see roughly 50% of requests returned as HTTP errors.

<img src="../images/kiali-userprofile-503.png" width="1024"><br/>
*Kiali Graph with abort faults*

Let's test the application in the browser.

<blockquote>
<i class="fa fa-desktop"></i>
Navigate to the 'Profile' section in the header.  
</blockquote>

<p><i class="fa fa-info-circle"></i> If you lost the URL, you can retrieve it via:</p>

`echo $GATEWAY_URL`

<blockquote>
<i class="fa fa-desktop"></i>
Refresh the brower a couple of times.  
</blockquote>

Sometimes you will see the profile page show up; other times, you will see 'Unknown User'.

Injecting an abort fault is a great mechanism to test how your application handles failure.  In more complex service meshes, you can use this to identify and prevent cascading failures in which an erroring service causes a chain of other services to fail.

<br>

## Delay Faults

Version 2 of the user profile service had a performance issue.  You can synthetically simulate this scenario with delay faults in Istio.

<blockquote>
<i class="fa fa-terminal"></i>
View the virtual service in your favorite editor or via bash:
</blockquote>

```
cat ./istio-configuration/virtual-service-userprofile-delay.yaml
```

Output (snippet):
```
...
  http:
  - fault:
      delay:
        fixedDelay: 5s
        percent: 50
    route:
    - destination:
        host: userprofile
        subset: v3
...
```

This configuration tells Istio to inject a 5 second delay into 50% of the traffic sent to the user profile service.

<blockquote>
<i class="fa fa-terminal"></i>
Deploy the routing rule:
</blockquote>

```
oc apply -f ./istio-configuration/virtual-service-userprofile-delay.yaml
```

<blockquote>
<i class="fa fa-terminal"></i>
If you aren't already - Send load to the user profile service:
</blockquote>

```
while true; do curl -s -o /dev/null $GATEWAY_URL/profile; done
```

<br>

<blockquote>
<i class="fa fa-desktop"></i>
Let's inspect the change in Kiali's embedded Jaeger view.
</blockquote>

<blockquote>
<i class="fa fa-desktop"></i>
From the Graph view right click on the userprofile service (the triangle shape). Then click "show traces"
</blockquote>


<img src="../images/kiali-userprofile-showtraces.png" width="1024"><br/>
*Graphed Service - Right Click Menu*

Notice some the traces are about 5s in duration while others are in the millisecond range.

Injecting a delay fault is a great mechanism to test how your application handles slow outbound service calls.


<img src="../images/kiali-userprofile-faultdelaytraces.png" width="1024"><br/>
*Traces to User Profile Service with Fault Delays*

## Clean up

<blockquote>
<i class="fa fa-terminal"></i>
Revert the changes you made before ending this lab.
</blockquote>

```
oc apply -f ./istio-configuration/virtual-service-userprofile-v3.yaml
```

<br>

## Summary

Congratulations, you configured fault injection with Istio!

A few key highlights are:

* We can test the resiliency of our service mesh using Delay Faults and Abort Faults
* Abort Faults synthetically inject 50x errors in responses to a service call
* Delay Faults synthetically add latency in responses to a service call
* Jaeger can capture performance delays with distributed tracing

[1]: https://en.wikipedia.org/wiki/Chaos_engineering
[2]: https://istio.io/docs/tasks/traffic-management/fault-injection/#injecting-an-http-delay-fault
[3]: https://istio.io/docs/tasks/traffic-management/fault-injection/#injecting-an-http-abort-fault

{{< importPartial "footer/footer.html" >}}