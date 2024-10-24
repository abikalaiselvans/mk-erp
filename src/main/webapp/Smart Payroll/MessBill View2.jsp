<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ include file="index.jsp"%>
<%!

	Connection con ;
	Statement st ;
	ResultSet rs;
	String sql;
	String driver;
	String url;
	String dept,month;
	int i,year;	
%>
<%
	dept=request.getParameter("dept");
	month=request.getParameter("month");
	
	
%>
<%
	try
	{
		String profilename="c:/Tomcat 5.0/bin/JDBC.properties";
		InputStream input  = new FileInputStream(profilename);
		Properties jdbc = new Properties();
		jdbc.load(input);
		driver = jdbc.getProperty("Driver");
		url =jdbc.getProperty("UrlCol");
		String struser =jdbc.getProperty("User");
		String strpass =jdbc.getProperty("Passw");
		Class.forName(driver);
		con = DriverManager.getConnection(url,struser,strpass);
	 
	   	st=con.createStatement();
			
		sql="select m_staff.CHR_EMPID,m_staff.CHR_STAFFNAME,m_advance.Chr_Month,m_advance.Int_Advamt,m_depart.CHR_DEPARTNAME from m_staff,m_advance,m_depart WHERE m_advance.Chr_Month='"+month+"' and m_depart.CHR_DEPARTNAME='"+dept+"'";
		
		rs = st.executeQuery(sql);
	 
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
.style51 {font-family: Verdana; font-size: 12px; color: #FFFFFF; }
.style52 {font-size: 10px}
.style53 {font-family: Verdana; font-size: 10px; color: #FFFFFF; }
.style54 {font-family: Verdana}
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

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="1000">
	<!--DWLayoutTable-->
	<tr>
		<td width="75" height="92">&nbsp;</td>
		<td width="799" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
		<td width="68">&nbsp;</td>
		<td width="32">&nbsp;</td>
	</tr>
	<tr>
		<td height="43">&nbsp;</td>
		<td colspan="2" valign="top">
		<table width="818" border="1" cellpadding="0" cellspacing="1">
			<!--DWLayoutTable-->
			<tr>
				<td height="39" colspan="8" align="center" valign="middle">DepartmentWise
				Advance View</td>
			</tr>
			<tr>
				<td width="71" height="24">
				<div align="center">Emp Id</div>
				</td>
				<td width="106">
				<div align="center">Name</div>
				</td>
				<td width="114" align="center" valign="middle">
				<div align="center">Department Name</div>
				</td>
				<td width="110">
				<div align="center">Month</div>
				</td>

				<td width="113" align="center" valign="middle">
				<div align="center">Advance Amount</div>
				</td>
			</tr>
			<%
  while(rs.next())
		{
%>
			<tr>
				<td height="19" align="center" valign="middle">
				<% out.println(rs.getString("CHR_EMPID")); %>
				</td>
				<td align="center" valign="middle"><span
					class="style54 style52"> <% out.println(rs.getString("CHR_STAFFNAME")); %>
				</span></td>
				<td align="center" valign="middle"><span
					class="style54 style52"> <% out.println(rs.getString("CHR_DEPARTNAME")); %>
				</span></td>
				<td align="center" valign="middle"><span
					class="style54 style52"> <% out.println(rs.getString("Chr_Month")); %>
				</span></td>

				<td align="center" valign="top""><span class="style54 style52">
				<% out.println(rs.getString("Int_Advamt")); %> </span></td>

			</tr>
			<%
		}
		rs.close();
	}
catch(Exception e)
{
	//System.out.println(e);
}
	 %>
		</table>
		</td>
		<td>&nbsp;</td>
	</tr>
</table>
<br>
<br>
<br>
<TABLE width="1000" border=0 align="left" cellPadding=0 cellSpacing=1>
	<!--DWLayoutTable-->
	<TBODY>
		<TR>
			<TD width="258" height="70">&nbsp;</TD>
			<TD width="93" valign="top"><a
				href="../Smart%20Attendance/Mainscreen.htm"><img
				src="file://///Mmi1/c/Tomcat%205.0/webapps/ROOT/SmartCollectrate/Image/Smart%20Attendance/Home.gif"
				width="93" height="70" border="0"></a>
			</div>
			</TD>
			<TD width="279">&nbsp;</TD>
			<TD width="93" valign="top"><a href="Payrollmain.jsp"><img
				src="../Smart%20Attendance/Back.gif" width="92" height="69"
				border="0"></a></TD>
			<TD width="271">&nbsp;</TD>
		</TR>
		<TR>
			<td height="0"></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</TR>
	</TBODY>
</TABLE>
<br>
<br>
<br>
<br>
<br>
<br>

</td>
<%@ include file="../footer.jsp"%>
</body>
</html>
