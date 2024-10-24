<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<head>
 
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
 
 
<title> :: PAYROLL ::</title>


 
 
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
@import url("../JavaScript/SmartStyles.css");
.style8 {font-family: Verdana;
	font-size: 12px;
}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >

<%@ include file="index.jsp"%>
<!--PaySlipView.jsp-->
<form action="SalaryOfficeWiseResponse.jsp" method="post"   name="frm"  AUTOCOMPLETE = "off"  >

<table width="100%" height="285" border="0" align="center"
	cellpadding="0" cellspacing="0">
	<tr>
		<td height="31">&nbsp;</td>
	</tr>
	<tr>
		<td height="198">
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

					  <table width="100%" border="0" cellspacing="2" cellpadding="2">
                        <tr>
                          <td colspan="4">&nbsp;</td>
                        </tr>
                        <tr>
                          <td colspan="4"><div align="center">OFFICE WISE SALARY </div></td>
                        </tr>
                        <tr>
                          <td>&nbsp;</td>
                          <td>Office</td>
                          <td>
						  <select name="division" class="formText135" id="division">
                          <option value="0">All</option>
						  <%
						  String division[][] =  CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
						  %>
						  </select>                          </td>
                          <td>&nbsp;</td>
                        </tr>
                        <tr>
                          <td>&nbsp;</td>
                          <td>Financial Year </td>
                          <td><select name="year" class="formText135" id="year" >
                            <jsp:include page="../JavaScript/accountyears.jsp" flush="true" />                          
</select><script language='JavaScript' type="text/javascript">
<!--			
	var d=new Date();
	var month1=parseInt(d.getMonth() + 1);
	var year1=parseInt(d.getFullYear());
	var m="";
	if(month1<4)
	year1 = year1-1;
	if(month1<10) 
		m="0"+month1;
	setOptionValue('year',year1);					
//-->
  </script></td>
                          <td>&nbsp;</td>
                        </tr>
                        <tr>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                        </tr>
                        <tr>
                          <td colspan="4"><table border="0" align="center" cellpadding="0" cellspacing="3">
                            <tr>
                              <td width="56"><input class="buttonbold14" type="submit"
										name="Submit2" value="Submit"   accesskey="s"    /></td>
                              <td width="56"><input class="buttonbold14" type="button"
										name="Submit"  value="Close"   accesskey="c" 
										onclick="redirect('PayRollConsolidation.jsp')" /></td>
                            </tr>
                          </table></td>
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
					<td colspan="2" rowspan="2"><img height="7"
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
		<td height="19"></td>
	</tr>
	<tr>
		<td height="37">&nbsp;</td>
	</tr>
</table>
</form>

<%@ include file="../footer.jsp"%>
</body>
</html>
