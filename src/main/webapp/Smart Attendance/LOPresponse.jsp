<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="com.crystaldecisions.reports.sdk.*"%>
<%@ page import="com.crystaldecisions.sdk.occa.report.lib.*"%>
<%@ page import="com.crystaldecisions.report.web.viewer.*"%>
<%@ page import="java.sql.*"%>



<html>
<head>
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


<title> :: ATTENDANCE ::</title>


</head>

<body  onpaste='return false;'>

<%
	try 
	{
		String company= request.getParameter("company");
		String branch= request.getParameter("branch");
		String Office = request.getParameter("Office");
		String dept= request.getParameter("dept");
		String month= request.getParameter("month");
		String repmon = DateUtil.getMonth(Integer.parseInt( month));
		String year= request.getParameter("year");
		String cpy="";
		String bid="";
		String off="";
		String dep="";
		String sql="";
	
		if(!"-1".equals(company))
			cpy= " AND `com_m_staff`.`INT_COMPANYID`="+company;
			
		if(!"-1".equals(branch))
			bid= " AND `com_m_staff`.`INT_BRANCHID'="+branch;	
			
		if(!"0".equals(Office))
			off=" AND `com_m_staff`.`INT_OFFICEID` ="+Office;
			
		if(!"0".equals(dept))
			dep=" AND `com_m_staff`.`INT_DEPARTID` ="+dept;
			
	
		 sql = " SELECT `att_t_register`.`CHR_EMPID`,`com_m_staff`.`CHR_STAFFNAME`,`att_t_register`.`DOU_ABSENT`, ";
		 sql = sql+" `att_t_register`.`INT_LATE`, `att_t_register`.`INT_PERMISSION`  ";
		 sql = sql+" FROM `smartcampus`.`att_t_register` ,`smartcampus`.`com_m_staff` ";
		 sql = sql+" WHERE `att_t_register`.`CHR_MONTH`='October'  ";
		 sql = sql+" AND  `att_t_register`.`INT_YEAR`=2007 ";
		 sql = sql+" AND  `att_t_register`.`DOU_ABSENT` >0  ";
		 sql = sql+" AND  `att_t_register`.`INT_LATE` >0 ";
		 sql = sql+" AND  `att_t_register`.`INT_PERMISSION` >0 ";

		 sql = sql+" AND  `att_t_register`.`CHR_EMPID` =`com_m_staff`.`CHR_EMPID` ";
		 sql = sql+cpy;
		 sql = sql+bid;
		 sql = sql+off;
		 sql = sql+dep;
		 sql = sql+" ORDER BY `com_m_staff`.`CHR_STAFFNAME` ";
		 
		 final String REPORT_NAME = "/Smart Attendance/reports/LOP.rpt";
		 
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
		final String DBPASSWORD = "mythra";
		final String CONNECTION_URL = "jdbc:mysql://localhost:3306/smartcampus";
		java.sql.Connection connection = DriverManager.getConnection(CONNECTION_URL, DBUSERNAME, DBPASSWORD); 
		Statement statement = connection.createStatement(scrollType, ResultSet.CONCUR_READ_ONLY);
		return statement.executeQuery(query);

	}
%>

</body>
</html>
