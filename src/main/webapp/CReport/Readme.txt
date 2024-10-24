________________________________________________________________ 

Business Objects Support - jrc_export_report

Web Site: 
http://www.businessobjects.com

Support Website:
http://support.businessobjects.com

________________________________________________________________ 

PRODUCT

This Java Server Pages (JSP) sample application is for use only with the Crystal Reports (CR) Java Reporting Component (JRC). 

________________________________________________________________ 

DESCRIPTION

This sample demonstrates how to export a report to a stream (server-side exporting).  The sample
then demonstrates how to use the Java I/O libraries to write the exported result to the local 
file system or the browser.
NOTE: If the report is based on a secured database the database login credentials
will need to be set before calling the export method below.  Also, if the report
has parameters, then values will need to be set for the report before export method can
be called or an error will be thrown.  See the ViewReportParameters or ViewReportLogon samples 
for samples on how to set parameters and login credentials through the JRC SDK.   

________________________________________________________________ 

FILES
		
jrc_export_report.jsp 
jrc_export_report.rpt

________________________________________________________________ 

INSTALLATION

1. Setup an application context on your application server to host a web application. For assistance with setting up and deploying a web application using the Java Reporting Component, refer to this whitepaper:

http://support.businessobjects.com/communityCS/TechnicalPapers/cr_xi_r2_jrc_deployment.pdf

2. Extract the contents of this folder into your web application's context root.

3. In a browser window, launch the file jrc_export_report.jsp as follows: 

http://<computer name>:<port number>/<web app>/jrc_export_report.jsp 

________________________________________________________________

Last updated December 2005
________________________________________________________________ 