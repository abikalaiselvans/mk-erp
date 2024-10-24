 <%@ page import="java.io.*,java.util.*"%>
<%-- <%@ page import="sun.net.smtp.SmtpClient"%> --%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>


<html>
<head>
<title><%= CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='AMC' ")[0][0]%></title>
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
 <link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" type="text/javascript">
function validate()
  {
  	if(checkNullSelect( "reportType","Select Export Type" ,'0'))	
		return true;
	else
	return false;
}
</script>

</head>

<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<table>
<tr>
<td  height="40">
</td>
</tr>
</table>

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
	  <td><form name="frm" method="post" action="../SmartLoginAuth" onSubmit="return validate()">
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="250"
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
				  <td width="412"><table width="327" border="0" cellspacing="2" cellpadding="2">
                    <tr>
                      <td height="40" colspan="2"><div align="center" class="bigusername">Customer Service Group List Report </div></td>
                    </tr>
                    <tr>
                      <td width="124" height="42" class="boldEleven"><span class="style4">Export Type</span> <span class="bolddeepred">*</span></td>
                      <td width="189"><span class="boldEleven">
                        <select name="reportType" id="reportType">
                          <option value="0">Select Export Type</option>
                          <option value="csv">CSV</option>
                          <option value="xls">Excel</option>
                          <option value="html">HTML</option>
                          <option value="pdf" selected="selected">PDF</option>
                          <option value="txt">Text</option>
                          <option value="rtf">Word</option>
                          <option value="xml">XML</option>
                        </select>
                      </span></td>
                    </tr>
                    <tr>
                      <td colspan="2"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                        <tr>
                          <td><input name="Submit" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   ></td>
                          <td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('AMCmain.jsp')"></td>
                        </tr>
                      </table>
                        <span class="boldEleven">
                        <input name="filename" type="hidden" id="filename"
										value="Rept_JcustomerServiceGroupList">
                        <input name="actionS"
										type="hidden" id="actionS"
										value="AMCRept_JcustomerServiceGroupList">
                        <input name="rptfilename" type="hidden" id="rptfilename" value="customerServiceGroupMaster">
                      </span></td>
                    </tr>
                  </table></td>
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
		</table>	</form>  </td>
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

<table>
<tr>
<td  height="40">
</td>
</tr>
</table>

<%@ include file="../footer.jsp"%>
</body>
</html>
