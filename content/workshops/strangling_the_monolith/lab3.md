---
title: Lab - Microservice Integration Patterns
workshops: strangling_the_monolith
workshop_weight: 60
layout: lab
---

# Microservice Integration Patterns

- In previous labs, we created two new microservices with the intention of replacing functionality (“strangling”) the monolithic application.
Currently no traffic is routed to them.
- If you were to re-route traffic from the monolith’s /services/products API to the new catalog service’s /services/catalog endpoint, you would be missing the inventory data.
- In this lab we will consider different options and architectures for integrating the microservices’ functionality into our app.

{{< panel_group >}}
{{% panel "Microservice Integration Pattern Architecture" %}}

<img src="../img/lab3_arch1.png" width="1000" />

{{% /panel %}}
{{< /panel_group >}}

# Example of Microservice Integration Patterns

- This is very similar to our CoolStore retail application!
- UI constructed from multiple microservices implemented across business boundaries
- Typically runs in constrained environments like mobile
- Real-world apps consist of 100s of services

{{< panel_group >}}
{{% panel "Microservice Integration Pattern Example" %}}

<img src="../img/lab3_phone1.png" width="300" />

{{% /panel %}}
{{< /panel_group >}}

## Microservice Integration Patterns Option 1: Client Aggregation

- Microservices implement functionality previously found in monoliths
- Some microservices depend upon other microservices
- Client applications (e.g. web browsers) depend on all of them in one way or another, and are usually “outside the firewall”
- This option means that the client side code (typically run in a browser) is responsible for talking to each microservice and aggregating/combining the results
- Client aggregation benefits
  - No development bottleneck on the server / ESB-style funnel
- Client aggregation drawbacks
  - Network bandwidth/latency of multiple calls to multiple microservices
  - Unfriendly protocols - web proxies, ports, etc
  - Difficulty in later refactoring microservices - the client must change too
  - Client application code complexity


{{< panel_group >}}
{{% panel "Option 1: Client Aggregation" %}}

<img src="../img/lab3_phone2.png" width="700" />

{{% /panel %}}
{{< /panel_group >}}

## Microservice Integration Patterns Option 2: Chaining

- Chaining means that one microservice calls another, which calls another, etc.
- A complete chain is typically not desirable or necessary, but short chains are OK
- Chaining benefits
  - Client code simpler - there is only a single entry into the chain
  - Less network bandwidth (also due to single entry point)
- Chaining drawbacks
  - Potential for cascading failures (resilience patterns can help minimize this)
  - Complex “stack traces” when things go wrong (tracing libraries a must)
  - Exposes internal structure of app logic (the first microservice in the chain would be difficult to change)

  {{< panel_group >}}
  {{% panel "Option 2: Chaining" %}}

  <img src="../img/lab3_phone3.png" width="700" />

  {{% /panel %}}
  {{< /panel_group >}}

## Microservice Integration Patterns Option 3: API Gateway

- The API Gateway pattern:
  - Keeps business logic on server side
  - Aggregates results from back-end services
- API Gateway Pattern benefits
  - Encapsulates internal structure of application’s services
  - Less chatty network traffic
  - Simplified client code (no aggregation)
- Drawbacks
  - Possible bottleneck depending on difficulty of adding new services

  {{< panel_group >}}
  {{% panel "Option 3: API Gateway" %}}

  <img src="../img/lab3_phone4.png" width="700" />

  {{% /panel %}}
  {{< /panel_group >}}
  {{< panel_group >}}
  {{% panel "API Gateway Example" %}}

  <img src="../img/lab3_api_gtw_arch1.png" width="1000" />

  {{% /panel %}}
  {{< /panel_group >}}

# Step 1

- In this lab, the previously developed microservices will be placed behind a gateway service
- The client application will then call the gateway service to retrieve its data
- This will “strangle” the monolith by replacing its catalog/inventory services with new microservices.
- First, deploy the API gateway:

```
$ cd ~/coolstore
$ git clone -b app-partner https://github.com/epe105/gateway
$ cd gateway
$ oc project coolstore-<USERNAME>
$ mvn clean fabric8:deploy -Popenshift -DskipTests

```

# Step 2

- The Coolstore Gateway microservice is a Spring Boot application that implements its logic using an Apache Camel route.
- Take a look at the code for the Gateway:
- In your favorite text editor, open src/main/java/com/redhat/coolstore/api_gateway/ProductGateway.java
- Or in your browser:
  - [https://github.com/modernize-legacy-apps/gateway/blob/master/src/main/java/com/redhat/coolstore/api_gateway/ProductGateway.java](https://github.com/modernize-legacy-apps/gateway/blob/master/src/main/java/com/redhat/coolstore/api_gateway/ProductGateway.java)

```
restConfiguration()
		.contextPath("/services").apiContextPath("/services-docs")
		.apiProperty("host", "")
		.apiProperty("api.title", "CoolStore Gateway API")
		.apiProperty("api.version", "1.0")
		.component("servlet")
		.bindingMode(RestBindingMode.json);

```

- The beginning of this route uses the Camel Java DSL (Domain-Specific Language) to configure the REST system and define the base paths of the API itself (/services) and paths to Swagger documentation (/services-docs).

```
rest("/products").description("Access the CoolStore products and their availability")
            .produces(MediaType.APPLICATION_JSON_VALUE)

```

- This begins the REST DSL portion, defining the primary access point for the catalog of products (/products) and the format of the data it produces (JSON)

```
.get("/").description("Retrieves the product catalog, including inventory availability").outType(Product.class)
    .route().id("productRoute")
          .setBody(simple("null"))
          .removeHeaders("CamelHttp*")
          .recipientList(simple("http4://{{env:CATALOG_ENDPOINT:catalog:8080}}/api/catalog")).end()
          .unmarshal(productFormatter)
          .split(body()).parallelProcessing()
          .enrich("direct:inventory", new InventoryEnricher())
      .end()	            
.endRest();
```

- This configures the endpoint for retrieving a list of products by first contacting the Catalog microservice, .split()ing the resulting list, and enriching (via enrich()) each of the products with its inventory by passing each product to the direct:inventory route.

```
from("direct:inventory")
          .id("inventoryRoute")
          .setHeader("itemId", simple("${body.itemId}"))            
    .setBody(simple("null"))
    .removeHeaders("CamelHttp*")
          .recipientList(simple("http4://{{env:INVENTORY_ENDPOINT:inventory:8080}}/api/inventory/${header.itemId}")).end()
          .setHeader("CamelJacksonUnmarshalType", simple(Inventory.class.getName()))
          .unmarshal().json(JsonLibrary.Jackson, Inventory.class);

```

- This is the direct:inventory route, which takes in a Product object (in the body()) and calls out to the Inventory microservice to retrieve its inventory. The resulting inventory is placed back into the Camel exchange for enrichment by the enricher:

```
@Override
public Exchange aggregate(Exchange original, Exchange resource) {

	// Add the discovered availability to the product and set it back
	Product p = original.getIn().getBody(Product.class);
	Inventory i = resource.getIn().getBody(Inventory.class);
	p.setQuantity(i.getQuantity());
	p.setLocation(i.getLocation());
	p.setLink(i.getLink());
	original.getOut().setBody(p);

	return original;

}
```
- This is the enricher logic which takes the Product and matching Inventory objects, enriches the Product object with information from the Inventory object, and returns it.
- The resulting list sent back to the client is the list of products, each of which is enriched with inventory information
- The client then renders the aggregate list in the UI.

# Step 3

- Now that the gateway microservice is deployed, let’s hook it into the application using OpenShift routing.
- A route is a way to expose a service by giving it an externally-reachable hostname like www.example.com, or in our example www-coolstore.<domain>
- Routes can be created using oc expose command line, or through the GUI.
- Path based routes specify a path component that can be compared against a URL such that multiple routes can be served using the same underlying service/pod, each with a different path.
- In this case, we already have a route that sends all traffic destined for our monolith to the monolith deployment.
- We want to setup a route such that when the monolith’s GUI calls /services/products, it is re-routed to our new CoolStore gateway microservice, thus completing the partial strangulation of the Inventory and Product Catalog features of our app.  

- Navigate to Applications → Routes to list the current routes.
- Notice the www route is the primary route for our monolith:

  <img src="../img/lab3_route1.png" width="1000" />


# Step 4

- Click Create Route to begin creating a new route with the following values:
  - Name: gateway-redirect
  - Hostname: The full hostname of the existing route as seen above (without the http://). For example,
www-coolstore-user21.cloudapps.testworkshop1.openshift.opentlc.com
  - Path: /services/products
  - Service: gateway
  - Leave other values as-is (see next page for complete example)
- Click Create to create the route

{{< panel_group >}}
{{% panel "Create Route" %}}

<img src="../img/lab3_create_route1.png" width="1000" />

{{% /panel %}}
{{< /panel_group >}}

# Step 5

- Test the new route by visiting the application UI (click on the coolstore-prod route in the Overview). It will be no different than the original monolith. How do you know your new microservices are being used in place of the original services?

{{< panel_group >}}
{{% panel "Test New Route to Cool Store" %}}

<img src="../img/lab3_coolstore_before.png" width="1000" />

{{% /panel %}}
{{< /panel_group >}}

# Step 6

- Let’s pretend that there is a lengthy and cumbersome process for getting products and inventories into and out of the backend system.
- We have a high priority task to remove the Red Hat Fedoras from the product list due to a manufacturing defect.
- Let’s filter the product out of the result using our gateway. Open the gateway source code file using your preferred text editor (vi, gedit, etc) and un-comment the lines that implement a filter based on product ID (around line 80).
- The highlighted code shows you the predicate used for the filter
  - ~/coolstore/gateway/src/main/java/com/redhat/coolstore/api_gateway/ProductGateway.jav

```
//
// Uncomment the below lines to filter out products
//
//		.process(exchange -> {
//                    List<Product> originalProductList = (List<Product>)exchange.getIn().getBody(List.class);
//                    List<Product> newProductList = originalProductList.stream().filter(product ->
//							!("329299".equals(product.itemId)))
//						.collect(Collectors.toList());
//                    exchange.getIn().setBody(newProductList);
//                })
```

# Step 7

- Re-deploy the modified code using the same procedure as before:

```
$ cd ~/coolstore/gateway
$ mvn clean fabric8:deploy -Popenshift -DskipTests
% oc logs -f dc/gateway
...
--> Success       # --> wait for it!
```

# Step 8

- Once the new version of the code is deployed and up and running, reload the browser and the Red Hat Fedora product should be gone:

{{< panel_group >}}
{{% panel "See Changes to Cool Store" %}}

<img src="../img/lab3_coolstore_after.png" width="1000" />

{{% /panel %}}
{{< /panel_group >}}

# Congratulations!!!

- Our monolith’s UI is now talking to our new Camel-based API Gateway to retrieve products and inventories from our WildFly Swarm and Spring Boot microservices!
- Further strangling can eventually eliminate the monolith entirely.

<img src="../img/lab3_api_gtw_arch1.png" width="600" />
