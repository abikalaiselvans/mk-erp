<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ include file="index.jsp"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!

	Connection con;
	Statement st ;
	ResultSet rs;
	String sql;
	String driver;
	String url;
	String desid;
	int i;	
%>
<%
	desid=request.getParameter("Designation");
	
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
.style52 {font-size: 10px}
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
		<td width="864" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
		<td width="45">&nbsp;</td>
	</tr>
	<tr>
		<td height="108">&nbsp;</td>
		<td valign="top">
		<table width="869" border="1" cellpadding="0" cellspacing="1">
			<!--DWLayoutTable-->
			<tr>
				<td height="39" colspan="10" align="center" valign="middle"
					  class="tablehead">Offical Information View </strong></td>
			</tr>
			<tr>
				<td width="60" height="31" align="center" bgcolor="6E8FBC"
					class="tablehead">Emp Id</td>
				<td width="65" align="center" bgcolor="6E8FBC" class="tablehead">Name</td>
				<td width="78" align="center" bgcolor="6E8FBC" class="tablehead">
				Office</td>
				<td width="96" align="center" bgcolor="6E8FBC" class="tablehead">
				Department</td>
				<td width="132" align="center" bgcolor="6E8FBC" class="tablehead">Designation</td>
				<td width="76" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Type</td>
				<td width="93" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Date of Join</td>
				<td width="108" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Basic Salary</td>
				<td width="79" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Gratuity</td>
				<td width="49" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">
				<div align="center"><strong>P F</strong></div>
				</td>
			</tr>
			<%
	
	try
	{
		con=conbean.getConnection();
	   	st=con.createStatement();

sql="select staff.CHR_EMPID,staff.CHR_STAFFNAME, office.CHR_Officename, depart.CHR_DEPARTNAME,desig.CHR_DESIGNAME,staff.CHR_TYPE,staff.DT_DOJCOLLEGE,staff.INT_SALARY,staff.INT_GRATUITY,staff.CHR_PFESI from  com_m_staff  staff, com_m_office  office, com_m_desig  desig,  com_m_depart   depart where staff.INT_DEPARTID=depart.INT_DEPARTID and staff.INT_OfficeID=office.INT_OfficeID and staff.INT_DESIGID=desig.INT_DESIGID and staff.INT_DESIGID="+desid;	
rs = st.executeQuery(sql);
  while(rs.next())
		{
%>
			<tr>
				<td height="26" align="center" valign="middle">
				<% out.println(rs.getString("CHR_EMPID")); %>
				</td>
				<td align="center" valign="middle"><span
					class="style54 style52"> <% out.println(rs.getString("CHR_STAFFNAME")); %>
				</span></td>
				<td align="center" valign="middle"><span
					class="style54 style52"> <% out.println(rs.getString("CHR_Officename")); %>
				</span></td>
				<td align="center" valign="middle">
				<% out.println(rs.getString("CHR_DEPARTNAME")); %>
				</td>
				<td align="center" valign="top""><span class="style54 style52">
				<% out.println(rs.getString("CHR_DESIGNAME")); %> </span></td>
				<td align="center" valign="top""><span class="style54 style52">
				<% out.println(rs.getString("CHR_TYPE")); %> </span></td>
				<% 
		try{
		StringTokenizer dts=new StringTokenizer(rs.getString("DT_DOJCOLLEGE"));
		StringTokenizer dt=new StringTokenizer(dts.nextToken(),"-");
		String y=dt.nextToken();
		String m=dt.nextToken();
		String d=dt.nextToken();
	 %>
				<td align="center" valign="middle"><span
					class="style54 style52"> <% out.println(d+"-"+m+"-"+y); %> </span></td>
				<%
		}
		catch(Exception e)
		{
		}
	%>
				<td align="center" valign="middle"><span
					class="style54 style52"> <% out.println(rs.getInt("INT_SALARY")); %>
				</span></td>
				<td align="center" valign="middle"><span
					class="style54 style52"> <% out.println(rs.getInt("INT_GRATUITY")); %>
				</span></td>
				<td align="center" valign="middle"><span
					class="style54 style52"> <% out.println(rs.getString("CHR_PFESI")); %>
				</span></td>
			</tr>
			<%
		}
		rs.close();
	 
}
	
	catch(Exception npe)
	{
		//System.out.println(npe);
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
			<TD width="93" valign="top">
			</div>
			</TD>
			<TD width="279">&nbsp;</TD>
			<TD width="93" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</TD>
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
