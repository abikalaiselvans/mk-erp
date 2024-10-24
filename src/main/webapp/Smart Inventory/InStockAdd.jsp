<%@ page import="java.sql.*,java.io.*,java.util.*"%>



<%!
	Connection con ;
	PreparedStatement pstm;
	ResultSet rst;
	String courseid;
	

	int cid;
	String sql_Select_Query ="SELECT int_CATEGORYID FROM m_category where chr_CATEGORY=?";


	

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






<form  AUTOCOMPLETE = "off"   method="post" action="InStackInsertion.jsp">


<body >
<table>
	<br>
	<td width="532">
	<table width="295" align="center">
		<tr>


			<%

	//Loading JDBC Connection Information
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
		courseid=request.getParameter("categoryname");
		//Database Connectivity
		Class.forName(driver);
		con = DriverManager.getConnection(url,struser,strpass);
		pstm = con.prepareStatement(sql_Select_Query);
		pstm.setString(1,courseid);
		rst = pstm.executeQuery();

		while(rst.next())
		{
					
		    	cid=rst.getInt("int_CATEGORYID");
		out.println(cid);
		
		}

		
		releaseJDBCResource();

	}catch(Exception ex)
	{
		//System.out.println(ex);
	}

%>
			</select>
			</span>
			</td>
		</tr>
		<tr>
			<td width="145" class="style8"></td>
			<td><input type="hidden" name="coid" value="<%= cid %>"></td>
		</tr>
		<tr>
			<td width="145" class="style8">Item Code</td>
			<td><input type="text" name="icode"></td>
		</tr>


		<td width="145" class="style8">Total Qty</td>
		<td><input type="text" name="tqty"></td>
		</tr>
		<td width="145" class="style8">UOH Qty</td>
		<td><input type="text" name="uoh"></td>
		</tr>

		<tr>
			<td width="145" class="style8">Issued Qty
			<td><input type="text" name="iqty">
		</tr>
		<tr>
			<td width="145" rowspan="2" class="style8">&nbsp;</td>
			<td>&nbsp;</td>

		</tr>
		<tr>
			<td><input type="submit" name="Submit" value="Submit"   accesskey="s"   ></td>
		</tr>


		<tr>
			<br>
			<br>
			<td><br>
			<br>
			<center></center>
		</tr>
		</td>

	</table>
	<table border=0>
		<tr>
			<td width="216" valign="top" background="../if">
			<div align="center"><a href="StudentBranch.htm"
				target="MainFrame"><img src="../Images/General/Home.gif"
				width="120" height="23" border="0"></a></div>
			</td>
			<td width="228" valign="top" background="../if">&nbsp;</td>
			<td width="214" valign="top" background="../if">
			<div align="right"></div>
			</td>
			<td width="214" valign="top" background="../if">
			<div align="right"><img src="../Images/General/Back.gif"
				width="123" height="22" border="0"></div>
			</td>
		</tr>
	</table>
	<br>
	<br>
	<br>
</body>
</form>
</html>
