<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="com.crystaldecisions.reports.sdk.*"%>
<%@ page import="com.crystaldecisions.sdk.occa.report.lib.*"%>
<%@ page import="java.sql.*"%>

<%
final String REPORT_NAME = "/viewreport/sql/Report2.rpt";
%>

<%
try 
{
	
	ReportClientDocument reportClientDoc = new ReportClientDocument();
	reportClientDoc.open(REPORT_NAME, 0);

	String query = "SELECT  `com_m_staff`.`CHR_EMPID`, `com_m_staff`.`CHR_STAFFNAME` from  `smartcampus`.`com_m_staff` where `com_m_staff`.`INT_OFFICEID`=3 ";
	
	ResultSet resultSet = getResultSetFromQuery(query, ResultSet.TYPE_SCROLL_INSENSITIVE); 
	String tableAlias = reportClientDoc.getDatabaseController().getDatabase().getTables().getTable(0).getAlias();
		
	reportClientDoc.getDatabaseController().setDataSource(resultSet, tableAlias , "resultsetTable");
	
	session.setAttribute("reportSource", reportClientDoc.getReportSource());
		
	response.sendRedirect("CrystalReportViewer.jsp");
		
}
catch(ReportSDKException ex) 
{	
	out.println(ex);
}
catch(Exception ex) 
{
	out.println(ex);			
}
%>

<%!
	private static ResultSet getResultSetFromQuery(String query, int scrollType) throws SQLException, ClassNotFoundException {

		Class.forName("com.mysql.jdbc.Driver");
		
		//System.out.println("1");
		final String DBUSERNAME = "root";
		final String DBPASSWORD = "";
		final String CONNECTION_URL = "jdbc:mysql://localhost:3306/smartcampus";
		
		java.sql.Connection connection = DriverManager.getConnection(CONNECTION_URL, DBUSERNAME, DBPASSWORD); 
		//System.out.println("2");
		Statement statement = connection.createStatement(scrollType, ResultSet.CONCUR_READ_ONLY);
		//System.out.println("Executed...");
		//Execute query and return result sets.
		return statement.executeQuery(query);

	}
%>
