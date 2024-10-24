<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>

<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../../JavaScript/comfunction.js"></script>
<body >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="838" height="158" border="0" align="center"
			cellpadding="0" cellspacing="0"  
			 >
			<tr class="BackGround">
				<td height="31" class="BackGround">
				<div align="center"><span class="boldThirteen">Daily
				Inward </span></div>
				</td>
			</tr>
			<tr>
				<td height="127" valign="top" class="footermenu">&nbsp;</td>
			</tr>

		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table border="0" align="center" cellpadding="3" cellspacing="3">
			<!--DWLayoutTable-->
			<tr>
				<td width="56" valign="top"><input type="submit"
					class="buttonbold13" name="action1"  value="Add"   accesskey="s"   onclick="Add()" /></td>
				<td width="56" valign="top"><input type="submit"
					class="buttonbold13" name="action12" id="btnEdit" value="Edit"
					onclick="return Edit()" /></td>


				<%
		  String usertype=""+session.getAttribute("USRTYPE");
		  if("F".equals(usertype))
		  {
	  %>
				<td width="56"><input type="submit" class="buttonbold13"
					name="Submit3" id="btnDelete" value="Cancel"
					onClick="return Delete()" /></td>
				<%
		}
		else
		{
			out.println("<input type='hidden' id='btnDelete'>");
		}
		%>
				<td width="56"><input type="button" class="buttonbold13"
					 value="Close"   accesskey="c"  onClick="redirect('../InventoryMain.jsp')" /></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>
</body>
</html>
