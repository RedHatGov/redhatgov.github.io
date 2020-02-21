---
title: Routing Traffic
workshops: openshift_service_mesh
workshop_weight: 41
layout: lab
---

# Basics on Routing Traffic Through the Mesh

One of Istio's core capabilities is the ability to dynamically control how services communicate without modifying the application code itself.  The general concept is called [Traffic Management][1].  It allows you to do things such as A/B test, canary rollouts, rollbacks, and more.  

The two core API objects for traffic management are the [Virtual Service][2] and the [Destination Rule][3].  The destination rule is for the owner of a microservice - what versions do I expose and what happens to traffic before it reaches my service?  The virtual service is for the client of a microservice - how do I want to route traffic to the microservice?

For example, a destination rule can expose two versions of a service (e.g. 'v1', 'v2') and prescribe different load balancing policies for each version.  Then, a virtual service can split traffic to each of those versions when the microservice is called by a client.

## Traffic Routing

Traffic routing rules have been constructed for you already.  Navigate to the Istio resources.
```
cd $HOME/openshift-microservices/deployment/install/microservices/istio-configuration
```

View the destination rules in your favorite editor or via bash:
```
cat destinationrules-all.yaml
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

Most of the destination rules do not have specific configurations.  However, the 'userprofile' destination rule exposes 'subsets' - version of the service that can be called on.  You can see different load balancer policies for versions '1.0' and '2.0'.  By default, Istio uses 'ROUND_ROBIN' load balancing.

View the virtual services in your favorite editor or via bash:
```
cat virtual-services-all-v2.yaml
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

Let's deploy these routing rules:
```
oc apply -f destinationrules-all.yaml 
oc apply -f virtual-services-all-v2.yaml
```

Verify the destination rules:
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

Verify the virtual services:
```
oc get vs
```

Output:
```
NAME                     GATEWAYS                       HOSTS                      AGE
app-ui                                                  [app-ui]                   25m
boards                                                  [boards]                   25m
boards-mongodb                                          [boards-mongodb]           25m
microservices-demo       [microservices-demo-gateway]   [*]                        46h
userprofile                                             [userprofile]              25m
userprofile-postgresql                                  [userprofile-postgresql]   25m
```

Let's test the application UI in the browser.

Navigate to the 'Profile' section in the header.  If you lost the URL, you can retrieve it via:
```
echo $GATEWAY_URL
```

You should see the following:

*Show profile page v2*

There should be no change at this point.  We are routing to version 2 of the user profile service we deployed in an earlier lab.

Let's see what this looks like in Kiali.

Navigate to 'Graph' in the left navigation bar. If you lost the URL, you can retrieve it via:
```
echo $KIALI_CONSOLE
```

Switch to the 'Versioned app graph' view.  You should see the version of the user profile service being called, '2.0'.

*Show versioned app graph with version 2*

## Change Traffic Routing

One of the advantages of Istio is that you can change traffic routing without modifying application code.  Let's pretend there is an issue with version 2 of our profile service and you need to roll back.  All you need to do is change your virtual service configuration.

View the modified virtual service in your favorite editor or via bash:
```
cat virtual-service-userprofile-v1.yaml
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

Deploy the change:
```
oc apply -f virtual-service-userprofile-v1.yaml
```

Verify the change:
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

In the application UI, navigate to the 'Profile' section in the header.

You should see the following:

*Show profile page v1*

We are now seeing version 1 of the user profile service!

In Kiali, navigate to 'Graph' in the left navigation bar.

Switch to the 'Versioned app graph' view.  You should see the version of the user profile service being called, '1.0'.

*Show versioned app graph with version 1*

Congratulations, you configured traffic routing with Istio!

[1]: https://istio.io/docs/concepts/traffic-management
[2]: https://istio.io/docs/concepts/traffic-management/#virtual-services
[3]: https://istio.io/docs/concepts/traffic-management/#destination-rules

{{< importPartial "footer/footer.html" >}}