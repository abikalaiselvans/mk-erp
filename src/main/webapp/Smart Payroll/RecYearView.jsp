<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ include file="index.jsp"%>
<%!

	Connection con ;
	Statement st ;
	ResultSet rs;
	String sql;
	String driver;
	String url;
	String year;
	int i;	
%>
<%
	year=request.getParameter("year");
	
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
			
		sql="select CHR_EMPCODE,CHR_STAFFFNAME,CHR_DESIGNAME,INT_YEAR from m_staff,t_all,m_desig where m_staff.CHR_EMPID=t_all.CHR_EMPCODE and m_staff.INT_DESIGID=m_desig.INT_DESIGID and t_all.INT_YEAR='"+year+"'";
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
		<td width="111" height="92">&nbsp;</td>
		<td width="768">&nbsp;</td>
		<td width="99">&nbsp;</td>
	</tr>
	<tr>
		<td height="80"></td>
		<td valign="top">
		<table width="763" border="1" cellpadding="0" cellspacing="1">
			<!--DWLayoutTable-->
			<tr>
				<td height="27" colspan="4" align="center" valign="middle"><strong>Recovery
				Details - YearWise</strong></td>
			</tr>
			<tr>
				<td width="111" height="24">
				<div align="center"><strong>Emp Id</strong></div>
				</td>
				<td width="177">
				<div align="center"><strong>Name</strong></div>
				</td>
				<td width="171">
				<div align="center"><strong>Designation</strong></div>
				</td>
				<td width="121">
				<div align="center"><strong>Year</strong></div>
				</td>
			</tr>
			<%
  while(rs.next())
		{
%>
			<tr>
				<td height="21" align="center" valign="middle">
				<% out.println(rs.getString("CHR_EMPID")); %>
				</td>
				<td align="center" valign="middle"><span
					class="style54 style52"> <% out.println(rs.getString("CHR_DESIGNAME")); %>
				</span></td>
				<td align="center" valign="middle"><span
					class="style54 style52"> <% out.println(rs.getInt("INT_YEAR")); %>
				</span></td>
				<% 
		 
		StringTokenizer dts=new StringTokenizer(rs.getString("DT_WEDDATE"));
		StringTokenizer dt=new StringTokenizer(dts.nextToken(),"-");
		String y=dt.nextToken();
		String m=dt.nextToken();
		String d=dt.nextToken();
	 %>
				<td align="center" valign="middle"><span
					class="style54 style52"> <% out.println(d+"-"+m+"-"+y); %> </span></td>
				<%
		 
		 dts=new StringTokenizer(rs.getString("DT_DOB"));
		 dt=new StringTokenizer(dts.nextToken(),"-");
		 y=dt.nextToken();
		 m=dt.nextToken();
		 d=dt.nextToken();
	 %>
				<%
		 
	%>
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
		<td></td>
	</tr>
	<tr>
		<td height="10"></td>
		<td></td>
		<td></td>
	</tr>
</table>
<br>
<br>
<br>
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
