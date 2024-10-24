<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.payroll.*"%>
<%@ page import="com.my.org.erp.SmartPayroll.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>

<html>
<head>

<title> :: PAYROLL ::</title>


 <style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>

 
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<script language="javascript">
function validateFields()
    {
   	 if(checkNull('promotiondate','Enter Promotion Date')  
   	 && checkNullSelect('toDesigId','Select Designation Name','Select')
	 && checkNull('reason','Enter Reason') 
	 )
   	  {   	 	
   	 	   return true;
   	   }
   	 else{
   	   return false;	  
   	 }
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

 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="StaffPromotion" action="../SmartLoginAuth"
	onSubmit="return validateFields()">
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
							<div align="center" class="boldEleven"><strong>EMPLOYEE PROMOTION </strong></div>
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
							<div align="center">

							<table width="80%" border="0" align="center" cellpadding="2"
								cellspacing="2">
								<tr>
									<td width="140" align="left" valign="middle"
										  class="boldEleven">Staff id<span class="boldred"> *</span> </td>
									<td width="159" class="boldEleven"><span
										class="boldEleven"> <%
					  	String staff =request.getParameter("staffid");
                   		String staffname= com.my.org.erp.bean.Attendance.StaffRegistration.staffName(staff.trim());
						out.println(staff);
					  %> <input name="staffid" type="hidden" id="staffid"
										value="<%=staff%>"> </span></td>
								</tr>
								<tr>
									<td align="left" valign="middle"  
										class="boldEleven">Staff Name<span class="boldred"> *</span> </td>
									<td class="boldEleven"><span class="boldEleven"><%=staffname%></span></td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">Promotion Date<span class="boldred"> *</span> </td>
									<td class="boldEleven"><input name="promotiondate"
										type="text" class="formText135" id="promotiondate"
										 readonly="readonly" value=" " size="12" maxlength="10">
									<a href="javascript:cal2.popup();"> <img
										src="../JavaScript/img/cal.gif" width="16" height="16"
										border="0" alt="Click here to Pick Up the Date"></a></td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">Present Designation<span class="boldred"> *</span> </td>
									<td class="boldEleven">
									<%
					  	String pdesign = com.my.org.erp.bean.Attendance.StaffRegistration.getAnyValue("INT_DESIGID"," com_m_staff ","CHR_EMPID",staff,"0");
					  	int desigid =Integer.parseInt(pdesign);
					  	String designName = com.my.org.erp.bean.Attendance.StaffRegistration.getAnyValue("CHR_DESIGNAME"," com_m_desig ","INT_DESIGID",pdesign,"1");
					  	out.println(designName);
					  %> <input name="desigid" type="hidden" id="desigid"
										value="<%=desigid%>"></td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">Transfer Designation<span class="boldred"> *</span> </td>
									<td class="boldEleven"><select name="toDesigId"
										class="formText135" id="toDesigId">
										<option value="Select">Select</option>
										<%
					  
					  String district[]= com.my.org.erp.bean.Attendance.StaffRegistration.getAnyValueCombo(" com_m_desig ", "INT_DESIGID", "CHR_DESIGNAME").split("~");
					  
					  for(int u=0; u<district.length; u++)
					 	{
							String ds =district[u];
							String d[] = ds.replace("$","~").split("~");
							if(desigid == Integer.parseInt(d[0]))
							{
							}
					  		else
							{
								out.println("<option value='"+d[0]+"'>" +d[1]+"</option>");
							}	
					 	}	
					 
					  %>
									</select></td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">Reason<span class="boldred"> *</span> </td>
									<td class="boldEleven"><textarea name="reason" rows="5"
										class="formText135" id="reason" onKeyPress="textArea('reason','250')"></textarea></td>
								</tr>
								<tr>
								  <td valign="top" class="boldEleven"><!--Change Salary details <span class="boldred"> *</span>--> </td>
								  <td class="boldEleven"><input readonly name="salary" type="hidden" id="salary" value="Y" checked></td>
							  </tr>
							</table>
						</tr>
						<tr>
							<td height="19" colspan="2">&nbsp;</td>
						</tr>
						<tr>
							<td height="19" colspan="2">&nbsp;</td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<div align="center"><script language="JavaScript">
<!--
  var cal2=new calendar1(document.forms['StaffPromotion'].elements['promotiondate']);
  cal2.year_scroll=true;
  cal2.time_comp=false;
  setCurrentDate('promotiondate');
//-->
</script> <input name="filename" type="hidden" id="filename"
								value="StaffPromotion" /> <input name="actionS" type="hidden"
								id="actionS" value="PAYStaffPromotionAdd" /></div>
							</td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<table border="0" align="center" cellpadding="2" cellspacing="2">
								<tr>
									<td width="56"><input type="submit" name="Submit"
										id="submit_btn" class="buttonbold14" value="Submit" /></td>
									<td width="56"><input type="button" name="submit"
										class="buttonbold14"  value="Close"   accesskey="c" 
										onClick="javascript:history.back()" /></td>
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