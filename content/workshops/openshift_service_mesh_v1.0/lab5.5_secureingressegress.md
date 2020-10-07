---
title: Security - Securing Ingress and Egress
workshops: openshift_service_mesh_v1.0
workshop_weight: 55
layout: lab
---

# Securing Ingress and Egress
In cases where strict security is required we need to configure specifics around securing ingress and egress traffic. Security around egress is often used to lock down and deny access to potentially harmful resources outside the network. Additionally, it is a good practice to prevent malicious activities from originating from the cluster.

You are probably already familiar with basic ingress security concepts. Essentially, only exposing particular services to be accessible from outside the cluster and using basic TLS/SSL. The service mesh has an ingress router (a standalone Envoy) running by default and we already configured it during the "Deploying an App into the Service Mesh" lab.

An even better way to track/lockdown inbound traffic for our microservices is to leverage API management in front of all the API services. We could do this with a service mesh plugin for 3scale. We aren't going to walk through it today - if that's something that interest you, [read more about that here][7] [and here][8].

For now let's lockdown egress.

## Lock Down Egress
In this example we are going to restrict access to external endpoints to only approved hosts. The service mesh has an egress router (a standalone Envoy) running by default and we just need to configure it.

The `ServiceMeshControlPlane` custom resource we used to install Istio has a `global` config which allows control of the defaults for egress security. That looks like this:

```
# Set the default behavior of the sidecar for handling outbound traffic from the application:
# ALLOW_ANY - outbound traffic to unknown destinations will be allowed, in case there are no
#   services or ServiceEntries for the destination port
# REGISTRY_ONLY - restrict outbound traffic to services defined in the service registry as well
#   as those defined through ServiceEntries  
outboundTrafficPolicy:
  mode: REGISTRY_ONLY
```

The mesh you're using in this workshop should already have the mode set to `REGISTRY_ONLY`. Let's verify that in the auto-generated config map:

<blockquote>
<i class="fa fa-terminal"></i>
Run this command and look for outboundTrafficPolicy
</blockquote>

```
oc describe cm/istio -n istio-system
```

<br>

<blockquote>
<i class="fa fa-terminal"></i>
Now let's verify it's working - Run this command to scrape some data:
</blockquote>

```
oc run curl-scraper-1 -i --restart=Never --image=appropriate/curl --timeout=30s -- -v context-scraper:8080/scrape/custom_search?term==skynet
```

We should get an output similar to the one below, with error of ECONNRESET:

```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0*   Trying 172.30.83.172...
* TCP_NODELAY set
* Connected to context-scraper (172.30.83.172) port 8080 (#0)
> GET /scrape/custom_search?term==skynet HTTP/1.1
> Host: context-scraper:8080
> User-Agent: curl/7.59.0
> Accept: */*
>
< HTTP/1.1 500 Internal Server Error
< x-powered-by: Express
< access-control-allow-origin: *
< content-type: application/json; charset=utf-8
< content-length: 682
< etag: W/"2aa-5GVBTSjlqUqotSZU1yZmOHgTWC0"
< date: Thu, 07 May 2020 23:02:45 GMT
< x-envoy-upstream-service-time: 36
< server: istio-envoy
< x-envoy-decorator-operation: context-scraper.user3.svc.cluster.local:8080/*
<
{ [682 bytes data]
100   682  100   682    0     0  16634      0 --:--:-- --:--:-- --:--:-- 16634
* Connection #0 to host context-scraper left intact
{"oops":{"name":"RequestError","message":"Error: read ECONNRESET","cause":{"errno":"ECONNRESET","code":"ECONNRESET","syscall":"read"},"error":{"errno":"ECONNRESET","code":"ECONNRESET","syscall":"read"},"options":{"method":"GET","uri":"https://www.googleapis.com/customsearch/v1/siterestrict","qs":{"key":"AIzaSyDRdgirA2Pakl4PMi7t-8LFfnnjEFHnbY4","cx":"005627457786250373845:lwanzyzfwji","q":"=skynet"},"headers":{"user-agent":"curl/7.59.0","x-request-id":"d78cf7b9-0010-9ecf-b520-f3d6a83376a0","x-b3-traceid":"21b58b1725b20a81f914496d9a55455d","x-b3-spanid":"f914496d9a55455d","x-b3-sampled":"1"},"json":true,"simple":true,"resolveWithFullResponse":false,"transform2xxOnly":false}}}
```

Which is curl (running in a pod in our project) trying to talk to the context-scraper microservice (in the mesh). You can see from the error details that the service is trying to get out to googleapis.com but fails.

<br>

<blockquote>
<i class="fa fa-desktop"></i>
(Optional) If you were to look at Kiali now you'd see the request going to a blackhole:
</blockquote>

<img src="../images/kiali-egress-blackhole.png" width="1024" class="screenshot"><br/>

<br>

## Allow Egress to Approved Hosts
Now we will be using an Istio API object of type [ServiceEntry][5] to allow controlled egress. After you add this ServiceEntry, our microservices (via their Envoy sidecars) can send traffic to the specified external service as if it was a service in your mesh.

Our ServiceEntry looks like this:
```
apiVersion: networking.istio.io/v1alpha3
kind: ServiceEntry
metadata:
  name: context-scraper-egress
spec:
  hosts:
  - www.googleapis.com
  ports:
  - number: 443
    name: https
    protocol: HTTPS
  resolution: DNS
  location: MESH_EXTERNAL
```

<br>

<blockquote>
<i class="fa fa-terminal"></i>
Apply it with the following command:
</blockquote>

```
oc apply -f ./istio-configuration/serviceentry-googleapis.yaml
```

<br>

<blockquote>
<i class="fa fa-terminal"></i>
Run a new curl job to try scrape some data again:
</blockquote>

```
oc run curl-scraper-2 -i --restart=Never --image=appropriate/curl --timeout=30s -- context-scraper:8080/scrape/custom_search?term==skynet
```


Now we should get an output similar to the one below - showing results:

```
custom_search?term==skynet
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0[{"link":"https://www.reddit.com/r/movies/comments/1jqo8m/in_the_terminator_franchise_what_does_skynet/","title":"In the Terminator franchise, what does Skynet actually want? : movies","snippet":"Skynet perceived this as an attack and came to the conclusion that all of \nhumanity would attempt to destroy it. To defend itself, Skynet launched nuclear \nmissiles ..."},{"link":"https://www.reddit.com/r/incremental_games/comments/akfdz3/skynet_in_alpha_v2_10min_feedback_welcome/","thumbnail":[{"src":"https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSq88CbTfa-lnWG4n7Y3xEVP4mD4A66tKWsBRRKJi7uPmPhacMeeVuexYI","width":"310","height":"163"}],"title":"Skynet. In Alpha v2 (~10min). Feedback welcome ...","snippet":"r/incremental_games: This subreddit is for lovers of games that feature an \nincremental mechanism, such as unlocking progressively more powerful …"},{"link":"https://www.reddit.com/r/DeepBrainChain/comments/8rar5b/deepbrain_chain_launches_skynet_project/","thumbnail":[{"src":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrwBIFnOZygv1EKJ1z7TnNeWIfom8Kp0Zgbs6YvM4DXYP0zvra6GNCnh0","width":"225","height":"225"}],"title":"DeepBrain Chain Launches ''Skynet Project''— Recruiting AI ...","snippet":"To achieve that, DeepBrain Chain Foundation will activate the ''Skynet Project'' \non June 15th Beijing time and, recruit AI computing power from the globe."},{"link":"https://www.reddit.com/r/OutOfTheLoop/comments/24obct/what_is_skynet_and_why_do_people_reference_it/","thumbnail":[{"src":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrwBIFnOZygv1EKJ1z7TnNeWIfom8Kp0Zgbs6YvM4DXYP0zvra6GNCnh0","width":"225","height":"225"}],"title":"What is Skynet and why do people reference it often? : OutOfTheLoop","snippet":"It is a reference to the movie Terminator. Skynet is the fictional computer entity \nwhich becomes self-aware and takes over all other computers it is linked to. Then\n, ..."},{"link":"https://www.reddit.com/r/linux/comments/2vyhr6/apparently_terminator_runs_linux_version/","thumbnail":[{"src":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSpw8eEnexhK7SlaTQPtFUIqBZYb-Qt5Pa28s8fPAMI4uydC7nmbCc_bU","width":"300","height":"168"}],"title":"Apparently Terminator runs Linux version 4.1.15-1.1381 ...","snippet":"The real question is why skynet bothers making visuals displays for data. \nContinue this thread. level 1. ptrwis. 177 points · 5 years ago. It's systemd, \nevolved and ..."},{"link":"https://www.reddit.com/r/siacoin/comments/elqcyi/taek_teases_skynet_huge_news_in_the_pipeline/","thumbnail":[{"src":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcez9TMXJ9S-onsmNDs7ZxIJEdM8hhhneEJgjELCbomsACnBA2ywgnPvo","width":"152","height":"331"}],"title":"Taek teases Skynet - huge news in the pipeline, game-changing ...","snippet":"r/siacoin: Sia is a cryptocurrency engineered to provide industrial grade cloud \nstorage at consumer prices."},{"link":"https://www.reddit.com/r/incremental_games/comments/98oj1p/skynet_in_alpha_5min_feedback_welcome/","thumbnail":[{"src":"https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSq88CbTfa-lnWG4n7Y3xEVP4mD4A66tKWsBRRKJi7uPmPhacMeeVuexYI","width":"310","height":"163"}],"title":"Skynet. In Alpha (~5min). Feedback welcome : incremental_games","snippet":"r/incremental_games: This subreddit is for lovers of games that feature an \nincremental mechanism, such as unlocking progressively more powerful …"},{"link":"https://www.reddit.com/r/AskScienceFiction/comments/3msulj/terminator_why_doesnt_skynet_use_bio_weapons/","thumbnail":[{"src":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrwBIFnOZygv1EKJ1z7TnNeWIfom8Kp0Zgbs6YvM4DXYP0zvra6GNCnh0","width":"225","height":"225"}],"title":"[Terminator] why doesn't skynet use bio weapons? : AskScienceFiction","snippet":"When skynet came online initially it calculated that humanities greatest threat \nwas itself and so it launched our best weapons against Americas most well ..."},{"link":"https://www.reddit.com/r/AskScienceFiction/comments/9yp425/terminator_why_does_skynet_only_send_robots_back/","thumbnail":[{"src":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrwBIFnOZygv1EKJ1z7TnNeWIfom8Kp0Zgbs6YvM4DXYP0zvra6GNCnh0","width":"225","height":"225"}],"title":"[Terminator] Why does Skynet only send robots back within one life ...","snippet":"Skynet's existence exists as a mobius strip in time, centered around Judgement \nDay. Judgement Day is inevitable, and nothing can stop it from taking place."},{"link":"https://www.reddit.com/r/AskScienceFiction/comments/7q7766/terminator_why_doesnt_skynet_just_poison_the/","thumbnail":[{"src":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrwBIFnOZygv1EKJ1z7TnNeWIfom8Kp0Zgbs6YvM4DXYP0zvra6GNCnh0","width":"225","height":"225"}],"title":"[Terminator] Why doesn't Skynet just poison the atmosphere if they ...","snippet":"Skynet uses Terminators because, so far as it is concerned100  5049  100  5049    0     0   9350      0 --:--:-- --:--:-- --:--:--  9332e humans. It's goal is to \nfulfill ..
```

<br>

If we wanted to we could now configure virtual services and destination rules to control traffic to the service entry in a more granular way. The same way we configured traffic for the other services in our mesh. 

And Kiali tracks this ServiceEntry too, let's look at the graph to see how things are visualized.

<br>

<blockquote>
<i class="fa fa-desktop"></i>
(Optional) And now, if your were to open the graph view of Kiali you'd see the external service represented
<br>
</blockquote>

<img src="../images/kiali-egress.png" width="1024" class="screenshot"><br/>

<br>

# Summary
Congrats! You successfully locked down egress to known external hosts and configured tracking of that via the Service Mesh. This is an advanced capability of the mesh - and you can read more about managing [ingress here][1] and [egress here][2]. 

A few key highlights are:

* We can lock down egress traffic to only approved external endpoints or services
* We can lock down ingress traffic to only approved external endpoints or services
* We can secure ingress traffic via standard TLS or mutual TLS
* We can leverage 3scale API management to limit who can access exposed APIs and how


[1]: https://istio.io/docs/tasks/traffic-management/ingress/
[2]: https://istio.io/docs/tasks/traffic-management/egress/
[3]: https://istio.io/docs/ops/best-practices/security/
[4]: https://istio.io/docs/tasks/traffic-management/ingress/secure-ingress-mount/
[5]: https://istio.io/docs/concepts/traffic-management/#service-entries
[6]: https://archive.istio.io/v1.4/docs/tasks/traffic-management/egress/egress-control/
[7]: https://docs.openshift.com/container-platform/4.3/service_mesh/threescale_adapter/threescale-adapter.html
[8]: https://www.redhat.com/en/technologies/jboss-middleware/3scale

{{< importPartial "footer/footer.html" >}}