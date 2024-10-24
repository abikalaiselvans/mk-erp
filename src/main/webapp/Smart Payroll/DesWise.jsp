<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ include file="index.jsp"%>
<%!

	Connection con ;
	Statement st ;
	ResultSet rs;
	String sql;
	String driver;
	String url;
	
%>

<%
	try
	{
		InputStream input  = new FileInputStream("c:/Tomcat 5.0/bin/JDBC.properties");	
		Properties jdbc = new Properties();
		jdbc.load(input);
		driver = jdbc.getProperty("Driver");
		url =jdbc.getProperty("UrlCol");
		String struser =jdbc.getProperty("User");
		String strpass =jdbc.getProperty("Passw");
		Class.forName(driver);
		con = DriverManager.getConnection(url,struser,strpass);
	 
	   	st=con.createStatement();
		rs = st.executeQuery("select  * from m_desig");
	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title> :: PAYROLL ::</title>


 
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

<style type="text/css">
<!--
.style8 {
	font-family: Verdana;
	font-size: 12px;
}
a:visited {
	color: #663366;
}
a:hover {
	color: #FF0000;
}
a:active {
	color: #0000FF;
}
-->
</style>
</head>
<form  AUTOCOMPLETE = "off"   method="post" action="DesOfficalInfo.jsp">
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<br>
<br>
<br>
<br>
<br>
<br>
<table width="1002">
	<!--DWLayoutTable-->
	<tr>
		<td width="275" height="68">&nbsp;
		<td colspan="3" valign="top">
		<table align="center" border="1">
			<!--DWLayoutTable-->
			<tr align="center">
				<td height="26" colspan="4" valign="top"><strong>Offical
				Information - Designation Wise</strong></td>
			</tr>
			<tr>
				<td width="180" height="32" align="center" valign="middle"
					class="style8"><strong>Select the Designation</strong></td>
				<td width="231" colspan="2" valign="top"><select
					name="Designation">
					<%
	while(rs.next())
	{
	%>
					<option value="<%= rs.getString("INT_DESIGID") %>">
					<% out.println(rs.getString("CHR_DESIGNAME")); %>
					</option>
					<%
	}
 	%>
				</select></td>
			</tr>
		</table>
		<td width="276">&nbsp;
	<tr>
		<td height="56">
		<td width="169">&nbsp;
		<td width="55">&nbsp;
		<td width="193">&nbsp;
		<td>
	<tr>
		<td height="26">
		<td>&nbsp;
		<td valign="top"><input type="submit" name="Submit"
			value="Submit">
		<td>&nbsp;
		<td>
	<tr>
		<td height="26">
		<td>&nbsp;
		<td>&nbsp;
		<td>&nbsp;
		<td>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>

<%
}
	
	catch(Exception npe)
	{
		//System.out.println(npe);
	}%>
<a href="SmartAttendanceImg.htm"> <br>
<br>
<br>
<%@ include file="../footer.jsp"%>
</body>
</form>
</html>
