<%@ page import="java.sql.*,java.util.*,java.io.*,java.text.*" %>
<html>
<head>
<%
try
{
	CommonFunctions.autoUpdate(request,""+application.getInitParameter("Auto"));
%>
<title>:: HRM ::</title>


 
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
</style></head>
<body  onpaste='return false;'>
<table width="100%" border="0" cellspacing="0" cellpadding="0" bordercolor="#666666">
  <tr>
    <td><%@ include file="indexhrm.jsp"%> </td>
  </tr>
  <tr>
    <td height="450">
	<%
			/*
			 Locale[] locales = Locale.getAvailableLocales();
			for (int i = 0; i < locales.length; i++) 
			{
				String iso = locales[i].getCountry();
				String country = locales[i].getDisplayCountry();
				String name =   locales[i].getDisplayName();
				 out.println((i+1)+"&nbsp;&nbsp;"+iso+"&nbsp;&nbsp;&nbsp;"+name+"&nbsp;&nbsp;&nbsp;"+country+"  <br>");
				
			} 
			*/
			
			
			
			  
	%></td>
  </tr>
  <tr>
    <td><%@ include file="../footer.jsp"%></td>
  </tr>
</table>

 
</body>
</html>
<%
}
catch(Exception e)
{

}
%>