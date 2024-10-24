
<%
/* 
 * Applies to versions:	XI Release 2
 * Date Created: December 2005
 * Description: This sample demonstrates how to push a runtime Java Resultset to a 
 * 				report as a datasource.  
 * Author: CW.
 */
%>

<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>

<%//Crystal Java Reporting Component (JRC) imports.%>
<%@ page import="com.crystaldecisions.reports.sdk.*"%>
<%@ page import="com.crystaldecisions.sdk.occa.report.lib.*"%>

<%//Java imports. %>
<%@ page import="java.sql.*"%>

<%
//Report can be opened from the relative location specified in the CRConfig.xml, or the report location
//tag can be removed to open the reports as Java resources or using an absolute path (absolute path not recommended
//for Web applications).
final String REPORT_NAME = "jrc_resultset_datasource.rpt";
%>

<%
try {
	
	//Open report.
	ReportClientDocument reportClientDoc = new ReportClientDocument();
	reportClientDoc.open(REPORT_NAME, 0);

	//Create SQL query.     
	String query = "SELECT \"RecordSetSchema\".\"Last Name\", \"RecordSetSchema\".\"Birth Date\", \"RecordSetSchema\".\"Salary\", \"RecordSetSchema\".\"Employee ID\", \"RecordSetSchema\".\"Photo\", \"RecordSetSchema\".\"Notes\" " +
				   "FROM   \"Xtreme1\".\"dbo\".\"Employee\" \"RecordSetSchema\"";
	
	//Query database and obtain the Resultset that will be pushed into the report.   
	ResultSet resultSet = getResultSetFromQuery(query, ResultSet.TYPE_SCROLL_INSENSITIVE); 
			
	//Look up existing table in the report to set the datasource for and obtain its alias.  This table must 
	//have the same schema as the Resultset that is being pushed in at runtime.  The table could be created 
	//from a Field Definition File, a Command Object, or regular database table.  As long the Resultset
	//schema has the same field names and types, then the Resultset can be used as the datasource for the table.  
	String tableAlias = reportClientDoc.getDatabaseController().getDatabase().getTables().getTable(0).getAlias();
			
	//Push the Java ResultSet into the report.  This will then be the datasource of the report.
	reportClientDoc.getDatabaseController().setDataSource(resultSet, tableAlias , "resultsetTable");
	
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

<%!
	/**
	 * Simple utility function for obtaining result sets that will be pushed into the report.  
	 * This is just standard querying of a Java result set and does NOT involve any 
	 * Crystal JRC SDK functions.  
	 */
	private static ResultSet getResultSetFromQuery(String query, int scrollType) throws SQLException, ClassNotFoundException {

		//Load JDBC driver for the database that will be queried.  
		Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
		
		//Construct JDBC connection.
		final String DBUSERNAME = "vantech";
		final String DBPASSWORD = "vantech";
		final String CONNECTION_URL = "jdbc:microsoft:sqlserver://vancsdb01.crystald.net:1433";
		
		java.sql.Connection connection = DriverManager.getConnection(CONNECTION_URL, DBUSERNAME, DBPASSWORD); 
		Statement statement = connection.createStatement(scrollType, ResultSet.CONCUR_READ_ONLY);
		
		//Execute query and return result sets.
		return statement.executeQuery(query);

	}
%>
