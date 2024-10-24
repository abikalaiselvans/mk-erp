 <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
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
	
		String staffid= request.getParameter("staffid");
		String sql = " SELECT `com_m_staff`.`CHR_EMPID`,`com_m_staff`.`CHR_STAFFNAME` ,DATE_FORMAT(`com_m_staff`.`DT_DOJCOLLEGE`,'%d-%b-%Y') ,  ";
		sql = sql+ " `com_m_bloodgroup`.`CHR_GROUPNAME` ,DATE_FORMAT(`com_m_staff`.`DT_DOB`,'%d-%b-%Y'),`com_m_staff`.`CHR_GENDER`,   ";
		sql = sql+ " `com_m_depart`.`CHR_DEPARTNAME`,  ";
		sql = sql+ " `com_m_desig`.`CHR_DESIGNAME`,  ";
		sql = sql+ " `com_m_company`.`CHR_COMPANYNAME`,  ";
		sql = sql+ " `com_m_branch`.`CHR_BRANCHNAME`,`com_m_branch`.`CHR_STREET`,`com_m_branch`.`CHR_CITY`,  ";
		sql = sql+ " `com_m_branch`.`CHR_POSTAL`,`com_m_branch`.`CHR_PHONE`,`com_m_branch`.`CHR_FAX` , `com_m_staff`.`IMG_IMAGE`  ";
		sql = sql+ " FROM `smartcampus`.`com_m_staff`   ,`smartcampus`.`com_m_depart`  ,`smartcampus`.`com_m_desig`  ,  ";
		sql = sql+ " `smartcampus`.`com_m_company`, `smartcampus`.`com_m_branch` ,`smartcampus`.`com_m_bloodgroup`  ";
		sql = sql+ " WHERE   `com_m_staff`.`INT_DEPARTID` = `com_m_depart`.`INT_DEPARTID`   "; 
		sql = sql+ " AND `com_m_staff`.`INT_DESIGID` =`com_m_desig`.`INT_DESIGID`     ";
		sql = sql+ " AND `com_m_staff`.`INT_COMPANYID` = `com_m_company`.`INT_COMPANYID`    "; 
		sql = sql+ " AND `com_m_staff`.`INT_COMPANYID` = `com_m_branch`.`INT_COMPANYID`  ";
		sql = sql+ " AND `com_m_staff`.`INT_BRANCHID` = `com_m_branch`.`INT_BRANCHID`     ";
		sql = sql+ " AND `com_m_staff`.`CHR_BG` = `com_m_bloodgroup`.`INT_BLOODGROUPID`   ";  
		sql = sql+ " AND `com_m_staff`.`CHR_EMPID` = '"+staffid+"'";
		final String REPORT_NAME = "/Smart Attendance/reports/idcard.rpt";
		 
		/* ReportClientDocument reportClientDoc = new ReportClientDocument();
		reportClientDoc.open(REPORT_NAME, 0);
		ResultSet resultSet = getResultSetFromQuery(sql, ResultSet.TYPE_SCROLL_INSENSITIVE); 
		String tableAlias = reportClientDoc.getDatabaseController().getDatabase().getTables().getTable(0).getAlias();
		reportClientDoc.getDatabaseController().setDataSource(resultSet, tableAlias , "resultsetTable");
		session.setAttribute("reportSource", reportClientDoc.getReportSource());
		response.sendRedirect("CrystalReportViewer.jsp");
		 */
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
		final String DBPASSWORD = "mkm#1994*"; 
		final String CONNECTION_URL = "jdbc:mysql://localhost:3306/smartcampus"; 
		java.sql.Connection connection = DriverManager.getConnection(CONNECTION_URL, DBUSERNAME, DBPASSWORD); 
		System.out.println(connection);
		Statement statement = connection.createStatement(scrollType, ResultSet.CONCUR_READ_ONLY);
		return statement.executeQuery(query);

	}
%>
</body>
</html>
