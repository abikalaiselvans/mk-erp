<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ include file="index.jsp"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!
Connection con ;
Statement st ;
ResultSet rs;
    String dept,month,year,str,sql;
	int i;	
%>


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
		<table width="818" border="1" cellpadding="0" cellspacing="1"
			 >
			<!--DWLayoutTable-->
			<tr>
				<td height="39" colspan="6" align="center" valign="middle"
					  class="tablehead">Pay Bill For the Month of</td>
				<td  class="tablehead"><%=month%></td>
				<td colspan="5" valign="middle"  class="tablehead"><%=year%></td>
			</tr>
			<tr>
				<td width="53" height="24" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Emp Id</td>
				<td width="53" valign="middle" bgcolor="6E8FBC" class="tablehead">
				Name</td>
				<td width="92" valign="middle" bgcolor="6E8FBC" class="tablehead">
				Department</td>
				<td width="92" valign="middle" bgcolor="6E8FBC" class="tablehead">
				Designation</td>
				<td width="61" valign="middle" bgcolor="6E8FBC" class="tablehead">
				Basic</td>
				<td width="51" valign="middle" bgcolor="6E8FBC" class="tablehead">
				DA</td>
				<td width="57" valign="middle" bgcolor="6E8FBC" class="tablehead">
				HRA</td>
				<td width="75" valign="middle" bgcolor="6E8FBC" class="tablehead">
				Allowance</td>
				<td width="60" valign="middle" bgcolor="6E8FBC" class="tablehead">
				Gross Pay</td>
				<td width="77" valign="middle" bgcolor="6E8FBC" class="tablehead">
				Recovery</td>
				<td width="52" valign="middle" bgcolor="6E8FBC" class="tablehead">
				EPF</td>
				<td width="56" valign="middle" bgcolor="6E8FBC" class="tablehead">
				Net</td>
			</tr>
			<%
    
	dept=request.getParameter("department");
	year=request.getParameter("year");
	month=request.getParameter("month");
	try{
	sql="SELECT A.CHR_EMPID,A.CHR_STAFFNAME,C.CHR_DEPARTNAME,D.CHR_DESIGNAME,B.A001,B.A002,B.A003,B.A003,B.A004,B.A005,B.A006,B.A007";
	 sql=sql+"FROM  com_m_staff  A,PAY_T_ALLOWANCE B,  com_m_depart   C, com_m_desig  D WHERE A.CHR_EMPID=B.CHR_EMPID ";
		con=conbean.getConnection();
		st=con.createStatement();
		rs=st.executeQuery(sql);
	    
  while(rs.next())
		{
%>
			<tr>
				<td height="19" align="center" valign="middle"><%=rs.getString("CHR_EMPID")%>
				</td>
				<td align="center" valign="middle"><span
					class="style54 style52"> <%=rs.getString("CHR_STAFFNAME")%>
				</span></td>
				<td align="center" valign="middle"><span
					class="style54 style52"> <% out.println(rs.getString("CHR_DEPARTNAME")); %>
				</span></td>
				<td align="center" valign="middle"><span
					class="style54 style52"> <% out.println(rs.getString("CHR_DESIGNAME")); %>
				</span></td>
				<td align="center" valign="top""><span class="style54 style52">
				<% out.println(rs.getString("A001")); %> </span></td>

				<td align="center" valign="middle"><span
					class="style54 style52"> </span></td>

				<td align="center" valign="middle"><span
					class="style54 style52"> </span></td>

				<td align="center" valign="middle"><span
					class="style54 style52"> <% out.println(rs.getString("CHR_BG")); %>
				</span></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>

		</table>
		</td>
		<td>&nbsp;</td>
	</tr>
</table>
<%}
	}
	catch(Exception e){//System.out.println(e);
	}
 
 %>
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
			<td height="46"></td>
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
<br>
<br>
<br>
</body>
</html>
