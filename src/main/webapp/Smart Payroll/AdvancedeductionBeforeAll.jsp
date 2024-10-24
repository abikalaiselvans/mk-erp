<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" errorPage=""%>
<html>
<head>
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


<title> :: PAYROLL ::</title>


 
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 <style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
 </style>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
function validate()
{
	try
	{
		if(checkNullSelect("Month","Select Month",'0') && checkNullSelect("Year","Select Year",'0'))
		{
			return true;
		}
		else
		{
			return false;
		}    
	}
	catch(err)
	{
		alert(err);
		return false;
	}
}
</script>
<body  onpaste='return false;'>


 
<%@ include file="index.jsp"%>
 
  <%
try
{
%>
<form method="post" action="AdvancedeductionAll.jsp" onSubmit="return validate()"  >
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
	
	
	
	<table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
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
          <td width="412"><table cellspacing="2" cellpadding="2" width="388" align="center"
						border="0">
              <!--DWLayoutTable-->
              <tbody>
                <tr>
                  <td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">Advance deduction </td>
                </tr>
                <tr>
                  <td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory </span></td>
                </tr>
                
                <tr>
                  <td height="17" colspan="3" class="boldEleven"><table width="222" align="center">
                    <tr>
                      <td align="left" valign="middle"  
				class="boldEleven">Month <span class="boldred">*</span> </td>
                      <td class="boldEleven"><%@ include
				file="../JavaScript/month.jsp"%></td>
                    </tr>
                    <tr>
                      <td align="left" valign="middle"  
				class="boldEleven">Year <span class="boldred">*</span> </td>
                      <td class="boldEleven"><%@ include
				file="../JavaScript/year.jsp"%></td>
                    </tr>
                  </table></td>
                  </tr>
                
                <tr>
                  <td height="17" colspan="3" class="boldEleven"><table width="182" border="0" align="center" cellpadding="2" cellspacing="2">
                    <tr>
                      <td width="42"></td>
                      <td width="67"><input type="submit" name="Submit"
				id="submit_btn" class="tMLAscreenHead" value="Adv- Rec" />                      </td>
                      <td width="53"><input type="button" name="submit"
				class="tMLAscreenHead"  value="Close"   accesskey="c" 
				onClick="redirect('Payrollmain.jsp')" /></td>
                    </tr>
                  </table></td>
                </tr>
                <tr>
                  <td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                  <td colspan="2" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
                </tr>
              </tbody>
              <input type="hidden" name="mobileBookingOption" />
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
    <td>
	
	 </td>
  </tr>
  <tr>
    <td>	</td>
  </tr>
</table>

</form>
<%
	
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
<p>&nbsp;</p>
<%@ include file="../footer.jsp"%>
</body>
</html>
