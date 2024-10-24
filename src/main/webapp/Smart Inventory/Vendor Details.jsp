<%@ page import="java.lang.*,java.util.*,java.io.*,java.sql.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<html>
<head>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
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

<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>

<script type="text/javascript"> 
function validate()
{
	if(checkNullSelect('branchId','Select the Branch','select'))
	return true;
	else 
	return false;
}

function mainPage()
{
	document.vendor.action="InventoryMain.jsp";
}



</script>
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
</head>
<body >
<form  AUTOCOMPLETE = "off"   name="vendor" method="post" action="../SmartLoginAuth">
<table width="100" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><%@ include file="indexinv.jsp"%></td>
	</tr>
	<tr>
		<td height="84">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="400" border="1" align="center" cellpadding="1"
			cellspacing="1"  >
			<tr>
				<td height="25" colspan="2" align="center"  
					class="tablehead">Vendors Details</td>
			</tr>
			<tr>
				<td width="182" class="bolddeepblue">Branch Name</td>
				<td width="205">
				<%
			  			Connection con1;
						ResultSet rs1;
			  			con1 = conbean.getConnection();
      					Statement st1 = con1.createStatement();      			
						rs1 = st1.executeQuery("SELECT * FROM  com_m_branch ");
			  		%> <select name="branchId" id="branchId">
					<option value="select">Select</option>
					<option value="all">All</option>
					<%
							while(rs1.next())
							out.println("<option value='"+rs1.getString("INT_BRANCHID") +"'>"+rs1.getString("CHR_BRANCHNAME")+" </option>");
					   %>
				</select></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td><input name="filename" type="hidden" value="Report" /> <input
			name="actionS" type="hidden" value="INVvendorInfo" /></td>
	</tr>
	<tr>
		<td align="center">
		<table>
			<tr>
				<td width="56"><input type="submit" class="buttonbold"
					name="action1" value="Submit"   accesskey="s"    onclick="return validate()" /></td>
				<td width="56"><input type="submit" class="buttonbold"
					name="close1"  value="Close"   accesskey="c"  onclick="mainPage()" /></td>
			</tr>
		</table>


		</td>
	</tr>
</table>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<%@ include file="../footer.jsp"%></form>

</body>
</html>
