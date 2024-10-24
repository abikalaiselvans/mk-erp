    <%@ page import="java.sql.*,java.util.*,java.io.*"%>
 <%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<html>
<head>
<title>:: MANAGEMENT ::</title> 
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id,payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
  
$(function() {
		$( "#incomedate" ).datepicker({
			changeMonth: true,
			changeYear: true,
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true,
			minDate: "-10D", maxDate: "+0D"
		});
	}); 
	

 

	</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">



<script language="JavaScript">

function Validate()
  {
	
   
	if(  checkNullSelect( "branch","Select Branch", "" ) 
		 && checkNullSelect( "category","Select category", "" ) 	
	     &&  checkNull( "incomedate","Enter The Date" )
		 &&  checkNull( "income","Enter The Amount" )
		 &&  checkNull( "desc","Enter The description" )
		  )
		return true;
		 
	else  		
		return false;				
		
	
 } 	
 
  

</script>
<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
<%@ include file="index.jsp"%>
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
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
	 <form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return Validate()">
	<table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
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
          <td width="412" valign="top">
		 
		    <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3">
              <tr>
                <td colspan="2" class="bold1"><div align="center"><span class="boldThirteen">PETTY CASH REPORTS</span>
                    			
                  
                </div></td>
                </tr>
              <tr>
                <td class="boldEleven">1. </td>
                <td class="boldEleven"><a href="Rept_Pettycashtypes.jsp" target="_blank">Type</a></td>
              </tr>
              <tr>
                <td class="boldEleven">2. </td>
                <td class="boldEleven"><a href="Rept_PettycashIncomes.jsp" target="_blank">INCOME / RECEIPTS</a></td>
              </tr>
              <tr>
                <td width="9%" class="boldEleven"> <span class="boldred"></span> 3.</td>
                <td width="91%" class="boldEleven"> 
                 
                <script language="javascript">setCurrentDate('incomedate')</script>
                <a href="Rept_PettycashExpensesBefore.jsp" target="_blank">EXPENSES / PAYMENTS </a></td>
              </tr>
               
              <tr>
                <td align="left" valign="top" class="boldEleven">4. </td>
                <td align="left" valign="top" class="boldEleven"><a href="Rept_PettyCashBalanceSheet.jsp" target="_blank">Analysis report </a></td>
              </tr>
              <tr>
                <td align="left" valign="top" class="boldEleven">5. </td>
                <td align="left" valign="top" class="boldEleven"><a href="Rept_PettyCashBalanceSheetDetail.jsp" target="_blank">Analysis Detailed report   
                
                </a></td>
              </tr>
              <tr>
                <td class="boldEleven">6.</td>
                <td class="boldEleven"><a href="Rept_PettyCashBalanceSheetProfit.jsp" target="_blank">Abstract
				</a></td>
              </tr>
              
              <tr>
                <td class="boldEleven">7.</td>
                <td class="boldEleven"><a href="Rept_Tally_PettyCashReceipts.jsp">Tally Export Receipts </a></td>
              </tr>
              <tr>
                <td class="boldEleven">8.</td>
                <td class="boldEleven"><a href="Rept_Tally_PettyCashExpenses.jsp">Tally Export Payments </a></td>
              </tr>
              <tr>
                <td colspan="2" class="boldEleven"><table width="60" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                     <td><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('ManagementMain.jsp')"></td>
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
    </table> </form></td>
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
<%@ include file="../footer.jsp"%>

 <%	
 
}
catch(Exception e)
{
	System.out.println(e.getMessage());
}
%>
</body>
</html>
