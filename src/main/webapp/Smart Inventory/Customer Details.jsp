<%@ page import="java.lang.*,java.util.*,java.io.*,java.sql.*"
	errorPage="../error/index.jsp"%>
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
	document.customer.action="InventoryMain.jsp";
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
.style3 {font-size: 14px}
-->
</style>
</head>
<body >
<form  AUTOCOMPLETE = "off"   name="customer" method="post" action="../SmartLoginAuth">
<table width="100" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><%@ include file="indexinv.jsp"%></td>
	</tr>
	<tr>
		<td height="84">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround" cellspacing="0" cellpadding="0" width="400"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td width="412">

					<table width="400" border="0" align="center" cellpadding="1"
						cellspacing="1"  >
						<tr>
							<td height="30" colspan="2" align="center"
								class="tablesubhead style3">Customers Details</td>
						</tr>
						<tr>
							<td width="182" height="30" align="center" class="bolddeepblue">Branch
							Name</td>
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
						<tr>
							<td colspan="2" align="center" class="bolddeepblue">
							<table align="center">
								<tr>
									<td width="56"><input type="submit" class="buttonbold13"
										name="action1" value="Submit"   accesskey="s"    onClick="return validate()" /></td>
									<td width="56"><input type="submit" class="buttonbold13"
										name="close1"  value="Close"   accesskey="c"  onClick="redirect( 'InventoryMains.jsp')" /></td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
			</tbody>
		</table>

		</td>
	</tr>
	<tr>
		<td><input name="filename" type="hidden" value="Report" /> <input
			name="actionS" type="hidden" value="INVcustomerInfo" /></td>
	</tr>
	<tr>
		<td align="center">&nbsp;</td>
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
