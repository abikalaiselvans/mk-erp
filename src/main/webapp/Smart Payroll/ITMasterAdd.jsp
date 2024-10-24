<%@ page import="java.io.*,java.util.*"%>
<%@page import="com.my.org.erp.bean.payroll.*"%>
<%@page import="com.my.org.erp.SmartPayroll.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>

<%@page import="com.my.org.erp.common.CommonFunction"%>
<html>
<head>
<title>:: PAYROLL ::</title>
 
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<script language="javascript">
function validate()
{
    if(checkNull("cessation","Type of Cessation ")
	&& checkNull("date","Date of Cessation")
	&& checkNull("reason","Reason")
	 
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
.style4 {color: #FF0000}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="Cessation" action="../SmartLoginAuth">
<table width="100%" border="0" align="center" cellpadding="2"
	cellspacing="2">
	<tr>
		<td></td>
	</tr>

	<tr>
		<td height="54">
		<table width="429" border="0" align="center" cellpadding="0"
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
					<td width="412" valign="top">
					<table width="401" border="0" align="center" cellpadding="0" cellspacing="0">
						<tr class="boldEleven">
							<td width="401" height="20">
							<div align="center" class="boldEleven"><span
								class="boldEleven"><strong>Income Tax Master  </strong></span><strong> </strong></div>							</td>
						</tr>
						<tr>
							<td>
							<div align="right"><span
								class="changePos"><span class="boldElevenlink">*</span> - All Fields are Mandatory</span></div>							</td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td></td>
						</tr>

						<tr>
							<td height="19">
							<table width="361" border="0" align="center" cellpadding="2"
								cellspacing="2">
								<tr>
                                  <td width="148" valign="middle"   class="boldEleven">Financial Year </td>
								  <td width="214"><select name="financial" class="boldEleven" id="financial">
								    <option value="0">Select</option>
								    <%
								    String data[][]=CommonFunction.RecordSetArray("select INT_FINANCIALYEARID,CHR_FINANCIALYEAR from com_m_financialyear ");
								    for(int i=0;i<data.length;i++)
								    	out.println("<option value="+data[i][0]+">"+data[i][1]+"</option>");
								    %>
								    </select>								  </td>
							  </tr>
								<tr>
                                  <td valign="middle"   class="boldEleven">Gender </td>
								  <td><select name="gender" class="boldEleven" id="gender">
								    <option value="0" selected>Select</option>
								   <option value="M">Male</option>
									  <option value="F">Female</option>
									  <option value="S">Senior Citizens (> 60 Years but less than 80 Years)</option>
									  <option value="V">Very Senior Citizens (80 Years and above)</option>
																																																							</select></td>
							  </tr>
								<tr>
                                  <td valign="middle"   class="boldEleven">From Salary</td>
								  <td><input name="from" type="text" class="formText135" id="from" onKeyPress="numericValue('from','13')"></td>
							  </tr>
								<tr>
                                  <td valign="middle"   class="boldEleven">To Salary</td>
								  <td><input name="to" type="text" class="formText135" id="to" onKeyPress="numericValue('to','13')"></td>
							  </tr>
								<tr>
                                  <td valign="middle"   class="boldEleven">Calculation</td>
								  <td><table width="200" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                      <th width="65" class="boldEleven" scope="col"><div align="left">
                                        <input name="calculate" type="radio" value="Y" checked>
                                      Yes</div></th>
                                      <th width="135" class="boldEleven" scope="col"><div align="left">
                                        <input name="calculate" type="radio" value="N">
                                      No</div></th>
                                    </tr>
                                  </table></td>
							  </tr>
								<tr>
                                  <td valign="middle"   class="boldEleven">Fixed Amount</td>
								  <td><input name="fixed" type="text" class="formText135" id="fixed" onKeyPress="doubleValue('fixed','10')"></td>
							  </tr>
								<tr>
                                  <td valign="middle"   class="boldEleven">Percentage</td>
								  <td><input name="precent" type="text" class="formText135" id="precent" onKeyPress="doubleValue('precent','10')"></td>
							  </tr>
								<tr>
                                  <td valign="middle"   class="boldEleven">Subtract Amount</td>
								  <td><input name="sub" type="text" class="formText135" id="sub" onKeyPress="doubleValue('sub','10')"></td>
							  </tr>
							</table>							</td>
						</tr>
						<tr>
							<td height="19"><input name="filename" type="hidden"
								id="filename" value="ITMaster" />
						  <input name="actionS"
								type="hidden" id="actionS" value="PAYITMasterAdd" />						</td>
						</tr>
						
						<tr>
							<td height="19">
							<table border="0" align="center" cellpadding="2" cellspacing="2">
								<tr>
									<td width="56"><input type="submit" name="Submit"
										id="submit_btn" class="buttonbold14" value="Submit"   accesskey="s"    /></td>
									<td width="56"><input type="button" name="submit"
										class="buttonbold14"  value="Close"   accesskey="c" 
										onClick="redirect('ITMasterView.jsp')" /></td>
								</tr>
							</table>							</td>
						</tr>
					</table>					</td>
					<td nowrap="nowrap" width="9"><spacer height="1" width="1"
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
						src="../Image/General/BRCorner.gif" width="7" /></div>					</td>
				</tr>
				<tr>
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
			</tbody>
		</table>		</td>
	</tr>
	
	<tr>
		<td height="40"><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</form>