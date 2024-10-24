<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!
	Connection con;
	Statement st;	
%>
<%@ page import="com.my.org.erp.bean.Attendance.StaffRegistration"%>
<html>
<head>
<title>:: INVENTORY ::</title> 
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

</head>
<script language="JavaScript">
function mainPage()
	{
	document.a.action="InventoryMain.jsp";
	}
</script>
<body    leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	class="body">
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="a" method="post">
<table width="1000" height="408" border="0" cellpadding="0"
	cellspacing="0">
	<tr valign="top">
		<td width="231" height="390">
		<table width="216" border="0" cellpadding="5" cellspacing="5"
			bordercolor="#FF9900">
			<tr>
				<td width="181" height="22"></td>
			</tr>
			<tr>
				<td height="25" align="center" valign="middle">&nbsp;</td>
			</tr>
			<tr>
				<td height="25" align="center" class="boldEleven"></td>
			</tr>
			<tr>
				<td height="25" align="center" class="boldEleven"><a
					target="searchMain" href="../Smart Inventory/IFrameProduct.jsp">
				Product Group Wise </a></td>
			</tr>
			<tr>
				<td height="21" align="center" class="boldEleven"><a
					target="searchMain" href="../Smart Inventory/IFrameItem.jsp">Product
				Wise </a></td>
			</tr>
			<tr>
				<td height="21" align="center" class="boldEleven">&nbsp;</td>
			</tr>
			<tr>
				<td height="21" align="center" width="56">&nbsp;</td>
			</tr>

		</table>
		</td>
		<td width="100%" height="390" align="center" valign="middle"
			bgcolor="#66FFFF"><iframe src="IFrameMain.jsp" name="searchMain"
			width="100%" height="100%" frameborder="0"> </iframe></td>
	</tr>
	<table align="center">
		<tr>
			<td width="56"><input type="submit" class="buttonbold13"
				name="close"  value="Close"   accesskey="c"  onClick="redirect( 'InventoryMains.jsp')"></td>
		</tr>
	</table>
	<tr>
		<td colspan="2"><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</body>
</html>


