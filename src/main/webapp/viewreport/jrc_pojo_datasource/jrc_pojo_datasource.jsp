
<%
/* 
 * Applies to versions:	XI Release 2
 * Date Created: December 2005
 * Description: This sample demonstrates how to push a runtime Plain Old Java Object (POJO) into a report 
 * 				as a Java Resultset.  
 * 				NOTE: The POJO API provided (pojoSample.jar) is a sample for converting plain old java objects into a Java Resultsets.
 * 				The sample POJO API for generating a Java Resultset from a POJO is provided "as is" and is not supported
 * 				by Business Objects technical support. 
 * Author: CW.
 */
%>

<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>

<%//Crystal Java Reporting Component (JRC) imports.%>
<%@ page import="com.crystaldecisions.reports.sdk.*"%>
<%@ page import="com.crystaldecisions.sdk.occa.report.lib.*"%>

<%//POJO Sample API imports (see pojoSample.jar included with this sample).%>
<%-- <%@ page import="com.businessobjects.samples.pojo.*"%> --%>

<%@include file="SimplePOJO.jspf"%>

<%
//Report can be opened from the relative location specified in the CRConfig.xml, or the report location
//tag can be removed to open the reports as Java resources or using an absolute path (absolute path not recommended
//for Web applications).
final String REPORT_NAME = "jrc_pojo_datasource.rpt";
%>

<%

try {
	
	//Open report.
	ReportClientDocument reportClientDoc = new ReportClientDocument();
	reportClientDoc.open(REPORT_NAME, 0);

	//Build Report data set.  The SimplePOJO class is included from SimplePOJO.jspf.
	SimplePOJO [] data = {
		new SimplePOJO("johnny", "doe", 13, new java.sql.Date(62, 11, 02)),
		new SimplePOJO("james", "brown", 42, new java.sql.Date(99, 11, 31)),
		new SimplePOJO("ray", "black", 39, new java.sql.Date(99, 11, 31))
	};
			
	//Use the POJO sample API for generating a Java Resultset from the SimplePOJO class.
	//POJOResultSetFactory factory = new POJOResultSetFactory(SimplePOJO.class);
	//POJOResultSet resultSet = factory.createResultSet(data);
			
	//Look up existing table in the report to set the datasource for and obtain its alias.  This table must 
	//have the same schema as the Resultset that is being pushed in at runtime.  The table could be created 
	//from a Field Definition File, a Command Object, or regular database table.  As long the Resultset
	//schema has the same field names and types, then the Resultset can be used as the datasource for the table.  
	String tableAlias = reportClientDoc.getDatabaseController().getDatabase().getTables().getTable(0).getAlias();
						
	//Push the resultset into the report.  The POJO resultset will then be the runtime datasource of the report.
	//reportClientDoc.getDatabaseController().setDataSource(resultSet, tableAlias, tableAlias); 
		
	//Store the report source in session, will be used by the CrystalReportViewer.
	session.setAttribute("reportSource", reportClientDoc.getReportSource());
		
	//Launch CrystalReportViewer page that contains the report viewer.
	response.sendRedirect("CrystalReportViewer.jsp");
		
}
catch(ReportSDKException ex) {	
	out.println(ex);
}
catch(Exception ex) {
	out.println(ex);			
}
%>
