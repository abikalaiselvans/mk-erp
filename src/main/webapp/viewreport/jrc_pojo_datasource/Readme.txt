________________________________________________________________ 

Business Objects Support - jrc_pojo_datasource

Web Site: 
http://www.businessobjects.com

Support Website:
http://support.businessobjects.com

________________________________________________________________ 

PRODUCT

This Java Server Pages (JSP) sample application is for use only with the Crystal Reports (CR) Java Reporting Component (JRC). 

________________________________________________________________ 

DESCRIPTION

This sample demonstrates how to push a runtime Plain Old Java Object (POJO) into a report 
as a Java Resultset.  
NOTE: The POJO API provided (pojoSample.jar) is a sample for converting plain old java objects into a Java Resultsets.
The sample POJO API for generating a Java Resultset from a POJO is provided "as is" and is not supported
by Business Objects technical support. 

________________________________________________________________ 

FILES
		
jrc_pojo_datasource.jsp 
jrc_pojo_datasource.rpt
CrystalReportViewer.jsp

________________________________________________________________ 

INSTALLATION

1. Setup an application context on your application server to host a web application. For assistance with setting up and deploying a web application using the Java Reporting Component, refer to this whitepaper:

http://support.businessobjects.com/communityCS/TechnicalPapers/cr_xi_r2_jrc_deployment.pdf

2. Extract the contents of this folder into your web application's context root.

3. In a browser window, launch the file jrc_pojo_datasource.jsp as follows: 

http://<computer name>:<port number>/<web app>/jrc_pojo_datasource.jsp 

NOTE: pojoSample.jar will need to be included in the WAR's /WEB-INF/lib directory in order to use the POJO Sample API (i.e., POJOResultsetFactory).

________________________________________________________________

Last updated December 2005
________________________________________________________________ 