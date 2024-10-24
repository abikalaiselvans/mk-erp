<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<html>
<head>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

mythraframework

<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<title>:: INVENTORY ::</title><style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
 }
-->
</style><link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/smartcommon/LoadBranchAjax.js"></script> 

<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>

<script language="javascript" type="text/javascript">
function Validate()
  {
    	if(checkNullSelect( "company","Select Company" ,'0')  
	 
		&& checkNullSelect( "reportType","Select Export Type" ,'0') )	
		return true;
	
	else
	return false;
}
</script>


 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

</head>
<body  onpaste="return false;" >
<%@ include file="indexinv.jsp"%>

<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="return Validate()">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
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
		<td height="200">
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="390"
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
					<table width="369" height="204" border="0" cellpadding="2" cellspacing="0"
						 >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="18" colspan="2"  class="BackGround">Customer Bill Accumulated Detail </td>
						</tr>

						<tr class="bolddeepblue">
							<td height="24" valign="middle" class="bolddeepblue"><!--DWLayoutEmptyCell-->&nbsp;</td>
							<td valign="top" class="bolddeepblue"><div align="right"><span class="boldEleven"><span class="boldEleven">  <span class="bolddeepred">*</span> Mandatory </span></span></div></td>
						</tr>
						<tr>
						<td width="142" height="28" valign="middle" class="boldEleven">
							Company <span class="bolddeepred">*</span> </td>
							<td width="219"><select name="company" id="company"
								onBlur="loadBranch()" 
								class="formText135" style="width:250px">
								<option value="0">Select Company</option>
								<%                  
     					String queryBranch1="SELECT * FROM  com_m_company ";
     					String	branch1[][] = CommonFunctions.QueryExecute(queryBranch1);
     					for(int i=0;i<branch1.length;i++)
 	 						out.println("<option value='"+branch1[i][0]+"'>"+branch1[i][1]+"</option>");
 			   %>
						  </select></td>
						</tr>
						<tr>
							<td width="142" height="28" valign="middle" class="boldEleven">
							Branch <span class="bolddeepred">*</span> </td>
							<td width="219"><select name="branch" id="branch"
								class="formText135" style="width:250px">
								<option value="0">All</option>
						  </select></td>
						</tr>
						<tr class="bolddeepblue">
						  <td height="24" valign="middle" class="boldEleven">Division<span class="style3"> <span class="bolddeepred">*</span></span></td>
						  <td valign="top" class="bolddeepblue"><select
										name="division" class="formText135" id="division" tabindex="1" style="width:180" >
                            <option value='0'>All</option>
                            <%
								String division[][] =  CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                          </select></td>
					  </tr>
						<tr class="bolddeepblue">
						  <td height="24" valign="middle" class="style4"><span class="boldEleven">Export Type</span> <span class="bolddeepred">*</span> </td>
						  <td valign="top" class="bolddeepblue"><%@include file="loadJasperReportType.jsp" %></td>
					  </tr>
						<tr>
							<td height="28" colspan="2" valign="middle" class="bolddeepblue"><span class="boldEleven">
							  <input name="filename" type="hidden" id="filename"
										value="Rept_JCustomerBillAccumulated">
                              <input name="actionS"
										type="hidden" id="actionS"
										value="INVRept_JCustomerBillAccumulated">
                              <input name="rptfilename" type="hidden" id="rptfilename" value="PageWidth800">
                            </span></td>
						</tr>
						<tr>
							<td height="28" colspan="2" valign="middle" class="bolddeepblue">
							<table width="142" border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
									<td width="61"><input name="Submit2" type="submit"
										class="buttonbold14" id="submit" value="Submit"   accesskey="s"   ></td>
									<td width="60"><input class="buttonbold14" type="button"
										name="Submit"  value="Close"   accesskey="c" 
										onClick="javascript:window.close()"></td>
								</tr>
							</table>							</td>
						</tr>
						<tr>
							<td height="2"></td>
							<td></td>
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
					<td colspan="2" rowspan="2"><img height="11"
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
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
</form>
<%@ include file="../footer.jsp"%>
</body>
</html>
