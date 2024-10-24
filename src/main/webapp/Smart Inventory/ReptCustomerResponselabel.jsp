<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="com.crystaldecisions.reports.sdk.*"%>
<%@ page import="com.crystaldecisions.sdk.occa.report.lib.*"%>
<%@ page import="com.crystaldecisions.report.web.viewer.*"%>
<%@ page import="java.sql.*"%>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<body >

<%@ include file="indexinv.jsp"%>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
	<%
	final String REPORT_NAME = "/Smart Inventory/reports/customerinfolabel.rpt";
	try 
	{
		String Live = request.getParameter("Live");
		String id = request.getParameter("id");
		String sql="";
		sql="SELECT upper(a.CHR_CUSTOMERNAME),upper(a.CHR_STREET),upper(a.CHR_CITY),upper(a.CHR_STATE),";
		sql=sql+" (SELECT concat('Pin  : ',a.CHR_POSTAL) ),";
		sql=sql+" (SELECT concat('Phone : ',a.CHR_PHONE) ),";
		sql=sql+" (SELECT concat('Mobile : ',a.CHR_MOBILE) ),";
		sql=sql+" (SELECT concat('Fax : ',a.CHR_FAX) ),";
		sql=sql+" (SELECT concat('Email : ',a.CHR_EMAIL) ),";
		sql=sql+" (SELECT concat('website : ',a.CHR_WEBSITE) )";
		sql=sql+" from inv_m_customerinfo a";
		sql=sql+" WHERE a.INT_CUSTOMERGROUPID in("+id+")";
		if(!"Y".equals(Live))
				sql= sql+" AND a.INT_ACTIVE=1";
		ReportClientDocument reportClientDoc = new ReportClientDocument();
		reportClientDoc.open(REPORT_NAME, 0);
		ResultSet resultSet = getResultSetFromQuery(sql, ResultSet.TYPE_SCROLL_INSENSITIVE); 
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
		final String DBUSERNAME = "root";
		final String DBPASSWORD = "mmiadmin";
		final String CONNECTION_URL = "jdbc:mysql://localhost:3306/smartcampus";
		java.sql.Connection connection = DriverManager.getConnection(CONNECTION_URL, DBUSERNAME, DBPASSWORD); 
		Statement statement = connection.createStatement(scrollType, ResultSet.CONCUR_READ_ONLY);
		return statement.executeQuery(query);

	}
%>	</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
<p>&nbsp;</p>
<%@ include file="../footer.jsp"%>
</body>
</html>
