<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.io.*" errorPage="" %>
<%@ page import="com.my.org.erp.common.CommonFunctions" %>
<html>
<head>
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


<title> :: ATTENDANCE ::</title>


<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
  
<body  onpaste="return false;"  >

 <%
 try
 {
	String cardno =request.getParameter("cardno");
	String type=""+request.getParameter("type");
	String title="";
	if("SWS".equals(type)  )
	{
		title="Single Entry With Shift";
		response.sendRedirect("proximityresponsesws.jsp?cardno="+cardno+"&type="+type+"&title="+title);
	}	
	else if("SWOS".equals(type)  )
	{
		title="Single Entry Without Shift";
		response.sendRedirect("proximityresponseswos.jsp?cardno="+cardno+"&type="+type+"&title="+title);
	}	
	else if("MWS".equals(type)  )
	{
		title="Multi Entry With Shift";
		response.sendRedirect("proximityresponsemws.jsp?cardno="+cardno+"&type="+type+"&title="+title);
	}	
	else if("MWOS".equals(type)  )
	{
		title="Multi Entry Without Shift";
		response.sendRedirect("proximityresponsemwos.jsp?cardno="+cardno+"&type="+type+"&title="+title);
	}
}
catch(Exception e)
{
}		
	%>
</body>
</html>
