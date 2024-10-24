<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
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


</head>

<body  onpaste='return false;'>
<%
try
{
	String type=""+request.getParameter("type");
	String sql ="SELECT CHR_SMARTATTENDANCE,CHR_SHIFTTYPE FROM ATT_BASICSETTINGS";
	String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	 
	if("M".equals(data[0][0]))
	{
		out.println("Manual Future Enhancement");
	}
	else if("S".equals(data[0][0]))
	{
		out.println("smart  Future Enhancement");
	}
	else if("P".equals(data[0][0]))
	{
		response.sendRedirect("Proximitybefore.jsp?type="+type);
	}
	else if("B".equals(data[0][0]))
	{
		response.sendRedirect("../AttendanceFinger/BiometricAttendance.jsp?type="+type+"&shift="+data[0][1]);
	}
	
}
catch(Exception e)
{

}	
%>
</body>
</html>
