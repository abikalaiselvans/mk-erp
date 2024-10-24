<%@ page import="java.sql.*,java.util.*,java.io.*,com.my.org.erp.common.*"%>
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


<title> :: SUSPEND ::</title>
 
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
<script language="javascript" src="../JavaScript/Servercheck.js"></script>
<script language="javascript">
loadServer()
</script>
 <link href="style.css" rel="stylesheet" type="text/css">
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %> 
</head>

<body  onpaste="return false;"  >
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><%@ include file="header.jsp" %></td>
  </tr>
   
  <tr>
    <td>
	<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" class="AdminBodyTable">
		<tr>
		  <td  width="10%" height="800" align="left" valign="top" class="UserLeftPanel">
		  
		  
		    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" id="FLoginTable" height="auto">
               
              <tr>
                <td height="200" colspan="2" align="center" valign="middle">
				  <div align="center">
				    <%
			String staffphoto = request.getRealPath("/")+"/uploadfiles/StaffPhoto/"+session.getAttribute("EMPID") +".jpg";
			String photo="";
			File f = new File(staffphoto);
			if (f.exists())
				photo = "../uploadfiles/StaffPhoto/"+session.getAttribute("EMPID")  +".jpg";
			else 
				photo ="../uploadfiles/StaffPhoto/default.jpg";	
				%><br>
			        <img src="<%=photo%>" width="125" height="125" border="0"><br>				</div></td>
              </tr>
              <tr>
                <td colspan="2" align="center" valign="middle">
				
				  
				<jsp:include page="Menu.jsp" flush="true" />
	 			</td>
              </tr>
            </table></td>
			
			
		  <td  width="90%"  class="MiddlePanel"> 
		  <iframe src="Userframe.jsp" width="98%"
					name="UserFrame"   height="100%"   frameborder="0"
					style="border-width: 1px; border-color: #F48442; border-style: dotted;">		  </iframe></td>
		</tr>
</table>	</td>
  </tr>
  
  
  
  <tr>
    <td></td>
  </tr>
  <tr>
    <td> <jsp:include page="../footer.jsp" flush="true" /></td>
  </tr>
</table>



 

</html>
