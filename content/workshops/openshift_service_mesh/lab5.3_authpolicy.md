---
title: Auth Policy
workshops: openshift_service_mesh
workshop_weight: 53
layout: lab
---

# Authorizing and Authenticating Access via Policy
In the previous labs we secured and verified the service-to-service communication. But what about user-to-service communication (aka origin authentication)? The service mesh can help with that too. To do this, we need to bring in an identity provider that will issue JSON Web Tokens (JWTs) to signed in users. JWTs are an open, industry standard (RFC 7519) way of sharing identity. The app-ui service will pass those JWTs along with it's API requests. This lets the service mesh's sidecar proxies can verify, get role data, and enforce access.

Let's walk through a basic example of restricting service access via AuthorizationPolicy.

## Registered Users Only
In this scenario we want to further secure access to the shared boards list so only logged in users can post to it. And we will do this this purely via the Service Mesh configuration. It's pretty straightforward to do.

<blockquote>
<i class="fa fa-terminal"></i> Apply a new authentication policy with the following command:
</blockquote>

```
sed "s|microservices-demo|$PROJECT_NAME|" ./istio-configuration/policy-boards-jwt.yaml | oc apply -f -
```

This specifies the details of our how to get and verify our JWT. It looks like this:
```
apiVersion: authentication.istio.io/v1alpha1
kind: Policy
metadata:
  name: boards-jwt
  namespace: microservices-demo
spec:
  peers:
  - mtls:
      mode: STRICT
  origins:
  - jwt:
      issuer: "https://securetoken.google.com"
      audiences:
      - "boards"
      jwksUri: "https://www.googleapis.com/oauth2/v1/certs"
      jwtHeaders:
      - "x-goog-iap-jwt-assertion"
      triggerRules:
      - excludedPaths:
        - exact: /health_check
  principalBinding: USE_ORIGIN
```
<p>
<i class="fa fa-info-circle"></i>
We mentioned earlier that JWT shares identity info, the JWKS endpoint gives us keys to verify the data of the JWT is from our trusted source.
</p>

<br>

<blockquote>
<i class="fa fa-terminal"></i> Apply an authorization policy with the following command:
</blockquote>

```
sed "s|microservices-demo|$PROJECT_NAME|" ./istio-configuration/authorization-boards-shared-lockdown.yaml | oc apply -f -
```

That configuration looks like this:
```
apiVersion: security.istio.io/v1beta1
kind: AuthorizationPolicy
metadata:
 name: boards-shareditems-lockdown
 namespace: microservices-demo
spec:
 selector:
   matchLabels:
     app: boards
 rules:
 - from:
   - source:
       principals: ["*"]
   to:
   - operation:
       methods: ["POST"]
       paths: ["/shareditems/*"]
    when:
    - key: request.auth.claims[iss]
        values: ["https://accounts.google.com"]
 ```

An authorization policy includes a selector and a list of rules. The selector specifies the **target** that the policy applies to - in this case our boards microservice. While the rules specify **who** (from) is allowed to do **what** (to) under **which** (when) conditions - in this case anyone can POST Now that we've applied it, let's try to access your boards service when not logged in.

<br>

<blockquote>
<i class="fa fa-desktop"></i> Goto your webapp and shared page of the website
</blockquote>
<blockquote>
<i class="fa fa-desktop"></i> Try to add something to the shared board
</blockquote>

It will fail with the following error

<img src="../images/app-boardsshared-failed.png" width="1024" class="screenshot"><br/>

<br>

<blockquote>
<i class="fa fa-desktop"></i> Login as user "demo" with password "demo"
</blockquote>

<blockquote>
<i class="fa fa-desktop"></i> Try again to add something to the shared board
</blockquote>

Your new item should show in the shared list 

<img src="../images/app-boardsshared-success.png" width="1024" class="screenshot"><br/>

<br>

<blockquote>
<i class="fa fa-terminal"></i> Now let's put things back to normal
</blockquote>

```
oc delete authorizationpolicy/boards-shared-lockdown
```

## How it Works
Our app-ui microservice requests the JWT from the Keycloak SSO when a user logs in. The JWT is always passed (in the header) from the app-ui to any services it calls. All our services have Envoy sidecar proxies running and are seeing the traffic, including the JWT in app-ui requests headers. So the configuration we apply can be used to inform any sidecar proxy to act according to the policies we set. When we weren't logged in there was no JWT to pass along so our call to POST failed. When we were logged in as "demo" user we had a valid JWT and were able to POST.

In our example case here, all traffic for these flows is internal to our cluster. Client-side java script doesn't ever get to see or access the JWT because the app-ui does that in node.js server-side only javascript. If you have the time and want to dig deeper, you should read more about [configuring Keycloak][4] and about [JWTs][3].

Check out highlevel diagrams of the flows we executed below:

<br>
*Fail Case*
<img src="../images/architecture-jwtfail.png" width="600" class="architecture"><br/>
<br>
*Success Case*
<img src="../images/architecture-jwtsuccess.png" width="800" class="architecture"><br/>

## Authorization Policy Summary
* Authorization via dynamically configurable policy
* Secures user-to-service communication
* Utilizes industry standard JSON Web Tokens (JWTs)
* Supports HTTP, HTTPS and HTTP2 natively, as well as any plain TCP protocols
* Policy let's us specify a target, who can do what, and in which condition - [see more examples here][1]
* Pulls some the burden, typically required of individual microservices, up to the platform level and makes it config vs. code

[1]: https://archive.istio.io/v1.4/docs/concepts/security/#authorization
[2]: https://www.keycloak.org/docs/latest/server_admin/#_clients
[3]: https://en.wikipedia.org/wiki/JSON_Web_Token
[4]: https://www.keycloak.org/docs/latest/securing_apps/
[5]: https://istio.io/docs/reference/config/policy-and-telemetry/templates/authorization/

{{< importPartial "footer/footer.html" >}}