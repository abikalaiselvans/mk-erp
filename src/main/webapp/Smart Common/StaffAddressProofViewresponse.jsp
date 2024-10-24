<%@ page import="java.lang.*,java.util.*,java.io.*,java.sql.*,com.my.org.erp.ServiceLogin.*"%>
 

<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
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


<title> :: COMMON ::</title>


</head>

<body  onpaste='return false;'>

<%
String adressproof= request.getParameter("adressproof");
String staffid= request.getParameter("staffid");
/*String staffphoto = request.getRealPath("/")+"Addressproof/"+staffid+"_"+adressproof +".jpg";
String photo="";
File f = new File(staffphoto);
 
if (f.exists())
	photo = "../Addressproof/"+staffid+"_"+adressproof +".jpg";
else 
	photo ="../StaffPhoto/default.png";	*/
	 
 response.sendRedirect("../AddressProofImages?staffid="+staffid+"&adressproof="+adressproof);
	%><br>
	 
	 
 	
					
</body>
</html>


