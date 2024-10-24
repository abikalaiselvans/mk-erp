<%@ page import="java.sql.*,java.io.*,java.util.*"%>

<%!
	Connection con ;
	PreparedStatement pstm;
	ResultSet rst;
	String userid;
	String sql_Select_Query ="SELECT int_CATEGORYID FROM m_category where chr_CATEGORY=?";
		
	int id;
	String name;

	public void releaseJDBCResource() 	
	{
		try
		{
			rst.close();
			pstm.close();
			 

		}catch(NullPointerException ex)
		{
			//System.out.println(ex);
		}catch(SQLException ex)
		{
			//System.out.println(ex);
		}
	}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
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
<form  AUTOCOMPLETE = "off"   method="post" action="">
<body >
<BR>
<BR>

<table align="center" border="1">
	<tr>

		<%
	name=request.getParameter("categoryname");
	
	try
	{
		String profilename="c:/Tomcat 5.0/bin/JDBC.properties";
		InputStream input  = new FileInputStream(profilename);	
		Properties jdbc = new Properties();
		jdbc.load(input);
		String driver = jdbc.getProperty("Driver");
		String url =jdbc.getProperty("Url");
		String struser =jdbc.getProperty("User");
		String strpass =jdbc.getProperty("Passw");
		//Database Connectivity
		Class.forName(driver);
		con = DriverManager.getConnection(url,struser,strpass);
		pstm = con.prepareStatement(sql_Select_Query);
		rst = pstm.executeQuery();
		pstm.setString(2,name);
		while(rst.next())
		{
			id=rst.getInt("int_CATEGORYID");
			out.println(id);
				
		}
		releaseJDBCResource();
		}catch(Exception ex)
	{
		//System.out.println(ex);
	}
	%>




		</span>
		</td>
	</tr>

	<tr>
		<td height="-2">Item Name</td>
		<td height="-2"><input type="text" name="itname"></td>
	</tr>
	<tr>
		<td height="-2">Unit Price</td>
		<td height="-2"><input type="text" name="itprice"></td>
	</tr>
</table>

<p align="center"><input type="submit" name="Submit" value="Submit"   accesskey="s"   >
</p>
</td>
</tr>
</table>

<br>
<br>
<br>

<td width="214" valign="top" background="../if">
</div>
</td>
</body>
</form>
</html>
