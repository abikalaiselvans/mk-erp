<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>

<%@ page import="com.crystaldecisions.reports.sdk.*"%>
<%@ page import="com.crystaldecisions.sdk.occa.report.lib.*"%>
<%@ page import="com.crystaldecisions.report.web.viewer.*"%>
<%@ page
	import="com.crystaldecisions.report.web.viewer.CrystalReportViewer"%>
<%@ page import="com.crystaldecisions.reports.sdk.ReportClientDocument"%>

<%@ page import="java.sql.*"%>
<%
final String REPORT_NAME = "Rep.rpt";
%>

<%
try 
{
	
	ResultSet resultSet = getResultSetFromQuery("SELECT CHR_EMPID,CHR_STAFFNAME,CHR_GENDER FROM com_m_staff", ResultSet.TYPE_SCROLL_INSENSITIVE); 
	Object reportSource = session.getAttribute("reportSource");
    if (reportSource == null)
    {
        String report = "/viewreport/datasource/Rep.rpt";
        ReportClientDocument reportClientDoc = new ReportClientDocument();
        reportClientDoc.open(report, 0);
        reportSource = reportClientDoc.getReportSource();
        session.setAttribute("reportSource", reportSource);
    }
    CrystalReportViewer viewer = new CrystalReportViewer();
    viewer.setReportSource(reportSource);
    viewer.setOwnPage(true);
    viewer.processHttpRequest(request, response, getServletConfig().getServletContext(), null);

	 
}
catch(ReportSDKException ex) {	
	out.println(ex);
}
catch(Exception ex) {
	out.println(ex);			
}
%>

<%!
	private static ResultSet getResultSetFromQuery(String query, int scrollType) throws SQLException, ClassNotFoundException 
	{
		Class.forName("com.mysql.jdbc.Driver");
		final String DBUSERNAME = "root";
		final String DBPASSWORD = "mythra";
		final String CONNECTION_URL = "jdbc:mysql://localhost:3306/smartcampus";
		java.sql.Connection connection = DriverManager.getConnection(CONNECTION_URL, DBUSERNAME, DBPASSWORD); 
		Statement statement = connection.createStatement(scrollType, ResultSet.CONCUR_READ_ONLY);
		//System.out.println("Executed Query");
		return statement.executeQuery(query);
	}
%>
