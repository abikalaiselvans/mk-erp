<html>
<head>
 

<title> :: SERVICE REPORT :: </title>


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
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
 <script src="../JavaScript/common/StaffloadAjax.js"></script>
 <script language="javascript">
 function validate()
 {
 		if( checkNull('fdate','Enter the from date') && checkNull('tdate','Enter the to date') && checkNull('ename','Select the Employee name') )
			return true;
		else
			return false;
		
		
 }
 </script>
<body  onpaste="return false;" onLoad="init()">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>              <%@ include file="index.jsp"%></td>
  </tr>
  <tr>
    <td height="50">&nbsp;</td>
  </tr>
  <tr>
    <td height="480">
	
	<form action="ReportAnalysisResponse.jsp" method="post" name="frm" id="frm" onSubmit="return validate()">
	
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
          <td   valign="top">

              <table width="100%" border="0" cellspacing="4" cellpadding="3"  class="boldEleven">
                <tr>
                  <td colspan="4"><div align="center" class="copyright">DAILY REPORT </div></td>
                </tr>
                <tr>
                  <td colspan="4" align="center" valign="top"><jsp:include page="../JavaScript/ajax.jsp" flush="true" /></td>
                  </tr>
                <tr>
                  <td width="6%">&nbsp;</td>
                  <td width="24%" class="boldEleven">From Date <span class="errormessage">* </span></td>
                  <td width="64%" class="boldEleven"><input name="fdate" type="text" class="formText135" id="fdate" onKeyPress="numericHypenOnly('fdate',10)" size="12" maxlength="10"   tabindex="1">
                      <a
								href="javascript:cal1.popup();"> <img
								src="../JavaScript/img/cal.gif" width="16" height="16"
								border="0" alt="Click here to Pick Up the Date" onClick="submitenable()"  
								
		 ></a>
                      <script
								language="JavaScript">
<!--
  var cal1=new calendar1(document.forms['frm'].elements['fdate']);
  cal1.year_scroll=true;
  cal1.time_comp=false;
  setCurrentDate('fdate');
//-->

  
 
            </script>                  </td>
                  <td width="6%">&nbsp;</td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td class="boldEleven">To Date <span class="errormessage">* </span></td>
                  <td class="boldEleven"><input name="tdate" type="text" class="formText135" id="tdate" onKeyPress="numericHypenOnly('tdate',10)" size="12" maxlength="10"   tabindex="1">
                      <a
								href="javascript:cal2.popup();"> <img
								src="../JavaScript/img/cal.gif" width="16" height="16"
								border="0" alt="Click here to Pick Up the Date" onClick="submitenable()"  
								
		 ></a>
                      <script
								language="JavaScript">
<!--
  var cal2=new calendar1(document.forms['frm'].elements['tdate']);
  cal2.year_scroll=true;
  cal2.time_comp=false;
  setCurrentDate('tdate');
//-->

  
 
              </script></td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td colspan="4"> </td>
                  </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                
                <tr>
                  <td colspan="4"><table width="120" border="0" align="center" cellpadding="3" cellspacing="4">
                      <tr>
                        <td valign="top"><input type="submit" class="buttonbold13" name="add"  id="add" value="Submit"   accesskey="s"       /></td>
                        <td valign="top"><input type="button" class="buttonbold13" name="edit" id="edit"  value="Close"   accesskey="c"  onClick="redirect('ServiceReportmain.jsp')"  tabindex="16" /></td>
                      </tr>
                  </table></td>
                </tr>
              </table>
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
	
	 </form>   
	 	</td>
  </tr>
  <tr>
    <td> &nbsp;</td>
  </tr>
  <tr>
    <td><%@ include file="../footer.jsp"%></td>
  </tr>
</table>

 
</body>
</html>
