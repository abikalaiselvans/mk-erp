<%@ page import="java.io.*,java.util.*,com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.bean.Attendance.*"%>
<%@ page import="com.my.org.erp.bean.payroll.*"%>
<%@ page import="com.my.org.erp.SmartPayroll.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>

<%@ page import="com.my.org.erp.ServiceLogin.DateUtil"%>
<html>
<head>

<title> :: PAYROLL ::</title>


 
 
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<script language="javascript">
function validate()
{
    if(checkNull("closedate","Select Closing date") 
	
	)
    	return true;
    else
    	return false;
}

</script>
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
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.style3 {COLOR: #000000; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;}
-->
</style>
</head>

<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="advance" action="../SmartLoginAuth" onSubmit="return validate()">
<table width="100%" border="0" align="center" cellpadding="2"
	cellspacing="2">
	<tr>
		<td></td>
	</tr>

	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="54">
		<table width="400" border="0" align="center" cellpadding="0"
			cellspacing="0" bgcolor="#dce4f9" class="BackGround">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="7"><spacer height="1" width="1" type="block"></td>
					<td width="549" valign="top">
					<table width="400" border="0" cellspacing="0" cellpadding="0">
						<tr class="boldEleven">
							<td height="20">
							<div align="center"><strong>Staff Advance Details
							<%
				   	String staffid =request.getParameter("staffid");
				   String sql="SELECT  A.CHR_EMPID,A.CHR_STAFFNAME from  com_m_staff  A where a.CHR_EMPID='"+staffid+"'";
				   String perinfo[][] = CommonFunction.RecordSetArray(sql);
				   sql="SELECT INT_ADVAMT,INT_ADVANCEID FROM pay_m_advance WHERE CHR_EMPID='"+perinfo[0][0]+"' ";
				   sql=sql+" and INT_ADVANCEID=(select max(INT_ADVANCEID) from pay_m_advance WHERE CHR_EMPID='"+perinfo[0][0]+"')";
				   String advData[][] = CommonFunction.RecordSetArray(sql);
				  %> </strong></div>							</td>
						</tr>
						<tr>
							<td>
							<div align="right"><font color='red'>* </font><span
								class="changePos">Mandatory</span></div>							</td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td height="19">
							<table width="278" border="0" align="center" cellpadding="2"
								cellspacing="2">
								<tr>
									<td width="119" align="left" valign="middle"
										  class="boldEleven">Staff id</td>
									<td width="145" class="boldEleven"><%=perinfo[0][0]%></td>
								</tr>
								<tr>
									<td align="left" valign="middle"  
										class="boldEleven">Staff Name</td>
									<td class="boldEleven"><%=perinfo[0][1]%></td>
								</tr>
								<tr>
									<td align="left" valign="middle"  
										class="boldEleven">Advance Amount</td>
									<td class="boldEleven"><input name="advamount" type="text"
										class="tabledata" id="advamount"
										onkeyPress="numericValue('advamount',6)" size="20"
										maxlength="10" value="<%=advData[0][0]%>"> <input
										type="hidden" name="staffid" value="<%=perinfo[0][0]%>">
									<input type="hidden" name="advid" value="<%=advData[0][1]%>"></td>
								</tr>
							</table>							</td>
						</tr>
						<tr>
							<td height="19">
							<div align="center"><input name="filename" type="hidden"
								id="filename" value="EmpAdvance" /> <input name="actionS"
								type="hidden" id="actionS" value="PAYStaffAdvanceUpdate" /></div>							</td>
						</tr>
						<tr>
							<td height="19">
							<table border="0" align="center" cellpadding="2" cellspacing="2">
								<tr>
									<td width="56"><input type="submit" name="Submit"
										id="submit_btn" class="buttonbold14" value="Update" /></td>
									<td width="56"><input type="button" name="submit"
										class="buttonbold14"  value="Close"   accesskey="c" 
										onClick="redirect('Advance.jsp')" /></td>
								</tr>
							</table>							</td>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="7"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2">
					<div align="right">
					<div align="right"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></div>
					</div>
					</td>
					<td height="13"><spacer height="1" width="1" type="block"></td>
					<td colspan="2" rowspan="2" valign="bottom">
					<div align="right"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></div>
					</td>
				</tr>
				<tr>
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
			</tbody>
		</table>
		</td>
	</tr>
	<tr>
		<td height="23">&nbsp;</td>
	</tr>
	<tr>
		<td height="40">&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>