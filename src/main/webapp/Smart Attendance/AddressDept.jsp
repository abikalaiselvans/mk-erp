
<%-- <%@ include file="home.jsp"%>
 --%>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
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
		url =jdbc.getProperty("Url");
		String struser =jdbc.getProperty("User");
		String strpass =jdbc.getProperty("Passw");
		Class.forName(driver);
		con = DriverManager.getConnection(url,struser,strpass);
	}
	catch(Exception e)
	{
		//System.out.println(e);
	}
		
	try
	{
	   	st=con.createStatement();
		rs = st.executeQuery("select  * from m_depart");
	}
	
	catch(Exception npe)
	{
		//System.out.println(npe);
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
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
<form  AUTOCOMPLETE = "off"   method="post" action="AddressDeptView.jsp">
<body  onpaste='return false;'>
<%@ include file="session.jsp"%>
<p class="style8">&nbsp;</p>
<p class="style8"><u> Address Departmentwise</u>

<td width="175" height="92" valign="top">
<table>
	<tr>
		<td width="49" height="35">
		<div align="center"><img src="../Images/dot.gif" width="10"
			height="10"></div>
		</td>
		<td width="144"><span class="style8"><a
			href="AddressDept.jsp">Departmentwise</a></span></td>
	</tr>
	<tr>
		<td height="24">
		<div align="center"><img src="../Images/dot.gif" width="10"
			height="10"></div>
		</td>
		<td><span class="style8"><a href="AddressDesign.jsp">Designationwise</a></span></td>
	</tr>
</table>
<a href="AddressDesign.htm"><br>
</a></td>
<td width="532">
<table align="center" border="1">
	<tr>
		<td width="51%" height="26" class="style8">Select the Department</td>
		<td width="49%"><select name="Department">
			<%
	while(rs.next())
	{
	%>
			<option value="<%= rs.getString("int_DepartID") %>">
			<% out.println(rs.getString("chr_DepartName")); %>
			</option>
			<%
	}
	%>
		</select></td>
	</tr>
</table>
<tr>

	<td>
	<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="submit" name="Submit" value="Submit"   accesskey="s"   ></p>
	</td>
</tr>

<br>
<br>
<table>
	<tr>
		<td width="518"><a href="SmartAttendanceImg.htm"><img
			src="../Image/General/Home.gif" width="93" height="70" border="0"></a></td>
		<td width="240"><a href="SmartAttendanceImg.htm"><img
			src="../Image/General/Back.gif" width="92" height="69" border="0"></a></td>
	</tr>
</table>
<br>
<br>
</body>

</form>

</html>
