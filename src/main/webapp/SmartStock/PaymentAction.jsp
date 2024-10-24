<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<html>
<head>
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='STK' ")[0][0]%></title></title>
 
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

</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="javascript" >
function validate()
{
	if( 
		checkNull("paymentname","Enter paymentname")
		&& checkNull("description","Enter Description")
		 
	   )
		return true;
	else
		return false
}
 
</script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="document.getElementById('paymentname').focus()" >
<%
try
{
%>
<%@ include file="indexstock.jsp"%>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<!--DWLayoutTable-->
	<tr>
		<td height="19">&nbsp;</td>
	</tr>
	<tr>
	  <td height="19">&nbsp;</td>
  </tr>

	<tr>
	  <td height="19"><form AUTOCOMPLETE="off" method="post" name="frm" id="frm" action="../SmartLoginAuth" onSubmit="return validate()">
	    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td><table class="BackGround" cellspacing="0" cellpadding="0" width="424"
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
                  <td width="412"><table cellspacing="2" cellpadding="2" width="388" align="center"
						border="0">
                      <!--DWLayoutTable-->
                      <tbody>
                        <tr>
                          <td height="16" colspan="3" align="center" valign="top" 	class="boldThirteen">Payment
                            <%
							String action=request.getParameter("action1");
							String paymentid="",paymentname="",description="", actionS="",value="";
							String sql="";
							if("Add".equals(action))
							{
								paymentid="";paymentname="";description=""; 
								actionS="STKPaymentAdd";
								value="Add";
							}
							else
							{
								paymentid="";paymentname="";description=""; 
								paymentid=request.getParameter("Paymentid");
								sql = " SELECT INT_PAYMENTMODEID,CHR_PAYMENTNAME,CHR_DES  FROM con_inv_m_paymentmode WHERE INT_PAYMENTMODEID="+paymentid;
								String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								paymentid=data[0][0];paymentname=data[0][1];description=data[0][2]; 
								actionS="STKPaymentEdit";
								value="Update";
							}
						%>			
						<input	name="paymentid" type="HIDDEN" id="paymentid" value="<%=paymentid%>">
                        <input type="hidden" name="filename" value="Payment" />
                        <input type="hidden" name="actionS" value="<%=actionS%>" /></td>
                        </tr>
                        <tr>
                          <td width="171" height="17" class="boldEleven">Payment <font
									color="ff0000">*</font></td>
                          <td width="203" colspan="2" align="left"><input name="paymentname" type="text" class="formText135" id="paymentname" value="<%=paymentname%>" size="20" maxlength="45" onKeyUp="upperMe(this),CheckUnique(this,'divunitname','con_inv_m_paymentmode','CHR_PAYMENTNAME')" onBlur="upperMe(this), CheckUnique(this,'divunitname','con_inv_m_paymentmode','CHR_PAYMENTNAME')">
                            <div id='divunitname'></div></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven" valign="top">Description   <font
									color="ff0000">*</font></td>
                          <td colspan="2" align="left" valign="top"><textarea name="description" cols="30" rows="5" class="formText135" id="description" onKeyUp="textArea('description','220')"  ><%=description%></textarea>
                            <div id='divshortname'></div></td>
                        </tr>
                         
                         
                        <tr>
                          <td height="17" colspan="3" valign="top" class="boldEleven"><table width="131" border="0" align="center">
                              <tr>
                                <td width="54">
<input name="Submit" type="submit"	id="submit" class="buttonbold13" value="<%=value%>" ></td>
                                <td width="67"><div align="center">
                                  <input name="button" type="button" class="buttonbold13"  value="Close"   accesskey="c"  onClick="redirect('Paymentview.jsp')">
                                </div></td>
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
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp; </td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
        </table>
	  </form>	  </td>
	   
	  
	  	  </td>
  </tr>
	<tr>
	  <td height="19">&nbsp;</td>
  </tr>
	
	
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
<%
}
catch(Exception e)
{
}
%>
</body>
</html>
