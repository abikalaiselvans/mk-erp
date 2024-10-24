<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ include file="index.jsp"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!

	Connection con ;
	Statement st ;
	ResultSet rs;
	String sql;
	String driver;
	String url,month;
	int i;	
%>
<%
	month=request.getParameter("month");
	
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
		<td width="151" height="92">&nbsp;</td>
		<td width="685">&nbsp;</td>
		<td width="142">&nbsp;</td>
	</tr>
	<tr>
		<td height="92">&nbsp;</td>
		<td valign="top">
		<table width="683" border="1" cellpadding="0" cellspacing="1"
			 >
			<!--DWLayoutTable-->
			<tr>
				<td height="23" colspan="6" align="center" valign="middle"
					  class="tablehead">Mess Details - MonthWise</td>
			</tr>
			<tr>
				<td width="116" height="24" bgcolor="6E8FBC" class="tablehead"
					align="center">Emp Id</td>
				<td width="239" bgcolor="6E8FBC" class="tablehead" align="center">Name</td>
				<td width="175" bgcolor="6E8FBC" class="tablehead" align="center">Month</td>
				<td width="138" bgcolor="6E8FBC" class="tablehead" align="center">Cheque
				No</td>
				<td width="138" bgcolor="6E8FBC" class="tablehead" align="center">Amount</td>
				<td width="138" bgcolor="6E8FBC" class="tablehead" align="center">Total</td>
			</tr>
			<%
	try
	{
		con=conbean.getConnection();
        st=con.createStatement(); 
      	str="SELECT A.CHR_EMPID,A.CHR_STAFFNAME,C.CHR_MONTH,C.CHR_CHEQUENO,C.INT_CASHAMT FROM  com_m_staff  A,PAY_M_MESSBILL C WHERE A.CHR_EMPID=C.CHR_EMPID AND C.CHR_MONTH='"+month+"'";
		rs=st.executeQuery(str); 
		while(rs.next())
		{
 %>
			<tr>
				<td height="21" align="center" valign="middle">
				<% out.println(rs.getString("CHR_EMPID")); %>
				</td>
				<td align="center" valign="middle"><span
					class="style54 style52"> <% out.println(rs.getString("CHR_STAFFNAME")); %>
				</span></td>
				<td align="center" valign="middle"><span
					class="style54 style52"> <% out.println(rs.getString("CHR_MONTH")); %>
				</span></td>
				<td align="center" valign="middle"><span
					class="style54 style52"> <% out.println(rs.getString("CHR_CHEQUENO")); %>
				</span></td>
				<td align="center" valign="middle"><span
					class="style54 style52"> <% out.println(rs.getInt("INT_CASHAMT")); %>
				</span></td>
				<td align="center" valign="middle"><span
					class="style54 style52"> <% out.println(rs.getInt("INT_CASHAMT")); %>
				</span></td>

			</tr>
			<%
		}
	    }
         catch(Exception e)
         {
        	 //System.out.println(e);
        	 
         }
		//rs.close();
	     
	    %>
		</table>
		</td>
		<td>&nbsp;</td>
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
