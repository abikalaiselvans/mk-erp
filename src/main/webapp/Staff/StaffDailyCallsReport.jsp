<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="../error/error.jsp"%>
<html>
<head>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

<%@include file="Redirect.jsp" %>

<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />


<title>:: STAFF ::</title>

 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<body  onpaste="return false;" >
<p>&nbsp;</p>
<table width="600" border="0" align="center" cellpadding="0"
			cellspacing="0" bgcolor="#dce4f9" class="BackGround">
  <tbody>
    <tr>
      <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
      <td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
      <td width="10" colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
    </tr>
    <tr>
      <td height="6"><spacer height="1" width="1" type="block" /></td>
    </tr>
    <tr>
      <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
      <td width="6"><spacer height="1" width="1" type="block" /></td>
      <td   valign="top"><form action="StaffDailyCallsReportResponse.jsp" method="post" name="frm" id="frm">
        <table width="100%" border="0" cellspacing="4" cellpadding="3"  class="boldEleven">
          <tr>
            <td colspan="4"><div align="center" class="copyright"> REPORT </div></td>
          </tr>
          <tr>
            <td width="6%">&nbsp;</td>
            <td width="24%" class="boldEleven">&nbsp;</td>
            <td width="64%" class="boldEleven"><a href="StaffDailyCallsDateReport.jsp">Date</a></td>
            <td width="6%">&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td class="boldEleven">&nbsp;</td>
            <td class="boldEleven"><a href="StaffDailyCallsDateRangeReport.jsp">Date Range </a></td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td class="boldEleven">&nbsp;</td>
            <td class="boldEleven"><a href="StaffWiseDailyCallsReport.jsp">Employee wise </a></td>
            <td>&nbsp;</td>
          </tr>
          <!--<tr>
            <td>&nbsp;</td>
            <td class="boldEleven">Call Type   <span class="errormessage">* </span></td>
            <td class="boldEleven">
			<select name="calltype" class="formText135" id="calltype"  tabindex="5">
			<option value="0">All</option>
			<option value="1">'01' Calls</option>
			<option value="2">'02' Calls</option>
			<option value="3">Installation</option>
			<option value="4">Chargable Call</option>
            </select>            </td>
            <td>&nbsp;</td>
          </tr>

          <tr>
            <td>&nbsp;</td>
            <td class="boldEleven">Calls Status  <span class="errormessage">* </span></td>
            <td class="boldEleven"><select name="callstatus" class="formText135" id="callstatus"  tabindex="6">
			<option value="0">All</option>
			 <option value="C">Closed</option>
			<option value="P">Pending</option>
            </select>            </td>
            <td>&nbsp;</td>
          </tr>-->
          <tr>
            <td colspan="4">&nbsp;</td>
          </tr>
          <tr>
            <td colspan="4"><table width="120" border="0" align="center" cellpadding="3" cellspacing="4">
                <tr>
                  <td valign="top"><input type="button" class="buttonbold13" name="edit" id="edit"  value="Close"   accesskey="c"  onClick="redirect('../Staff/Userframe.jsp')"  tabindex="16" /></td>
                </tr>
            </table></td>
          </tr>
        </table>
                  </form>
      </td>
      <td nowrap="nowrap" width="6"><spacer height="1" width="1"
						type="block" /></td>
      <td width="1" class="BorderLine"><spacer height="1" width="1"
						type="block" /></td>
    </tr>
    <tr>
      <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
      <td height="6"><spacer height="1" width="1" type="block" /></td>
      <td colspan="2" rowspan="2" valign="bottom"><div align="right"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></div></td>
    </tr>
    <tr>
      <td class="BorderLine" height="1"></td>
    </tr>
  </tbody>
</table>
</body>
</html>
