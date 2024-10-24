<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ include file="index.jsp"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!

	Connection con ;
	Statement st ;
	ResultSet rs;
	String sql;
	String driver;
	String url;
	
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
<form  AUTOCOMPLETE = "off"   method="post" action="MessDeptView.jsp">
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<br>
<br>
<br>
<br>
<br>
<table width="1002">
	<!--DWLayoutTable-->
	<tr>
		<td width="244" height="61">&nbsp;
		<td colspan="3" valign="top">
		<table width="456" border="1" align="center"  >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle">
				<td height="23" colspan="2"  class="tablehead">Mess
				Details - Department Wise</td>
			</tr>
			<tr>
				<td width="187" height="28" class="tabledata">Select the
				Departemt</td>
				<td width="253" valign="top"><select name="Department">
					<%
    con=conbean.getConnection();
    st=con.createStatement(); 
    str="SELECT * FROM   com_m_depart  ";
	rs=st.executeQuery(str);
           
	while(rs.next())
	{
	%>
					<option value="<%=rs.getString("int_DepartID")%>">
					<% out.println(rs.getString("chr_DepartName")); %>
					</option>
					<%
	 }
	%>
				</select></td>
			</tr>
		</table>
		<td width="279">&nbsp;
	</tr>
	<tr>
		<td height="46">&nbsp;
		<td width="185">&nbsp;
		<td width="58">&nbsp;
		<td width="202">&nbsp;
		<td>&nbsp;
	</tr>
	<tr>
		<td height="26">&nbsp;
		<td>&nbsp;
		<td valign="top"><input type="submit" name="Submit"
			value="Submit">
		<td>&nbsp;
		<td>&nbsp;
	</tr>
	<tr>
		<td height="26">&nbsp;
		<td>&nbsp;
		<td>&nbsp;
		<td>&nbsp;
		<td>&nbsp;
	</tr>
</table>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         
<br>
<br>
<br>
                                                                      
<%@ include file="../footer.jsp"%>
</body>
</form>
</html>
