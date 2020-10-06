---
title: Security - Verifying mTLS
workshops: openshift_service_mesh_v1.0
workshop_weight: 52
layout: lab
---

# Checking and Verification of mTLS
OK, now that all our services are encrypting traffic Let's take a look in Kiali to see our encryption setup.

<blockquote>
<i class="fa fa-desktop"></i>
Open up the dashboard to Kiali (if you don't already have it open) and navigate to the Graph view.
<br>
In the first drop down select the "Service graph" and in the "Display" drop down make sure the "Security" check box is checked.
</blockquote>

You should see something like this screenshot with little locks indicating that mTLS is working for service-to-service communication.

<img src="../images/kiali-mtls.png" width="1024" class="screenshot"><br/>
<br>
<br>

<blockquote>
<i class="fa fa-desktop"></i>
Click on the line connecting our app-ui to the boards service.
</blockquote>

You will see that the mTLS is also indicated in the connection details view:

<img src="../images/kiali-mtls-connection.png" width="300"><br/>
<br>
<br>

<blockquote>
<i class="fa fa-terminal"></i>
OK, let's try to run that same command again to snoop on traffic. Run the following:
</blockquote>

```
oc run curl-boards-2 -i --restart=Never --image=appropriate/curl --timeout=10s -- boards:8080/shareditems
```

You should get an output indicating that the job failed to pull data. This is because the traffic didn't come from a verifiable service known to the mesh and wasn't able to do a secure mTLS token handshake. Your output should look like this:
```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
curl: (56) Recv failure: Connection reset by peer
pod microservices-demo/curl-boards terminated (Error)
```

## Turn off Strict Mode
Let's turn strict mode back off, we will be doing some intentionally insecure things in the next couple labs.

<blockquote>
<i class="fa fa-terminal"></i>
Type the following in the CLI
</blockquote>

```
oc delete policy/default
oc delete dr --all
```


## More About mTLS Options
mTLS in the service mesh isn't *just* an ON/OFF capability. We kept it basic for the lab, but you could have easily chosen specific services to enforce it on. PERMISSIVE mode is especially useful in a scenario where want to migrate your existing services’ traffic from plain text to mTLS. It allows a service to accept both plaintext traffic and mutual TLS traffic at the same time (without breaking live traffic).

You can also configure the Service Mesh with an [existing root certificate, signing certificate and key][2]. Read about additional security configuration [in the overview here][1] and the [authentication policy section here][3].


## Summary and Architecture Review
That all seems pretty easy to utilize right? Let's dig a little into how it works.

First off, the sidecar and perimeter proxies work as Policy Enforcement Points (PEPs) to secure communication from outside the mesh as well as between services in the mesh (all the client/server connections). And the Service Mesh control plane manages config, certs, and keys. A simplified architecture of that looks like this:

<img src="../images/architecture-security.svg" width="1024"><br/>

The service mesh data plane tunnels service-to-service communication through the PEPs, which are implemented in each Envoy sidecar container. When a workload sends a request to another workload using mutual TLS authentication, the request is handled as follows:

* Outbound traffic is rerouted from a Service A to the local sidecar Envoy running in the same Pod.
* The client-side Envoy starts a mutual TLS handshake with Service B's server-side Envoy. During the handshake, the client-side Envoy also does a secure naming check to verify that the service account presented in the server certificate is authorized to run the target service.
* The client-side Envoy and the server-side Envoy establish a mutual TLS connection, and traffic is forwarded from the client-side Envoy to the server-side Envoy.
* After authorization, the server-side Envoy forwards the traffic to Service B through local TCP connections.

<p>
<i class="fa fa-info-circle"></i>
All of this is configurable via YAML (the control plane will update the Envoy sidecars) and it doesn't require re-build or re-deployment of any services.
</p>


## mTLS Summary
* Provides each service with a strong identity
* Provides a key management system to automate key and certificate generation, distribution, and rotation
* Secures service-to-service communication

The architecture to make all this work is somewhat complicated. If you want to dig into the details, the best place to start is [on this Security Overview page][1].

For frequently asked questions about security check out this [page][4].


[1]: https://istio.io/docs/concepts/security/
[2]: https://istio.io/docs/tasks/security/plugin-ca-cert/
[3]: https://istio.io/docs/concepts/security/#authentication-policies
[4]: https://istio.io/faq/security/

{{< importPartial "footer/footer.html" >}}