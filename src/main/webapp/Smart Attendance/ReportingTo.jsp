<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
 <%
try
{
%>

<title> :: ATTENDANCE ::</title>



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
.style3 {color: #000000}
-->
</style>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
function Validate()
{
	if(checkNullSelect("repto","Select Staff","0"))
		return true;
	else
		return false;
}
</script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 <body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
 <%@ include file="index.jsp"%>
<form name="frm" method="post" action="ReportingToResponse.jsp" autocomplete='off' onSubmit="return Validate()">
<table width="100%" height="401" align="center">
	<tr>
	  <td height="74" align="center">&nbsp;</td>
    </tr>
	<tr>
		<td height="151" align="center"><table class="BackGround" cellspacing="0" cellpadding="0" width="310"
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
              <td width="412"><table width="310" border="0" align="center" cellpadding="2"
						cellspacing="2"  >
                  <!--DWLayoutTable-->
                  <tr align="center">
                    <td height="25" colspan="2" valign="top" class="BackGround"
								 >REPORTING TO </td>
                  </tr>
                  <tr>
                    <td width="108" height="30" align="left" valign="middle" class="boldEleven">Reporting Head  </td>
                    <td width="188" align="left" valign="middle" class="boldEleven"> 
                         
								<select name="repto" class="formText135" id="repto">
                                  <option value="0">Select</option>
                                  <%
	String sql=" SELECT CHR_EMPID,CHR_STAFFNAME   FROM com_m_staff  WHERE  CHR_REP='Y' AND  CHR_TYPE<>'T' AND CHR_HOLD<>'Y'    ORDER BY CHR_STAFFNAME ";
	//select CHR_EMPID,CHR_STAFFNAME from com_m_staff WHERE CHR_TYPE<>'T' AND CHR_REP='Y'
	 String Data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	for(int u=0;u<Data.length;u++)
		out.println("<option value='"+Data[u][0]+"'>"+Data[u][1]  +" </option>");
%>
                                </select>
</span></td>
                  </tr>
                  <tr>
                    <td height="30" colspan="2" align="left" valign="middle"
								class="bolddeepblue"><table border="0" align="center" cellpadding="3" cellspacing="3">
                        <tr>
                          <td width="56"><input name="Submit" type="submit"
										class="buttonbold" value=" Submit "></td>
                          <td width="56"><input class="buttonbold" type="Button"
										name="Submit2"  value="Close"   accesskey="c" 
										onClick="javascript:window.close()"></td>
                        </tr>
                    </table></td>
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
        </table></td>
	</tr>
	<tr>
		<td height="17">&nbsp;  </td>
	</tr>
	<tr>
		<td height="17" align="center">
	<tr>
		<td height="20"></td>
	</tr>
</table>
</form>
<%@ include file="../footer.jsp"%>
</body>
<%
}
catch(Exception e)
{
}
%>
