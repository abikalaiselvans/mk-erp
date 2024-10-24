<%
try
{
CommonFunctions.autoUpdate(request,""+application.getInitParameter("Auto"));
%>

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


<title> :: UTILITY :: </title>


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
 <link href="style.css" rel="stylesheet" type="text/css">
</head>

<body  onpaste="return false;"  >
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
	  <%@ include file="header.jsp" %>
      
      
      
      
      
      
     

      
      
      
      
      </td>
  </tr>
  <tr>
    <td>
	<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" class="AdminBodyTable">
		<tr>
		  <td  width="10%" height="800" align="left" valign="top" class="UserLeftPanel">
		  
		  
		    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" id="FLoginTable" height="auto">
               
              <tr>
                <td colspan="2" align="center" valign="middle">
                  <%@ include file='Menu.jsp' %> </td>
              </tr>
            </table></td>
			 
		  <td  width="90%"  class="MiddlePanel"> 
		  <iframe src="Userframe.jsp" width="98%"
					name="UserFrame"   height="100%"   frameborder="0"
					style="border-width: 1px; border-color: #F48442; border-style: dotted;">		  </iframe></td>
			
			
		</tr>
</table>
	
	</td>
  </tr>
  <tr>
    <td><%@ include file="../footer.jsp"%></td>
  </tr>
</table>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>


 

</html>
