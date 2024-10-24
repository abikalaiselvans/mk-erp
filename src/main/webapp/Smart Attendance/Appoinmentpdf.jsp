<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="com.crystaldecisions.reports.sdk.*"%>
<%@ page import="com.crystaldecisions.sdk.occa.report.lib.*"%>
<%@ page import="com.crystaldecisions.report.web.viewer.*"%>
<%@ page import="java.sql.*"%>


<%@ page import="com.my.org.erp.common.CommonFunctions"%>
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

</head>
<script language="javascript" src="../JavaScript/comfunction.js">
</script>
<script language="javascript">

</script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<%
   		
	String sql = "";
	sql = "SELECT CHR_ACODE,CHR_ANAME FROM pay_m_allowance WHERE  CHR_FLAG='Y' ";
	String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	String allowancesql="";
	String allowancesql1="";
	for(int h=0;h<data.length;h++)
	{
		allowancesql=allowancesql+"`pay_t_allowance`.`"+data[h][0]+"`,";
		allowancesql1=allowancesql1+"+`pay_t_allowance`.`"+data[h][0]+"`";
	}
sql="";
sql = " SELECT DATE_FORMAT(now(),'%d-%m-%Y'),year(now()),(year(now())+1),`com_m_staff`.`CHR_EMPID`,`com_m_staff`.`CHR_STAFFNAME`,";
sql = sql + " `com_m_staff`.`CHR_PADD1`,`com_m_staff`.`CHR_PADD2`, `com_m_staff`.`CHR_PCITY`,`com_m_desig`.`CHR_DESIGNAME`,";
sql = sql + " `com_m_staff`.`DT_DOJCOLLEGE`,`com_m_office`.`CHR_OFFICENAME`, `com_m_depart`.`CHR_DEPARTNAME`,";
sql = sql +  allowancesql+" ("+allowancesql1.substring(1)+")";
sql = sql + " FROM `smartcampus`.`com_m_staff`,`smartcampus`.`com_m_company`,`smartcampus`.`com_m_desig`,";
sql = sql + " `smartcampus`.` com_m_office `,`smartcampus`.`com_m_depart`, ";
sql = sql + " `smartcampus`.`pay_t_allowance`";
sql = sql + " WHERE `com_m_staff`.`INT_COMPANYID` =`com_m_company`.`INT_COMPANYID` ";
sql = sql + " AND `com_m_staff`.`INT_DESIGID`=`com_m_desig`.`INT_DESIGID` ";
sql = sql + " AND `com_m_staff`.`INT_OFFICEID` = `com_m_office`.`INT_OFFICEID` ";
sql = sql + " AND `com_m_staff`.`INT_DEPARTID` = `com_m_depart`.`INT_DEPARTID` ";
sql = sql + " AND `com_m_staff`.`CHR_EMPID`=`pay_t_allowance`.`CHR_EMPID` ";
sql = sql + " AND `com_m_staff`.`CHR_EMPID`='ADMIN' ";
out.println(sql);	

	
	final String REPORT_NAME = "/Smart Attendance/reports/personalwithphoto.rpt";
	///Smart Attendance/reports/GrossPay.rpt
	//personalwithphoto.rpt
	///viewreport/sql/Report2.rpt
	try 
	{
	
		ReportClientDocument reportClientDoc = new ReportClientDocument();
		reportClientDoc.open(REPORT_NAME, 0);
		ResultSet resultSet = getResultSetFromQuery(sql, ResultSet.TYPE_SCROLL_INSENSITIVE); 
		String tableAlias = reportClientDoc.getDatabaseController().getDatabase().getTables().getTable(0).getAlias();
		reportClientDoc.getDatabaseController().setDataSource(resultSet, tableAlias , "resultsetTable");
		session.setAttribute("reportSource", reportClientDoc.getReportSource());
		//response.sendRedirect("CrystalReportViewer.jsp");
		
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
		final String DBUSERNAME = "";//CommonFunctions.dbusername;
		final String DBPASSWORD = "";//CommonFunctions.dbpassword;
		final String CONNECTION_URL = "jdbc:mysql://localhost:3306/smartcampus";
		java.sql.Connection connection = DriverManager.getConnection(CONNECTION_URL, DBUSERNAME, DBPASSWORD); 
		System.out.println(connection);
		Statement statement = connection.createStatement(scrollType, ResultSet.CONCUR_READ_ONLY);
		return statement.executeQuery(query);

	}
%>