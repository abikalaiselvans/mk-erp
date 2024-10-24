<%@ page import="java.io.*,java.util.*"%>
<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{

%>
 
 <html>
<head>

<title> :: UTILITY :: </title>


<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

<%@include file="Redirect.jsp" %>

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

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<body  onpaste='return false;'>
 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td> </td>
	</tr>
	<tr>
		<td height="100">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table align="center" width="60%" border="0"  
			cellpadding="1" cellspacing="1">
			<tr>
				<td align="center">
				<div id="divscroll" style="OVERFLOW: auto;width:780px;height:120px">
				<% 			    
			  	try
			  		{
			  		 
					 String ename = request.getParameter("ename");
					 String rights = request.getParameter("rights");
					 String add = request.getParameter("add");
					 String edit = request.getParameter("edit");
					 String delete = request.getParameter("delete");
					 
					 String sql = " ";
					 sql = "    UPDATE m_user a, m_user_privilege b SET ";
					 sql = sql +" b.CHR_ADD_"+rights.trim()+" ='"+add+"' ,";
					 sql = sql +" b.CHR_EDIT_"+rights.trim()+" ='"+edit+"' ,";
					 sql = sql +" b.CHR_DELETE_"+rights.trim()+" ='"+delete+"'  ";
					 sql = sql +" WHERE a.CHR_USRNAME=b.CHR_USRNAME  ";
					 sql = sql +" AND a.CHR_EMPID = '"+ename+"' ";
					  CommonFunctions.Execute(sql);

			  		}
			  		catch(Exception e)
			  		{
					  	out.println("<br> "+e.getMessage());
			  			 
			  		}	
					
									 
		   %> <span class="boldEleven"> Updated Sucessfully </span></div>
		</table>
		</td>
	</tr>
	<tr>
		<td align="center">
		<table>
			<tr>
				<td width="54"><input type="submit"  value="Close"   accesskey="c" 
					class="buttonbold"  onClick="redirect('Userframe.jsp')"></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td height="100"></td>
	</tr>
</table>
 </form>
</body>
</html>

<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
