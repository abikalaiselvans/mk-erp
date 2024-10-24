<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="com.crystaldecisions.reports.sdk.*"%>
<%@ page import="com.crystaldecisions.sdk.occa.report.lib.*"%>
<%@ page import="com.crystaldecisions.report.web.viewer.*"%>
<%@ page import="java.sql.*"%>
<html>
<head>

<title> :: ATTENDANCE ::</title>


<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%@ include file="index.jsp"%>
<br>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<%
	 
		String company = request.getParameter("company");
		String branch = request.getParameter("branch");
		String Office = request.getParameter("Office");
		String dept = request.getParameter("dept");
		String year = request.getParameter("year");
		String cpy="";
		String bid="";
		String off="";
		String dep="";
		if(!"-1".equals(company))
			cpy =" AND `com_m_staff`.`INT_COMPANYID` = "+company;
			
		if(!"-1".equals(branch))
			bid =" AND `com_m_staff`.`INT_OFFICEID`="+branch;
			
		if(!"-1".equals(Office))
			off =" AND `com_m_staff`.`INT_OFFICEID`="+Office;
		
		String sql = "SELECT CHR_LEAVENAME from att_m_leavetype ORDER BY INT_LEAVEID";
		String header = "S.No,Emp Id, Emp Name,";
		String data[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		int noofleave=data.length;
		for(int u=0;u<data.length;u++)
			header= header+data[u][0]+",";
		String repdata[]=header.split(",");
		
	sql=" SELECT `com_m_staff`.`CHR_EMPID`,`com_m_staff`.`CHR_STAFFNAME` , ";

	for(int y=1;y<=noofleave;y++)
	{
		sql=sql+" `att_m_leave`.`INT_NOD"+y+"`,";
		sql=sql+" `att_m_leave`.`INT_NOD"+y+"BALANCE`,";
		sql=sql+" (`att_m_leave`.`INT_NOD"+y+"`-`att_m_leave`.`INT_NOD"+y+"BALANCE`),";

	}
sql =sql.substring(0,sql.length()-1);	
sql=sql+" FROM  `smartcampus`.`com_m_staff`,  `smartcampus`.`com_m_depart`   ,  ";
sql=sql+" `smartcampus`.`com_m_branch`, `smartcampus`.`com_m_company` ,`smartcampus`.` com_m_office ` ";
sql=sql+" ,`smartcampus`.`att_m_leave` ";
sql=sql+" WHERE `com_m_staff`.`INT_DEPARTID`=`com_m_depart`.`INT_DEPARTID`  ";
sql=sql+" AND `com_m_staff`.`INT_OFFICEID`=`com_m_office`.`INT_OFFICEID` ";
sql=sql+" AND `com_m_staff`.`INT_COMPANYID` = `com_m_company`.`INT_COMPANYID` ";
sql=sql+" AND `com_m_staff`.`INT_BRANCHID` = `com_m_branch`.`INT_BRANCHID` ";
sql=sql+" AND `com_m_staff`.`CHR_EMPID` = `att_m_leave`.`CHR_EMPID` ";
sql=sql+" AND `com_m_staff`.`CHR_TYPE` !='Y'  ";
sql=sql+" AND `com_m_staff`.`CHR_HOLD`!='Y'   ";
sql = sql+cpy;
sql = sql+bid;
sql = sql+off;
sql=sql+" AND `att_m_leave`.`INT_YEAR`= "+year;
sql=sql+" AND year(`com_m_staff`.`DT_DOJCOLLEGE`) <= "+year;
sql=sql+" order BY  `com_m_staff`.`CHR_STAFFNAME` ";


	final String REPORT_NAME = "/Smart Attendance/reports/Leavemaster.rpt";
	
	try 
	{
	
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
%> <%!
	private static ResultSet getResultSetFromQuery(String query, int scrollType) throws SQLException, ClassNotFoundException {

		Class.forName("com.mysql.jdbc.Driver");
		final String DBUSERNAME = "root";//com.my.org.erp.common.CommonFunctions.dbusername;
		final String DBPASSWORD = "mkm#1994*";//com.my.org.erp.common.CommonFunctions.dbpassword;
		final String CONNECTION_URL = "jdbc:mysql://localhost:3306/smartcampus";//com.my.org.erp.common.CommonFunctions.dburl;
		java.sql.Connection connection = DriverManager.getConnection(CONNECTION_URL, DBUSERNAME, DBPASSWORD); 
		Statement statement = connection.createStatement(scrollType, ResultSet.CONCUR_READ_ONLY);
		return statement.executeQuery(query);

	}
%></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%>
</body>
</html>
