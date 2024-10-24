 <%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.payroll.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
 
<html>
<head>

<title> :: PAYROLL ::</title>



 
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
 
 
 
<script language="JavaScript" src="../JavaScript/jquery/jquery-1.7.1.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.core.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.widget.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js" type="text/javascript"></script>

<script>
	
	
$(function() {
		$( "#date" ).datepicker({ minDate: -7, maxDate: "+7D" });
	});
 

 
	</script> 
	
	
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />

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
 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<body  onpaste="return false;" >
<%@ include file="index.jsp"%>
<form action="../SmartLoginAuth" method="get"   name="Cessation" onSubmit="return validate()"  AUTOCOMPLETE = "off">
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
		<table width="563" border="0" align="center" cellpadding="0"
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
					<td width="6"><spacer height="1" width="1" type="block"></td>
					<td width="549" valign="top">
					<table width="549" border="0" cellspacing="0" cellpadding="0">
						<tr class="boldEleven">
							<td height="20" colspan="2">
							<div align="center" class="boldEleven"><span
								class="boldEleven"><strong>RESIGN LETTER ISSUE 
								<%
								String Staffid = request.getParameter("Staffid");
								String sql =" SELECT a.CHR_EMPID,b.CHR_STAFFNAME FROM  pay_t_emp_ndc a, com_m_staff b  WHERE a.CHR_EMPID =b.CHR_EMPID  AND a.CHR_EMPID = '"+Staffid+"'" ;
								String data[][] =CommonFunctions.QueryExecute(sql);
								%>
								
								</strong></div>
							</td>
						</tr>
						<tr>
							<td colspan="2">
							<div align="right"><span class="boldEleven">* </span><span
								class="changePos">Mandatory</span></div>
							</td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>

						<tr>
							<td width="49%" height="19">&nbsp;</td>
							<td width="51%">&nbsp;</td>
						</tr>
						 
						<tr>
							<td height="19" colspan="2">
							<table width="337" border="0" align="center" cellpadding="2"
								cellspacing="0">
								<tr>
								  <td valign="middle"   class="boldEleven">Emp id / name </td>
								  <td><%=data[0][0]+"/ "+data[0][1]%></td>
							  </tr>
								<tr>
									<td width="140" valign="middle"   class="boldEleven">Date
									of Issue <font color="#CC0000">*</font></td>
									<td width="180"><input name="date" type="text" class="formText135"
										id="date" maxlength="11" readonly> 
	<script language="JavaScript"> setCurrentDate('date');</script></td>
								</tr>
								<tr>
									<td valign="top"   class="boldEleven">Description<font color="#CC0000">*</font></td>
									<td><textarea name="description" cols="25" rows="5"
										class="formText135" id="description" onKeyPress="textArea('reason','5000')"></textarea></td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							
							</td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<div align="center">
							  <input name="filename" type="hidden" id="filename" value="StaffCessation" />
							  <input name="actionS"  type="hidden" id="actionS" value="PAYStaffCessationIssue" />
							<input name="empid" type="hidden" id="empid" value="<%=data[0][0]%>">
							</div>
							</td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<table border="0" align="center" cellpadding="2" cellspacing="2">
								<tr>
									<td width="56"><input type="submit" name="Submit"
										id="submit_btn" class="buttonbold14" value="Submit"   accesskey="s"    /></td>
									<td width="56"><input type="button" name="submit"
										class="buttonbold14"  value="Close"   accesskey="c" 
										onClick="redirect('EmployeeCessation.jsp')" /></td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="6"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block"></td>
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
		<td height="40"><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</form>

<script language="javascript">
function validate() 
{
    
 
	if(
	    checkNull("date","Date of Cessation")
		&& checkNull("description","Enter the description")
	)
    	return true;
    else
    	return false;
}

  
</script>
