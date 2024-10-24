<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
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
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
</head>
<%
       	String msg=""+request.getParameter("loginmsg");
       	if(msg.equals("null")) {
       		msg=""+request.getAttribute("loginmsg");
       		if(msg.equals("null")) msg="";
       	}
       		
%>
<body  onpaste="return false;" bgcolor="#b7e9ff"
	background="Image/Smart%20Attendance/loginbackground.jpg">
<form  AUTOCOMPLETE = "off"   method="post" action="User_Authentication.jsp">
<table width="1000" border=0>
	<!--DWLayoutTable-->
	<tr>
		<td height="2" colspan="5"><embed src="Image/General/college.swf"
			width="1000" height="110"></td>
	</tr>
	<tr>
		<td width="381" height="28">&nbsp;</td>
		<td width="41">&nbsp;</td>
		<td width="142">&nbsp;</td>
		<td width="97">&nbsp;</td>
		<td width="317">&nbsp;</td>
	</tr>
	<tr>
		<td height="98">&nbsp;</td>
		<td colspan="3" valign="top">
		<table width="287" border="1" cellspacing="2" cellpadding="2"
			   >
			<!--DWLayoutTable-->
			<tr>
				<td width="90" height="26" class="logindata">User Name</td>
				<td width="177"><input name="Username" type="text" size="25"
					accesskey="L" tabindex="1"></td>
			</tr>
			<tr>
				<td height="26" class="logindata">Password</td>
				<td><input name="Password" type="password" size="25"></td>
			</tr>
			<tr align="center" valign="middle">
				<td height="30" colspan="2"><input type="submit" name="Submit"
					value=" Login "></td>
			</tr>
			<%
         	if(!msg.equals("")){
         		out.println("<tr><td colspan=2 class='logindata'><font color='#FF0000'>");         		
         		out.println(msg);
         		out.println("</font></td></tr>");
         	}
          %>
		</table>
		</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="21">&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="21">&nbsp;</td>
		<td>&nbsp;</td>
		<td align="center" valign="middle"><a
			href="Parent/ParentRegistration.jsp">Parent Registration</a></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="120">&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
</table>
</form>
</body>
</html>
