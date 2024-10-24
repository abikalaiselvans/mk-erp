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
<script language="javascript" src="../JavaScript/comfunction.js">
</script>
<script language="javascript">

function personalinfopdf()
{
	var file ="StaffidcardPdf1.jsp?staffid=<%=request.getParameter("staffid")%>";  
	 
	var width=1000, height=screen.height-120;
  	var left =0;
	var top = 0;
	
	var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
	 
	var screen_height = screen.height;
	var screen_width = screen.width;
	var buffer = (document.all || document.layers ||documentGetElementByID) ? 30 : 48;
	if (screen_height >= 768) 
	{
		screen_width = 1024;
		screen_height = 768;
	 	var window_width = 1024-12;
     	var window_height = 768-buffer;
     	var window_top = 0;
     	var window_left = 0;
     	window.open(file,'',' resizable=no,toolbar=yes,scrollbars=yes, status=no,width=' + window_width + ',height=' + window_height + ',top=' + window_top + ',left=' + window_left + '');
	} 
	
	//document.frm.action=file;
	 
	
}

 </script>
<body  onpaste="return false;" onLoad="personalinfopdf()">
 
</body>
</html>
