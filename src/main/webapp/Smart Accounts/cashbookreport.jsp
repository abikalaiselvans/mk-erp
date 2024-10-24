<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<html>
<head>

<title>:: ACCOUNTS ::</title>

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
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"	 >
<script language="javascript" src="../JavaScript/comfunction.js"></script>

<%@ include file="indexacct.jsp"%>
<table width="1000" border="0" cellpadding="0" cellspacing="0">
	<!--DWLayoutTable-->
	<tr>
		<td height="19">&nbsp;</td>
	</tr>
	<tr>
	  <td height="19">&nbsp;</td>
  </tr>
	<tr>
	  <td height="19"> <table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
			align="center" border="0">
        <tbody>
          <tr>
            <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
            <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
            <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
          </tr>
          <tr>
            <td height="6"><spacer height="1" width="1" type="block" /></td>
          </tr>
          <tr>
            <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
            <td width="6"><spacer height="1" width="1" type="block" /></td>
            <td width="412" valign="top"><form  AUTOCOMPLETE = "off"   action="IncomeandExpense.jsp" method="post" name="frm" id="frm"  >
                <table width="229"   border="0" align="center" cellpadding="3" cellspacing="3">
                  <tr>
                    <td   colspan="2" class="bold1"><div align="center">CASH   </div></td>
                  </tr>

                  <tr>
                    <td colspan="2" class="boldEleven">Cash as on Balance :: <b></b></td>
                  </tr>
                  <tr>
                    <td colspan="2" class="boldEleven"><div align="center"><a href="cashbookdate.jsp">Date wise </a></div></td>
                  </tr>
                  <tr>
                    <td colspan="2" class="boldEleven"><div align="center"><a href="cashbookyear.jsp">Year Wise</a></div></td>
                  </tr>
                  <tr>
                    <td class="boldEleven">&nbsp;</td>
                    <td class="boldEleven">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                        <tr>
                          <td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('AccountsMain.jsp')"></td>
                        </tr>
                    </table></td>
                  </tr>
                </table>
            </form></td>
            <td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
            <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
          </tr>
          <tr>
            <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
            <td height="6"><spacer height="1" width="1" type="block" /></td>
            <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></td>
          </tr>
          <tr>
            <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
          </tr>
        </tbody>
      </table></td>
  </tr>
	<tr>
	  <td height="19">&nbsp;</td>
  </tr>
	<tr>
	  <td height="19">&nbsp;</td>
  </tr>
	<tr>
	  <td height="19">&nbsp;</td>
  </tr>
	<tr>
		<td height="19">&nbsp;</td>
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</body>
</html>
