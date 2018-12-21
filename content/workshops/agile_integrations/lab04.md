---
title: Exercise 04 - SOAP to REST API
workshops: agile_integrations
workshop_weight: 24
layout: lab
---
# Exercise 4: Creating a SOAP to REST API

### Contract-first API development wrapping an existing SOAP service, implemented using Eclipse Che

* Duration: 20 mins
* Audience: Developers and Architects

## Exercise Description

Another important use case in developing API's is to take an existing legacy SOAP service and wrap it with a new RESTful endpoint.  This SOAP to REST transformation is implemented in the API service layer (Fuse).  This lab will walk you through taking an existing SOAP contract (WSDL), converting it to Java POJO's and exposing it using Camel REST DSL.

### Why Red Hat?

Eclipse Che, our online IDE, provides important functionality for implementing API services. In this lab, you can see how our Eclipse Che and Fuse can help with SOAP to REST transformation on Red Hat OpenShift Container Platform.

## Section 1: Import the sample SOAP project into your Red Hat OpenShift Container Platform project.

### Step 1. Navigate back to your Eclipse Che workspace and open the terminal window.

    <br><img src="../images/00-open-terminal.png "Open Terminal" width="900" /><br><br>

### Step 2. Log into the OpenShift console:

	<br><img src="../images/00-openshift-loginpage.png "Commend Login" width="900" /><br><br>

### Step 3. Obtain your user login command by clicking your username, on the top right hand corner, and select **Copy Login Command**

	<br><img src="../images/00-commend-login.png "Commend Login" width="900" /><br><br>

### Step 4. Paste the login command for OpenShift via the Terminal window. Double check the {OPENSHIFT_APP_URL} matches the environment given to you by the instructor

    ```bash
    oc login  {OPENSHIFT_APP_URL} --token=XXXXX
    ```


### Step 5. Build and deploy the SOAP application using the source to image(S2i) template. Paste the following command to the terminal.

    ```bash
    oc new-app s2i-fuse71-spring-boot-camel -p GIT_REPO=https://github.com/epe105/dayinthelife-integration -p CONTEXT_DIR=/projects/location-soap -p APP_NAME=location-soap -p GIT_REF=master -n [OCPPROJECT]
    ```


     *Remember to replace the **[OCPPROJECT]** with the OpenShift project(NameSpace) you created in last lab.  [OCPPROJECT] should be your username*

### Step 6. Once the build and deploy is complete, navigate back to your OpenShift web console and verify that the project is running.

    <br><img src="../images/00-verify-location-soap.png "Verify Pod" width="900" /><br><br>


## Section 2: Modify the skeleton location-soap2rest project

### Step 1. In the OpenShift console, click on the route associated with the `location-soap` deployment.  A pop-up will appear.  Append the `/ws/location?wsdl` path to the URI and verify the WSDL appears. Copy the link to the clipboard.

    <br><img src="../images/00-verify-wsdl.png "Verify WSDL" width="900" /><br><br>

### Step 2. Return to your Eclipse Che workspace and open the `dayintelife-import/location-soap2rest` project.  Open the `pom.xml` file and scroll to the bottom.  Uncomment out the `cxf-codegen-plugin` entry at the bottom.  

### Step 3. Update the `<wsdl>` entry with your fully qualified WSDL URL e.g. `http://location-soap-userX.apps.ocp-devsecops2.redhatgov.io/ws/location?wsdl`. *Be sure to replace userX with your username.*

    <br><img src="../images/00-uncomment-codegen.png "Uncomment codegen plugin" width="900" /><br><br>

### Step 4. Generate the POJO objects from the WSDL contract.  To do this, change to the **Manage commands** view and double-click the `run generate-sources` script.  Click **Run** to execute the script.

    <br><img src="../images/00-generate-sources.png "Generate Sources" width="900" /><br><br>

### Step 5. Once the script has completed, navigate back to the **Workspace** view and open the `src/main/java/com/redhat` folder.  

Note: Notice that there are a bunch of new POJO classes that were created by the Maven script.

    <br><img src="../images/00-verify-pojos.png "Verify Pojos" width="900" /><br><br>

### Step 6. Open up the `CamelRoutes.java` file.  Notice that the existing implementation is bare-bones. First, we need to enter the SOAP service address and WSDL location, for our CXF client, to call after the camelContect and before the @Override.

    ```java
	...

	@Autowired
	private CamelContext camelContext;

	private static final String SERVICE_ADDRESS = "http://localhost:8080/ws/location";
	private static final String WSDL_URL = "http://localhost:8080/ws/location?wsdl";

	@Override
	public void configure() throws Exception {
    ```
### Step 7. Next, after the restConfiguration() method, we  create a Camel route implementation and create the RESTful endpoint.  To do this, include the following code (making sure to update the **{YOUR_NAME_SPACE}**,  **{OPENSHIFT_APP_URL}** and username values in the `to("cxf://` URL):

       In this case **YOUR_NAME_SPACE** should be *userX* and **{OPENSHIFT_APP_URL}** would be *dil.opentry.me*. Check with your instructor if you are not sure.

    ```java
	...

		rest("/location").description("Location information")
			.produces("application/json")
			.get("/contact/{id}").description("Location Contact Info")
				.responseMessage().code(200).message("Data successfully returned").endResponseMessage()
				.to("direct:getalllocationphone")

		;

		from("direct:getalllocationphone")
			.setBody().simple("${headers.id}")
			.unmarshal().json(JsonLibrary.Jackson)
			.to("cxf://http://location-soap-{YOUR_NAME_SPACE}.{OPENSHIFT_APP_URL}/ws/location?serviceClass=com.redhat.LocationDetailServicePortType&defaultOperationName=contact")

			.process(
					new Processor(){

						@Override
						public void process(Exchange exchange) throws Exception {
							//LocationDetail locationDetail = new LocationDetail();
							//locationDetail.setId(Integer.valueOf((String)exchange.getIn().getHeader("id")));

							MessageContentsList list = (MessageContentsList)exchange.getIn().getBody();

							exchange.getOut().setBody((ContactInfo)list.get(0));
						}
					}
			)

		;

	    }
	}
    ```

Now that we have our API service implementation, we can try to test this locally.  

### Step 8. Navigate back to the **Manage commands** view and execute the `run spring-boot` script.  
  - **Make sure any previous runs from prior labs are stopped**
  - Click the **Run** button.

    <br><img src="../images/00-local-testing.png" width="900" /><br><br>

### Step 9. Once the application starts, navigate to the Servers window and click the URL corresponding to port 8080.  A new tab displays:

    <br><img src="../images/00-select-servers.png" width="900" /><br><br>

### Step 10. In the new tab, append the URL with the following URI: `/location/contact/2`
  - A contact should be returned:

    <br><img src="../images/00-hit-contact-local.png" width="900" /><br><br>

### Step 11. Now that we've successfully tested our new SOAP to REST service locally, we can deploy it to OpenShift.  Stop the running application by clicking **Cancel**.  


### Step 12. Open the `fabic8:deploy` script and click the **Run** button to deploy it to OpenShift.

    <br><img src="../images/00-mvn-f8-deploy.png" "Maven Fabric8 Deploy" width="900" /><br><br>


### Step 13. If the deployment script completes successfully, navigate back to your OCPPROJECT web console and verify that the pod is running.

    <br><img src="../images/00-verify-pod.png" "Location SOAP2REST" width="900" /><br><br>

### Step 14. Click the route link, above the location-soap2rest pod, and append `/location/contact/2` to the URI.  As a result, you should get a contact back.


*Congratulations!* You have created a SOAP to REST transformation API.

## Summary

You have now successfully created a contract-first API, using a SOAP WSDL contract, together with generated Camel RESTdsl.
