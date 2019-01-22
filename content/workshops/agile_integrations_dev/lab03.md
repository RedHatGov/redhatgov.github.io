---
title: Lab 03 - Swagger to REST
workshops: agile_integrations_dev
workshop_weight: 23
layout: lab
---
# Lab 3

## Swagger to REST

### Contract-first API development with a database interface, implemented using Eclipse Che

* Duration: 20 mins
* Audience: Developers and Architects

<br><img src="../images/agenda-03.png "Login" width="900" /><br><br>

## Overview

In the context of defining API's, it's common for a Business Analyst (or Citizen Integrator) to first create an API specification or contract.  By beginning the process with a clearly defined contract, a Developer can easily take the contract and auto-generate the underlying service to implement that API.  This *separation of concern*, whereby a Citizen Integrator and Developer can independently collaborate and contribute to create an end-to-end API implementation, is a powerful method for defining API's.

### Why Red Hat?

Eclipse Che, our online IDE, provides important functionality for implementing API services. In this lab you can see how our API tooling fits together with 3scale, Fuse and OpenShift to create a scalable API.

## Lab Instructions

### Step 1: Create an Eclipse Che environment for your personal use

1.  Open a browser window and navigate to Openshift.

1.  Click on your User Tools Project.

1. Click on the link for Eclipse Che.

1. Use your unique username as your workspace name e.g. userX.  

1. Select "day in the life workshop" stack, increase the RAM to 4GB and then click **Create**.

    <br><img src="../images/00-new-workspace.png "New Workspace" width="900" /><br><br>

1. Click on **Create** to generate and open the workspace.

    <br><img src="../images/00-open-workspace.png "Open Workspace" width="900" /><br><br>

1.  Click on **Open in IDE**

1.  Once in the CHE IDE, Click **Start**

### Step 2: Create your own personal Openshift project and setup a sample database

1. Open a browser window and navigate to Openshift

1. Click on your unique namespace to enter your workspace e.g. `user39`.

    <br><img src="../images/00-create-ocp-project.png "Create Project" width="900" /><br><br>

1. Click on **Catalog** on the left menu, then navigate to the **Databases** menu and select **Postgres**.  From there, select the **PostgreSQL** (Ephemeral) template.

    <br><img src="../images/00-select-postgres.png "Select Postgres" width="900" /><br><br>

1. In the pop-up window that appears, click the **Next** button to reach the **Configuration** page.  

1. Update **PostgreSQL Connection Username** to `dbuser` and **PostgreSQL Connection Password** to `password`.

    <br><img src="../images/00-postgres-credentials.png "Postgres Credentials" width="900" /><br><br>

1. Click **Next** and ensure *Do not Bind at this time* is selected.  Click **Create** to generate the service.

1.  Click **Close** once it's created.

### Step 3: Import the skeleton projects from Git and convert them to Maven projects.

1. In Eclipse Che, click on Workspace > Import Project from the main menu.  A pop-up will appear.

    <br><img src="../images/00-import-project.png "Import Project" width="900" /><br><br>

1. Enter your gogs repository.  It should be similar to `http://gogs.apps.ocp-ai.redhatgov.io/userX/dayintheliferepo`, making sure to update `userX` with your unique username.  
  - Select **Import Recursively** and then click **Import**. <br><br>


1. When the "Save" pop-up appears, click the "X" to close the pop-up.

    <br><img src="../images/00-close-save.png "Close Save" width="900" /><br><br>

1. Open the newly created folder, and right-click on the **location-soap2rest** project and select **Convert to Project**

    <br><img src="../images/00-convert-project.png "Convert Project" width="900" /><br><br>

1. Select **Maven** then click **Save**.

    <br><img src="../images/00-select-maven.png "Select Maven" width="900" /><br><br>

1. Convert the remaining projects to Maven, by repeating steps 4 & 5 for the **location-service** and **location-gateway** projects.


### Step 4: Import the Swagger specification

Once you've received the swagger specification (API contract) from your friendly Citizen Integrator, we need to import it into our skeleton Maven project (`location-service`).  Follow these steps:

1. Expand the `location-service` project and right-click on the `src` folder, selecting New > Folder.  Give the folder the name `spec`.

    <br><img src="../images/00-create-spec.png "Create Spec" width="900" /><br><br>

1. Right-click on your newly created spec folder and select New > File.  Name the file `location.yaml`.

    <br><img src="../images/00-location-yaml.png "location" width="900" /><br><br>

1. Copy the contents of this [file](https://raw.githubusercontent.com/epe105/dayinthelife-integration/master/docs/labs/developer-track/resources/Locations.yaml) to your newly created `location.yaml` file.  The file will auto-save so no need to click **Save**.

1. Open the `pom.xml` file, and examine and update the plugin entry for `camel-restdsl-swagger-plugin` located at the bottom of the file.  Take a look at the location of the yaml file, make sure it maps to the one you created.

    ```xml
	  <plugin>
		  <groupId>org.apache.camel</groupId>
		  <artifactId>camel-restdsl-swagger-plugin</artifactId>
		  <version>2.21.0</version>
		  <configuration>
		    <specificationUri>${project.basedir}/src/spec/location.yaml</specificationUri>
		    <className>CamelRoutes</className>
		    <packageName>com.redhat</packageName>
		    <outputDirectory>${project.basedir}/src/main/java</outputDirectory>      
		  </configuration>
	  </plugin>
    ```

    <br><img src="../images/00-terminal.png "terminal" width="900" /><br><br>

1. After you've updated the `pom.xml` file, we need to run a Maven command to generate the Camel RESTdsl from our specification.  To do this, first highlight the `location-service` project then click the **Manage Commands** button.

    <br><img src="../images/00-select-mvn.png "select" width="900" /><br><br>

1. Double-click the **Generate REST DSL from..** script to open the command window.  
  - Click **Run** to execute the script.
  - If everything completes successfully, it should generate a new file under `src/main/java/com/redhat` called `CamelRoutes.java`.  
  - If the Maven script fails, it's probably because you forgot to first highlight the `location-service` project in the previous step.  Be sure to do this and re-run the command to fix the error.

    <br><img src="../images/00-run-mvn.png "run" width="900" /><br><br>

1. Click on the workspace button (located next to the **Manage Commands** button).  
  - Open the `CamelRoutes.java` file under `src/main/java/com/redhat`.  
  - Notice that the `camel-restdsl-swagger-plugin` maven plugin has generated Camel RESTdsl code for the various HTTP GET and POST operations.  
  - What is missing though are the underlying Camel routes, which will form our API service implementations.
  - If the `CamelRoutes.java` hasn't appeared, please right-click on the `location-service` project and click **Refresh** to manually refresh the project tree.

    <br><img src="../images/00-camel-routes.png "camel" width="900" /><br><br>


    ```java
        package com.redhat;

        import javax.annotation.Generated;
        import org.apache.camel.builder.RouteBuilder;
        import org.apache.camel.model.rest.RestParamType;

        /**
         * Generated from Swagger specification by Camel REST DSL generator.
         */
        @Generated("org.apache.camel.generator.swagger.PathGenerator")
        public final class CamelRoutes extends RouteBuilder {
            /**
             * Defines Apache Camel routes using REST DSL fluent API.
             */
            public void configure() {
                rest()
                    .get("/locations")
                        .to("direct:rest1")
                    .post("/locations")
                        .to("direct:rest2")
                    .get("/locations/{id}")
                        .param()
                            .name("id")
                            .type(RestParamType.path)
                            .dataType("integer")
                            .required(true)
                        .endParam()
                        .to("direct:rest3")
                    .get("/location/phone/{id}")
                        .param()
                            .name("id")
                            .type(RestParamType.path)
                            .dataType("integer")
                            .required(true)
                        .endParam()
                        .to("direct:rest4");
            }
        }
    ```


1. Open the generated `CamelRoutes.java` file.  Replace the contents of the CamelRoutes.java with the contents below:


    ```java
    package com.redhat;

    import javax.annotation.Generated;
    import org.apache.camel.builder.RouteBuilder;
    import org.apache.camel.model.rest.RestParamType;
    import com.redhat.processor.*;
    import com.redhat.model.*;
    import org.springframework.stereotype.Component;
    import org.apache.camel.model.rest.RestBindingMode;

        /**
         * Generated from Swagger specification by Camel REST DSL generator.
         */
        @Generated("org.apache.camel.generator.swagger.PathGenerator")
        @Component
        public final class CamelRoutes extends RouteBuilder {
            /**
             * Defines Apache Camel routes using REST DSL fluent API.
             */
            @Override
            public void configure() throws Exception {

                ContactInfoResultProcessor ciResultProcessor = new ContactInfoResultProcessor();
                LocationResultProcessor locationResultProcessor = new LocationResultProcessor();

                restConfiguration()
                .component("servlet")
                .port(8080)
                .bindingMode(RestBindingMode.json)
                .contextPath("/")
                .dataFormatProperty("prettyPrint", "true")
                .enableCORS(true)
                .apiContextPath("/api-doc")
                .apiProperty("api.title", "Location and Contact Info API")
                .apiProperty("api.version", "1.0.0")
            ;

                rest()
                .get("/locations")
                    .to("direct:getalllocations")
                .post("/locations")
                    .type(Location.class)
                    .to("direct:addlocation")
                .get("/locations/{id}")
                    .param()
                        .name("id")
                        .type(RestParamType.path)
                        .dataType("integer")
                        .required(true)
                    .endParam()
                    .to("direct:getlocation")
                .get("/location/phone/{id}")
                    .param()
                        .name("id")
                        .type(RestParamType.path)
                        .dataType("integer")
                        .required(true)
                    .endParam()
                    .outType(ContactInfo.class)
                    .to("direct:getlocationdetail")
            ;

                from("direct:getalllocations")
                    .to("sql:select * from locations?dataSource=dataSource")
                    .process(locationResultProcessor)
                    .log("${body}")
            ;

                from("direct:getlocation")
                    .to("sql:select * from locations where id=cast(:#id as int)?dataSource=dataSource")
                    .process(locationResultProcessor)
                    .choice()
                        .when(simple("${body.size} > 0"))
                            .setBody(simple("${body[0]}"))
                        .otherwise()
                            .setHeader("HTTP_RESPONSE_CODE",constant("404"))
                    .log("${body}")
            ;

                from("direct:addlocation")
                            .log("Creating new location")
                    .to("sql:INSERT INTO locations (id,name,lat,lng,location_type,status) VALUES (:#${body.id},:#${body.name},:#${body.location.lat},:#${body.location.lng},:#${body.type},:#${body.status});?dataSource=dataSource")
                ;

                from("direct:getlocationdetail")
                    .to("sql:select * from location_detail where id=cast(:#id as int)?dataSource=dataSource")
                    .process(ciResultProcessor)
            ;                
          }
        }

    ```

1. Next, notice instantiation of our newly created Result Processors' with the include the necessary imports.

    ```java
    ...
    import com.redhat.processor.*;
    import com.redhat.model.*;
    import org.springframework.stereotype.Component;
    import org.apache.camel.model.rest.RestBindingMode;
    ...
    ```


1. As we're using SpringBoot, we also include the `@Component` declaration to the class definition statement (under the `@Generated`).

    ```java
      ...
    	/**
    	* Generated from Swagger specification by Camel REST DSL generator.
    	*/
    	@Generated("org.apache.camel.generator.swagger.PathGenerator")
    	@Component
    	public class CamelRoutes extends RouteBuilder {
    	...
    ```



1. Next notice the `@Override` statement for our `configure()` method, and include references to our result processors.  


    ```java
	...
	@Override
	public void configure() throws Exception {		

		ContactInfoResultProcessor ciResultProcessor = new ContactInfoResultProcessor();
		LocationResultProcessor locationResultProcessor = new LocationResultProcessor();
	...
    ```

1. In order to startup an HTTP server for our REST service, we instantiate the `restConfiguration` bean with the corresponding properties.

    ```java
	...
		restConfiguration()
			.component("servlet")
        	.port(8080)
        	.bindingMode(RestBindingMode.json)
			.contextPath("/")
        	.dataFormatProperty("prettyPrint", "true")
        	.enableCORS(true)
        	.apiContextPath("/api-doc")
        	.apiProperty("api.title", "Location and Contact Info API")
        	.apiProperty("api.version", "1.0.0")
        ;
	...
    ```

    If the IDE has any issues compiling the code and you receive errors, then navigate to **Project > Configure Classpath** then click **Done**.  This will trigger the compiler to run in the background and should eliminate any errors.

    Notice that we now have both ResultProcessor's instantiated, and we've stood-up an Servlet HTTP listener for our RESTful endpoint, together with some basic self-documenting API docs that describe our new service.

1. Next notice how we implement our Camel routes.  We create 4 routes, each matching their associated HTTP GET / POST endpoint.

    ```java
	...
        from("direct:getalllocations")
			.to("sql:select * from locations?dataSource=dataSource")
			.process(locationResultProcessor)
			.log("${body}")
	     ;

	    from("direct:getlocation")
			.to("sql:select * from locations where id=cast(:#id as int)?dataSource=dataSource")
			.process(locationResultProcessor)
			.choice()
				.when(simple("${body.size} > 0"))
					.setBody(simple("${body[0]}"))
				.otherwise()
					.setHeader("HTTP_RESPONSE_CODE",constant("404"))
			.log("${body}")
	     ;

        from("direct:addlocation")
            		.log("Creating new location")
			.to("sql:INSERT INTO locations (id,name,lat,lng,location_type,status) VALUES (:#${body.id},:#${body.name},:#${body.location.lat},:#${body.location.lng},:#${body.type},:#${body.status});?dataSource=dataSource")
	     ;

        from("direct:getlocationdetail")
			.to("sql:select * from location_detail where id=cast(:#id as int)?dataSource=dataSource")
			.process(ciResultProcessor)
	     ;
	...
    ```

1. Lastly, notice the RESTdsl code to accommodate our new routes.

    ```java
	...
       rest()
            .get("/locations")
                .to("direct:getalllocations")
            .post("/locations")
                .type(Location.class)
                .to("direct:addlocation")
            .get("/locations/{id}")
                .param()
                    .name("id")
                    .type(RestParamType.path)
                    .dataType("integer")
                    .required(true)
                .endParam()
                .to("direct:getlocation")
            .get("/location/phone/{id}")
                .param()
                    .name("id")
                    .type(RestParamType.path)
                    .dataType("integer")
                    .required(true)
                .endParam()
                .outType(ContactInfo.class)
                .to("direct:getlocationdetail")
        ;
    ```

1. Before we test our newly created Camel Routes, we need to update `src/main/resources/application.properties` to point to our Postgres database.  
  - Set the `postgresql.service.name` property to `postgresql.OCPPROJECT.svc` so that it points to our OpenShift service.
  - Replace `OCPPROJECT` with the OpenShift project name you used in the previous step to host Postgres Database (this should be your unique username).

    <br><img src="../images/00-update-properties.png "Update Properties" width="900" /><br><br>

1. Now we are ready to test our new Camel route locally. To do this, navigate back to the **Manage commands** screen, double-click the **run:spring-boot** script and hit **Run**.  The script will run locally in Eclipse Che.

    <br><img src="../images/00-run-locally.png "Maven Deploy" width="900" /><br><br>

1. Once SpringBoot has started-up, right-click the dev-machine (under **Machines**) and select **Servers**.  Click the link corresponding to port 8080.  A new tab should open with a **Page Can't be Found**.

    <br><img src="../images/00-open-servers.png "Open Servers" width="900" /><br><br>

1. Click on the route link above the location-service pod and append `/locations` to the URI.  As a result, you should receive a list of all locations

    <br><img src="../images/00-location-list.png "Location List" width="900" /><br><br>

1. Now that we've tested our API service implementation locally, we can deploy it to our running OpenShift environment.  First we need to login to OpenShift via the Terminal.  Navigate back to the OpenShift web UI and click the **Copy Login Command** link.  

    <br><img src="../images/00-login-ocp-cli.png "OCP CLI Login" width="900" /><br><br>

1.  Navigate back to Eclipse Che, open the terminal, and paste the login command from your clipboard.  Once you've logged-in, select the OpenShift project you used earlier using `oc project userX` (replacing userX with your username).

    <br><img src="../images/00-login-terminal.png "OCP Terminal Login" width="900" /><br><br>

1. To run the fabric8 Maven command to deploy our project, navigate back to the **Manage commands** screen, double-click the **fabric8:deploy** script.   
  1. Click **Run**.  The script will run and deploy to your OCPPROJECT.

    <br><img src="../images/00-mvn-deploy.png "Maven Deploy" width="900" /><br><br>

1. If the deployment script completes successfully, navigate back to your OCPPROJECT web console and verify the pod is running in your UserX project.

    <br><img src="../images/00-verify-location-service.png "Location Service" width="900" /><br><br>

1. Click on the route link above the location-service pod and append `locations` to the URI.  Initially, you may receive a `404` error when opening the route URL, but once you append `locations` and refresh you should receive a list of all locations

    <br><img src="../images/00-location-list.png "Location List" width="900" /><br><br>

1. You can also search for individual locations by adjusting the URI to `/locations/{id}` e.g. `/locations/100`.


1. Lastly, via the Eclipse Che terminal, test the HTTP POST using curl.  You can use the following below. Remember to the Route Link you got previously and replace OCPPROJECT with your username.

    ```bash
	curl --header "Content-Type: application/json" --request POST --data '{"id": 101,"name": "Kakadu","type": "HQ","status": "1","location": {"lat": "78.88436","lng": "99.05295"}}' http://location-service-OCPPROJECT.apps.ocp-ai.redhatgov.io/locations
    ```


1.  If the HTTP POST is successful, you should be able to view it by repeating the HTTP GET /locations test.

*Congratulations!* You have now an application to test your Swagger to RESTdsl integration.

## Summary

You have now successfully created a contract-first API using a Swagger contract together with generated Camel RESTdsl, incorporating both HTTP GET and POST requests that perform select and inserts on a Postgres database table.
