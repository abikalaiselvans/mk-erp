<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>

<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
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

<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
function validate()
{
	if(
		checkNull('ename','Select Staff name') 
		&& checkNull('April','Enter April month target') 
		&& checkNull('May','Enter May month target') 
		&& checkNull('June','Enter June month target') 
		&& checkNull('July','Enter July month target') 
		&& checkNull('August','Enter August month target') 
		&& checkNull('September','Enter September month target') 
		&& checkNull('October','Enter October month target') 
		&& checkNull('November','Enter November month target') 
		&& checkNull('December','Enter December month target') 
		&& checkNull('January','Enter January month target') 
		&& checkNull('February','Enter February month target') 
		&& checkNull('March','Enter March month target') 
	
	)
		return true;
	else
		return false;
		

}
</script>
<body    onLoad="init()">
<%@ include file="indexinv.jsp"%>

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
    <td><form  AUTOCOMPLETE = "off"   name="form1" method="post" action="../SmartLoginAuth" onSubmit=" return validate()">
    
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
            <td width="412"><table cellspacing="2" cellpadding="2" width="184" align="center"
						border="0">
                <!--DWLayoutTable-->
                <tbody>
                  <tr>
                    <td height="16" align="center" valign="top"
									class="boldThirteen"><%@ include file="../JavaScript/ajax.jsp"%></td>
                  </tr>
                  <tr>
                    <td height="17" class="boldEleven"><table width="153" border="0" align="center" cellpadding="5" cellspacing="0">
                        <tr>
                          <td class="boldEleven">Year</td>
                          <td class="boldEleven"> 
						  
<select name="year" id="year"  onChange="loadTargetAssign('0')">
	<jsp:include page="../JavaScript/accountyears.jsp" flush="true" />
</select>

<script language='JavaScript' type="text/javascript">
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
</script>


</td>
                        </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td height="17" class="boldEleven"><table width="100" border="0" cellspacing="0" cellpadding="5">
                        <tr>
                          <td class="boldEleven">April</td>
                          <td class="boldEleven">May</td>
                          <td class="boldEleven">June</td>
                          <td class="boldEleven">July</td>
                          <td class="boldEleven">August</td>
                          <td class="boldEleven">September</td>
                          <td class="boldEleven">October</td>
                          <td class="boldEleven">November</td>
                          <td class="boldEleven">December</td>
                          <td class="boldEleven">January</td>
                          <td class="boldEleven">February</td>
                          <td class="boldEleven">March</td>
                        </tr>
                        <tr>
                          <td class="boldEleven"><input name="April" type="text" class="formText135" id="April"  onKeyPress="return numeric_only(event,'April','6')"  size="6" maxlength="3" style='text-align:right'></td>
                          <td class="boldEleven"><input name="May" type="text" class="formText135" id="May"    onKeyPress="return numeric_only(event,'May','6')" size="6" maxlength="3"  style='text-align:right'></td>
                          <td class="boldEleven"><input name="June" type="text" class="formText135" id="June"    onKeyPress="return numeric_only(event,'June','6')" size="6"  maxlength="3" style='text-align:right'></td>
                          <td class="boldEleven"><input name="July" type="text" class="formText135" id="July"    onKeyPress="return numeric_only(event,'July','6')" size="6" maxlength="3"  style='text-align:right'></td>
                          <td class="boldEleven"><input name="August" type="text" class="formText135" id="August"    onKeyPress="return numeric_only(event,'August','6')" size="6" maxlength="3"  style='text-align:right'></td>
                          <td class="boldEleven"><input name="September" type="text" class="formText135" id="September"    onKeyPress="return numeric_only(event,'September','6')" size="6"  maxlength="3" style='text-align:right'></td>
                          <td class="boldEleven"><input name="October" type="text" class="formText135" id="October"    onKeyPress="return numeric_only(event,'October','6')" size="6"  maxlength="3" style='text-align:right'></td>
                          <td class="boldEleven"><input name="November" type="text" class="formText135" id="November"    onKeyPress="return numeric_only(event,'November','6')" size="6"  maxlength="3" style='text-align:right'></td>
                          <td class="boldEleven"><input name="December" type="text" class="formText135" id="December"    onKeyPress="return numeric_only(event,'December','6')" size="6"  maxlength="3" style='text-align:right'></td>
                          <td class="boldEleven"><input name="January" type="text" class="formText135" id="January"   onKeyPress="return numeric_only(event,'January','6')"  size="6"  maxlength="3" style='text-align:right'></td>
                          <td class="boldEleven"><input name="February" type="text" class="formText135" id="February"    onKeyPress="return numeric_only(event,'February','6')" size="6"  maxlength="3" style='text-align:right'></td>
                          <td class="boldEleven"><input name="March" type="text" class="formText135" id="March"    onKeyPress="return numeric_only(event,'March','6')" size="6"  maxlength="3" style='text-align:right'></td>
                        </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td height="17" class="boldEleven"><span class="boldred">*</span> <span class="bolddeepred">All inputs are in terms of lakhs.</span><font size="1"><strong><font
										color="#000000"><font size="1"><strong><font
										color="#000000"><font size="1">
                      <input
										type="hidden" name="filename" value="Target" />
                      <strong><font
										color="#000000"><font size="1">
                      <input
										type="hidden" name="actionS" value="INVTargetAssign" />
                      </font></font></strong></font></font></strong></font></font></strong></font></td>
                  </tr>
                  <tr>
                    <td height="17" class="boldEleven"><table border="0" align="center" cellpadding="2"
										cellspacing="2">
                      <tr>
                        <td width="56">
<input type="submit" name="Submit"	id="submit_btn" class="buttonbold" value="Submit"   accesskey="s"    /></td>
                        <td width="56">
<input type="button" name="submit" class="buttonbold"  value="Close"   accesskey="c" 	onClick="redirect('StaffTargetAssign.jsp')" /></td>
                      </tr>
                    </table></td>
                  </tr>
                </tbody>
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
      </table>
	  </form>
	  
    </td>
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
</body>
</html>
