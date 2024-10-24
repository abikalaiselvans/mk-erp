<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.Attendance.*"%>
<%@ page import="com.my.org.erp.bean.payroll.*"%>
<%@ page import="com.my.org.erp.SmartPayroll.*"%>


<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>

<html>
<head>

<title> :: PAYROLL ::</title>


 
 
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<script language="JavaScript">
 function validate()
{
    if( 
	checkNull("TxtAmount","Enter the Amount") 
	&& checkNull("TxtChequeno","Enter the Cheque number ") 
	 
	)
    	return true;
    else
    	return false;
}
</script>

<script type="text/JavaScript">
<!--
function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='MessBillEdit.jsp?SelMonth="+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}
//-->
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
.style4 {color: #FF0000}
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
							<td height="20">
							<div align="center"><strong>Mess Bill Details <%
				   	String staff =request.getParameter("staffid");
                   	String staffname= com.my.org.erp.bean.Attendance.StaffRegistration.staffName(staff.trim());
				   	boolean flag =com.my.org.erp.SmartPayroll.StaffRegistration.messbillRecordExist(staff.trim()) ;
				   	if(flag==false)
					   response.sendRedirect("Mess Bill.jsp?staffid="+staff);
				   
                	java.text.SimpleDateFormat datetime=new java.text.SimpleDateFormat("yyyy-MM-dd");
                	java.util.Date date=new java.util.Date();
                	String updatedate = ""+datetime.format(date);
                	int year =1900+date.getYear();
					//String month = com.my.org.erp.ServiceLogin.DateUtil.getMonth(date.getMonth()+1);
					  
					String month = com.my.org.erp.ServiceLogin.DateUtil.getMonth(date.getMonth()+1);
					String getVal = com.my.org.erp.SmartPayroll.StaffRegistration.getRandomMessbillAmount(staff.trim(),year,month);
                    String amtVal[] = getVal.split("~");
                    %> </strong></div>
							</td>
						</tr>
						<tr>
							<td>
							<div align="right"><span class="boldEleven style4">*
							</span><span class="changePos">Mandatory</span></div>
							</td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td></td>
						</tr>

						<tr>
							<td height="19">&nbsp;</td>
						</tr>
						<tr>
							<td height="19">
							<table width="278" border="0" align="center" cellpadding="2"
								cellspacing="2">
								<tr>
									<td align="left" valign="middle"  
										class="boldEleven">Staff id</td>
									<td class="boldEleven"><span class="boldEleven"><%=staff%>
									<input name="staffid" type="hidden" id="staffid"
										value="<%=staff%>"> </span></td>
								</tr>
								<tr>
									<td align="left" valign="middle"  
										class="boldEleven">Staff Name</td>
									<td class="boldEleven"><span class="boldEleven"><%=staffname %></span></td>
								</tr>
								<tr>
									<td width="108" align="left" valign="middle"
										  class="boldEleven">Year<span
										class="style4"> *</span></td>
									<td width="170" class="boldEleven"><%=year%> <input
										name="year" type="hidden" id="year" value="<%=year%>"></td>
								</tr>
								<tr>
									<td width="108" align="left" valign="middle"
										  class="boldEleven">Month <span
										class="style4">*</span></td>
									<td class="boldEleven"><%=month%> <input name="Month"
										type="hidden" id="Month" value="<%=month%>"></td>
								</tr>
								<tr>
									<td class="boldEleven">Amount <span class="style4">*</span>
									</td>
									<td class="boldEleven"><input name="TxtAmount" type="text"
										class="formText135" id="TxtAmount"
										onkeyPress="numericValue('TxtAmount',6)" size="14"
										value="<%= amtVal[0] %>"></td>
								</tr>
								<tr>
									<td class="boldEleven">Cheque No</td>
									<td class="boldEleven"><input name="TxtChequeno"
										type="text" class="formText135"
										onkeyPress="alphaNumeric('TxtChequeno',10)" size="14"
										value="<%= amtVal[1] %>"></td>
								</tr>

							</table>
							</td>
						</tr>
						<tr>
							<td height="19">
							<div align="center"><input name="filename" type="hidden"
								id="filename" value="StaffMessBill" /> <input name="actionS"
								type="hidden" id="actionS" value="PAYStaffMessBillUpdate" /></div>
							</td>
						</tr>
						<tr>
							<td height="19">
							<table border="0" align="center" cellpadding="2" cellspacing="2">
								<tr>
									<td width="56"><input type="submit" name="Submit"
										id="submit_btn" class="buttonbold14" value="Update" /></td>
									<td width="56"><input type="button" name="submit"
										class="buttonbold14"  value="Close"   accesskey="c" 
										onClick="redirect('Mess Bill.jsp')" /></td>
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
		<td height="23">&nbsp;</td>
	</tr>
	<tr>
		<td height="40">&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>