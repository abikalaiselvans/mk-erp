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
.style16 {color: #666666;
	font-size: 24px;
}
-->
</style>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
	
				function validate()
	
					{				
						var dname=document.getElementById("design").value
						var des=document.getElementById("des").value
    				    submitOK="true"
                          			
						    if (dname=="")
 							 {
								alert(" Enter Designation Name")
								document.a.design.focus()
       					         submitOK="false"
							 }
				 	      if (submitOK=="false")
								 {
								 return false
 							 }
 	
					}	
			</script>

</head>
<form  AUTOCOMPLETE = "off"   name=a method="post" action="DesignationInsertion.jsp"
	ONSUBMIT="return validate()">
<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<br>
<br>
<br>
<table width="1000" border=0>
	<!--DWLayoutTable-->
	<tr>
		<td width="305" height="102">&nbsp;</td>
		<td colspan="3" valign="top" background="../if">
		<table width="425" border="1" cellspacing="2" cellpadding="2"
			 >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle">
				<td height="28" colspan="2" class="tablehead" >Designation&nbsp;-
				Add</td>
			</tr>
			<tr>
				<td width="150" height="29" valign="middle" class="tabledata">Designation
				<font color="#ff0000">*</font></td>
				<td width="246" valign="top"><input name="design" type="text"
					size="40" onkeypress="charOnly('design','25')"></td>
			</tr>
			<tr>
				<td height="29" valign="middle" class="tabledata">Description</td>
				<td valign="top"><input name="des" type="text" size="40"
					onkeypress="charOnly('des','25')"></td>
			</tr>
			<tr>
				<td height="2"></td>
				<td></td>
			</tr>
		</table>
		</td>
		<td width="255">&nbsp;</td>
	</tr>
	<tr>
		<td height="52">&nbsp;</td>
		<td width="175">&nbsp;</td>
		<td width="60">&nbsp;</td>
		<td width="183">&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="26"></td>
		<td></td>
		<td valign="top"><input type="submit" name="Submit"
			value="Submit"></td>
		<td></td>
		<td></td>
	</tr>

</table>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<table width="1002" border=0>
	<!--DWLayoutTable-->
	<tr>
		<td width="996" height="72">&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%>
</td>
<br>
<% 
	String msg= request.getParameter("msg");	
	if(msg.equals(null)) msg="";
	if(msg.equals(""))
	   msg="";
	else  {  
%>
<script language="javascript">
	   alert(<%=msg%>);
	   document.a.design.focus()
</script>
<%
			}	
%>
<br>
</body>
</form>
</html>
