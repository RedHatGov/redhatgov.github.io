---
title: Traffic Control - Routing Traffic
workshops: openshift_service_mesh_v1.0
workshop_weight: 41
layout: lab
---

# Basics on Routing Traffic Through the Mesh

One of Istio's core capabilities is the ability to dynamically control how services communicate without modifying the application code itself.  The general concept is called [Traffic Management][1].  It allows you to do things such as A/B test, canary rollouts, rollbacks, and more.  

The two core API objects for traffic management are the [Virtual Service][2] and the [Destination Rule][3].  The destination rule is for the owner of a microservice - what versions do I expose and what happens to traffic before it reaches my service?  The virtual service is for the client of a microservice - how do I want to route traffic to the microservice?

For example, a destination rule can expose two versions of a service (e.g. 'v1', 'v2') and prescribe different load balancing policies for each version.  Then, a virtual service can split traffic to each of those versions when the microservice is called by a client.

## Traffic Routing

Traffic routing rules have been constructed for you already.  

<blockquote>
<i class="fa fa-terminal"></i>
View the destination rules in your favorite editor or via bash:
</blockquote>

```
cat ./istio-configuration/destinationrules-all.yaml
```

Output (snippet):
```
...
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: userprofile
spec:
  host: userprofile
  subsets:
  	- name: v1
  	  labels:
  	  	version: 1.0
      trafficPolicy:
        loadBalancer:
          simple: ROUND_ROBIN        
    - name: v2
      labels:
        version: 2.0
      trafficPolicy:
        loadBalancer:
          simple: RANDOM
...
```

Most of the destination rules do not have specific configurations except for the tls configuration, which we will discuss in a later lab.  However, the 'userprofile' destination rule exposes 'subsets' - version of the service that can be called on.  You can see different load balancer policies for versions '1.0' and '2.0'.  By default, Istio uses 'ROUND_ROBIN' load balancing.

<blockquote>
<i class="fa fa-terminal"></i>
View the virtual services in your favorite editor or via bash:
</blockquote>

```
cat ./istio-configuration/virtual-services-all-v2.yaml
```

Output (snippet):
```
...
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: userprofile
spec:
  hosts:
  - userprofile
  http:
  - route:
    - destination:
        host: userprofile
        subset: v2
---
...
```

Most of the virtual services do not have specific configurations.  However, the 'userprofile' virtual service routes specifically to version 'v2' of the 'userprofile' microservice.

<blockquote>
<i class="fa fa-terminal"></i>
Let's deploy these routing rules:
</blockquote>

```
oc apply -f ./istio-configuration/destinationrules-all.yaml 
oc apply -f ./istio-configuration/virtual-services-all-v2.yaml
```

<blockquote>
<i class="fa fa-terminal"></i>
Verify the destination rules:
</blockquote>

```
oc get dr
```

Output:
```
NAME                     HOST                     AGE
app-ui                   app-ui                   24m
boards                   boards                   24m
boards-mongodb           boards-mongodb           24m
userprofile              userprofile              20m
userprofile-postgresql   userprofile-postgresql   16m
```

<blockquote>
<i class="fa fa-terminal"></i>
Verify the virtual services:
</blockquote>

```
oc get vs
```

Output (sample):
```
NAME                     GATEWAYS                       HOSTS                      AGE
app-ui                                                  [app-ui]                   25m
boards                                                  [boards]                   25m
boards-mongodb                                          [boards-mongodb]           25m
context-scraper                                         [context-scraper]          25m
demogateway-userX        [demogateway-userX]            [*]                        44m
userprofile                                             [userprofile]              25m
userprofile-postgresql                                  [userprofile-postgresql]   25m
```

Let's test the application UI in the browser.

<blockquote>
<i class="fa fa-desktop"></i>
Navigate to the 'Profile' section in the header.  
</blockquote>

<p><i class="fa fa-info-circle"></i> If you lost the URL, you can retrieve it via:</p>

`echo $GATEWAY_URL`

There should be no change at this point.  You are routing to version 2 of the user profile service you deployed in an earlier lab, and it is really slow.

<br>

Let's see what this looks like in Kiali.

<blockquote>
<i class="fa fa-terminal"></i>
Send load to the user profile service:
</blockquote>

```
for ((i=1;i<=5;i++)); do curl -s -o /dev/null $GATEWAY_URL/profile; done
```

<br>

<blockquote>
<i class="fa fa-desktop"></i>
Navigate to 'Graph' in the left navigation bar.
</blockquote>

<p><i class="fa fa-info-circle"></i> If you lost the URL, you can retrieve it via:</p>

`echo $KIALI_CONSOLE`

<br>

<blockquote>
<i class="fa fa-desktop"></i>
Switch to the 'Versioned app graph' view and change to 'Last 1m'.  
</blockquote>

You should see traffic flowing to user profile version '2.0'. 

The flow of traffic is indicated by a green highlight in the graph.

<img src="../images/kiali-userprofile-v2.png" width="1024"><br/>
*Kiali Graph with v2 Routing*

<br>

## Change Traffic Routing

One of the advantages of Istio is that you can change traffic routing without modifying application code.  There is a performance issue with version 2 of our profile service so let's roll back to version 1.  All you need to do is change your virtual service configuration.

<blockquote>
<i class="fa fa-terminal"></i>
View the modified virtual service in your favorite editor or via bash:
</blockquote>

```
cat ./istio-configuration/virtual-service-userprofile-v1.yaml
```

Output:
```
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: userprofile
spec:
  hosts:
  - userprofile
  http:
  - route:
    - destination:
        host: userprofile
        subset: v1
```

In this configuration, you will route to 'v1' of the virtual service.

<blockquote>
<i class="fa fa-terminal"></i>
Deploy the change:
</blockquote>

```
oc apply -f ./istio-configuration/virtual-service-userprofile-v1.yaml
```

<blockquote>
<i class="fa fa-terminal"></i>
Verify the change:
</blockquote>

```
oc describe vs userprofile
```

Output (snippet):
```
...
Spec:
  Hosts:
    userprofile
  Http:
    Route:
      Destination:
        Host:    userprofile
        Subset:  v1
Events:          <none>
```

<br>

<blockquote>
<i class="fa fa-desktop"></i>
In the application UI, navigate to the 'Profile' section in the header.  
</blockquote>

The page should load quickly and you are back to routing to version 1 of the user profile service.

<br>

<blockquote>
<i class="fa fa-terminal"></i>
Let's send 100 user profile requests to generate traffic
</blockquote>

```
for ((i=1;i<=100;i++)); do curl -s -o /dev/null $GATEWAY_URL/profile; done
```

<blockquote>
<i class="fa fa-desktop"></i>
Now in Kiali, navigate to 'Graph' in the left navigation bar.
</blockquote>

<blockquote>
<i class="fa fa-desktop"></i>
Switch to the 'Versioned app graph' view and change to 'Last 1m'.  
</blockquote>

You should see traffic flowing to user profile version '1.0'.

The flow of traffic is indicated by a green highlight in the graph.

<img src="../images/kiali-userprofile-v1.png" width="1024"><br/>
*Kiali Graph with v1 Routing*

<br>

## Summary

Congratulations, you configured traffic routing with Istio!

A few key highlights are:

* The two core API objects for traffic management are the Virtual Service and Destination Rule
* We can change which version of a service we call by modifying the Virtual Service
* Kiali provides a service graph view while traffic is flowing in the mesh

[1]: https://istio.io/docs/concepts/traffic-management
[2]: https://istio.io/docs/concepts/traffic-management/#virtual-services
[3]: https://istio.io/docs/concepts/traffic-management/#destination-rules

{{< importPartial "footer/footer.html" >}}