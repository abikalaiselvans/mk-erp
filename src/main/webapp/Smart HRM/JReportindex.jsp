<%@ page import="java.io.*,java.util.*" %>
<%@page import="com.my.org.erp.common.CommonInfo"%>
<html>
<head>

<title>:: HRM ::</title>


<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
 
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.style2 {color: #CC00CC}
-->
</style>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
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
<form  AUTOCOMPLETE = "off" action="JobDesignReportView.jsp" name="report" method="post" >
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="1001"><%@ include file="indexhrm.jsp"%>	</td>
  </tr>
  <tr>
    <td height="19">&nbsp;</td>
  </tr>
  <tr>
    <td height="19">&nbsp;</td>
  </tr>
  <tr>
    <td height="229" align="center"><TABLE width=440 border=0 align=center cellPadding=0 cellSpacing=0 bgcolor="#dce4f9" class=BackGround>
      <TBODY>
        <TR>
          <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/TLCorner.gif" width=7></TD>
          <TD class=BorderLine height=1><SPACER height="1" width="1" type="block" /></TD>
          <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/TRCorner.gif" width=7></TD>
        </TR>
        <TR>
          <TD height=6><SPACER height="1" width="1" type="block"/></TD>
        </TR>
        <TR>
          <TD class=BorderLine width=1><SPACER height="1" 
                        width="1" type="block" /></TD>
          <TD width=6><SPACER height="1" width="1" type="block" 
                      /></TD>
          <TD width=425 valign="top"><table width="100%" border="0" cellspacing="4" cellpadding="4">
            <tr>
              <td colspan="6" align="center">REPORTS</td>
              </tr>
            <tr>
              <td><span class="boldEleven">1.</span></td>
              <td><span class="boldEleven"><a href="JRept_jobDesign.jsp" target="_blank">Job Design</a></span></td>
              <td><span class="boldEleven">6.</span></td>
              <td><span class="boldEleven"><a href="../hrmCon?pageAction=jobSpecification" target="_blank">Job Specification</a></span></td>
              <td><span class="boldEleven">11.</span></td>
              <td><span class="boldEleven"><a href="../hrmCon?pageAction=jobDescription" target="_blank">Job Description</a></span></td>
              </tr>
            <tr>
              <td><span class="boldEleven">2.</span></td>
              <td><span class="boldEleven"><a href="../hrmCon?pageAction=generalSkills" target="_blank">General Skills</a></span></td>
              <td><span class="boldEleven">7.</span></td>
              <td><span class="boldEleven"><a href="../hrmCon?pageAction=TechnicalSkills" target="_blank">Technical Skills</a></span></td>
              <td><span class="boldEleven">12.</span></td>
              <td><span class="boldEleven"><a href="../hrmCon?pageAction=TestType" target="_blank">Test Type</a></span></td>
              </tr>
            <tr>
              <td><span class="boldEleven">3.</span></td>
              <td><span class="boldEleven"><a href="JRept_FResult.jsp" target="_blank">Final Result</a></span></td>
              <td><span class="boldEleven">8.</span></td>
              <td><span class="boldEleven"><a href="JRept_question.jsp" target="_blank">Questions</a></span></td>
              <td><span class="boldEleven">13.</span></td>
              <td><span class="boldEleven"><a href="JRept_jobdemand.jsp" target="_blank">Demand Report</a></span></td>
              </tr>
            <tr>
              <td><span class="boldEleven">4.</span></td>
              <td><span class="boldEleven"><a href="JRept_jobApplication1.jsp" target="_blank">Application Report</a></span></td>
              <td><span class="boldEleven">9.</span></td>
              <td><span class="boldEleven"><a href="JRept_onlineTestView.jsp" target="_blank">Online Test Result</a></span></td>
              <td class="boldEleven">14.</td>
              <td class="boldEleven"><a href="JRept_offerletter.jsp" target="_blank">Offer Letter</a></td>
            </tr>
            <tr class="boldEleven">
              <td class="boldEleven">5</td>
              <td class="boldEleven"><a href="JRept_firstinterview.jsp" target="_blank">First Interview</a></td>
              <td class="boldEleven">10.</td>
              <td class="boldEleven"><a href="JRept_secondinterview.jsp" target="_blank">Second Interview</a></td>
              <td class="boldEleven">&nbsp;</td>
              <td class="boldEleven">&nbsp;</td>
            </tr>
            <tr>
              <td colspan="6"><table width="56" border="0" align="center" cellpadding="1"
									cellspacing="1">
                <tr>
                  <td><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('HRMmain.jsp')"></td>
                </tr>
              </table></td>
              </tr>
          </table></TD>
          <TD noWrap width=7><SPACER height="1" width="1" 
                        type="block" /></TD>
          <TD class=BorderLine width=1><SPACER height="1" width="1" type="block" /></TD>
        </TR>
        <TR>
          <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/BLCorner.gif" width=7></TD>
          <TD height=6><SPACER height="1" width="1" type="block"/></TD>
          <TD colSpan=2 rowSpan=2 valign="bottom"><div align="right"><IMG height=7 src="../Image/General/BRCorner.gif" width=7></div></TD>
        </TR>
        <TR>
          <TD class=BorderLine height=1><SPACER height="1" width="1" type="block" /></TD>
        </TR>
      </TBODY>
    </TABLE></td>
  </tr>
  <tr>
    <td height="19">&nbsp;</td>
  </tr>
  <tr>
    <td height="19">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>

<tr><td><%@ include file="../footer.jsp"%></td></tr>
</table>
</form>
</body>
</html>
