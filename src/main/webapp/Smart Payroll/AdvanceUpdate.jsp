<%@ page import="java.io.*,java.util.*,com.my.org.erp.common.*"%>
<%@page import="com.my.org.erp.bean.Attendance.*"%>
<%@page import="com.my.org.erp.bean.payroll.*"%>
<%@page import="com.my.org.erp.SmartPayroll.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>

<%@page import="com.my.org.erp.ServiceLogin.DateUtil"%>
<html>
<head>
<title>:: PAYROLL ::</title>
 
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<script language="javascript">
function Validate()
{
   
    if(
	checkNull("Amount","Enter Amount") 
	
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
.style3 {COLOR: #000000; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;}
-->
</style>
</head>

<body  onpaste="return false;"  >
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="advance" method="post" action="../SmartLoginAuth" onSubmit=" return Validate()">
<table width="100%" border="0" align="center" cellpadding="2"
	cellspacing="2">
	<tr>
		<td></td>
	</tr>

	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
	  <td height="54"><table class="BackGround" cellspacing="0" cellpadding="0" width="300"
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
            <td width="412"><table width="300" height="124" border="0" align="center"
						  class="bolddeepblue">
                <!--DWLayoutTable-->
                <tr align="center" valign="middle">
                  <td width="390" height="28" colspan="3" align="center"
								valign="middle" class="boldgre"><div align="center">Advance Update </div></td>
                </tr>
                <tr align="center" valign="middle">
                  <td height="29" colspan="3" valign="middle" class="BackGround"
								 > 
                    <%
							String id = request.getParameter("id");
							String sql = "SELECT a.INT_ID,b.CHR_STAFFNAME,a.CHR_EMPID,a.CHR_MONTH, a.INT_YEAR,a.INT_DUEAMT,a.CHR_TYPE FROM  pay_t_advance a ,com_m_staff b  WHERE a.CHR_EMPID = b.CHR_EMPID AND a.INT_ID="+id;
							
String data[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
							%>
                    &nbsp;</td>
                </tr>
                <tr>
                  <td height="28" valign="middle" class="bolddeepblue"><table width="100%" border="0" align="center" cellpadding="2" cellspacing="1">
                    <tr>
                      <td width="94" class="boldEleven">Emp name </td>
                      <td width="189" class="bold1"><%=data[0][1]%></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Emp Id </td>
                      <td class="bold1"><%=data[0][2]%></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Month</td>
                      <td class="bold1"><%=data[0][3]%></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Year</td>
                      <td class="bold1"><%=data[0][4]%></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Amount</td>
                      <td class="bold1">
                        <input name="Amount" type="text" class="formText135" id="Amount"   onKeyPress="return numeric_only(event,'Amount','9')"   maxlength="6" value="<%=data[0][5]%>" style="text-align:right"></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Deduction Type </td>
                      <td class="bold1">
					  <%
					  if("Y".equals(data[0][6]))
					  	out.println("Salary Deduction");
					  else	
					  	out.println("Cash Return ");
					  %>
					  <input name="rowid" type="hidden" id="rowid" value="<%=id%>">
					  <input name="type" type="hidden" id="type" value="<%=data[0][6]%>">
					  <input name="empid" type="hidden" id="empid" value="<%=data[0][2]%>">
					  <input name="month" type="hidden" id="month" value="<%=data[0][3]%>">
					  <input name="year" type="hidden" id="year" value="<%=data[0][4]%>">
					  <input name="filename" type="hidden"
								id="filename" value="EmpAdvance" />
                      <input name="actionS"
								type="hidden" id="actionS" value="PAYSalaryDeductuinModify" /></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven">&nbsp;</td>
                    </tr>
                  </table></td>
                </tr>
                <tr>
                  <td height="29" valign="middle" class="bolddeepblue"><table border="0" align="center" cellpadding="3" cellspacing="3">
                      <tr>
                        <td width="56"><input name="Submit2" type="submit" class="buttonbold14" value="Update"></td>
                        <td width="56"><input name="Button" type="Button" class="buttonbold14"  value="Close"   accesskey="c"  onClick="redirect('Payrollmain.jsp')"></td>
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
		<td height="54">&nbsp;
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