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
		checkNull("bank","Enter Bank") && checkNull("shortname","Enter Short Name")
		 
		 
	   )
		return true;
	else
		return false
}
 
</script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="document.getElementById('bank').focus()" >
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
                          <td height="16" colspan="3" align="center" valign="top" 	class="boldThirteen">Bank
                            <%
							String action=request.getParameter("action1");
							String bankid="",bankname="",shortname="", actionS="",value="";
							String sql="";
							if("Add".equals(action))
							{
								bankid="";bankname=""; shortname="";
								actionS="STKBankAdd";
								value="Add";
							}
							else
							{
								bankid="";bankname=""; shortname="";
								bankid=request.getParameter("Bankid");
								sql = "SELECT INT_BANKID,CHR_BANKNAME,CHR_SHORTNAME FROM con_inv_m_bankname WHERE INT_BANKID="+bankid;
								String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								bankid=data[0][0];bankname=data[0][1]; shortname=data[0][2];
								actionS="STKBankEdit";
								value="Update";
							}
						%>			
						<input	name="bankid" type="HIDDEN" id="bankid" value="<%=bankid%>">
                        <input type="hidden" name="filename" value="Bank" />
                        <input type="hidden" name="actionS" value="<%=actionS%>" /></td>
                        </tr>
                        <tr>
                          <td width="171" height="17" class="boldEleven">Bank <font
									color="ff0000">*</font></td>
                          <td width="203" colspan="2" align="left"><input name="bank" type="text" class="formText135" id="bank" value="<%=bankname%>" size="20" maxlength="45" onKeyUp="upperMe(this),CheckUnique(this,'divunitname','con_inv_m_bankname','CHR_BANKNAME')" onBlur="upperMe(this), CheckUnique(this,'divunitname','con_inv_m_bankname','CHR_BANKNAME')">
                            <div id='divunitname'></div></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven" valign="top">Short Name </td>
                          <td colspan="2" align="left" valign="top"><input name="shortname" type="text" class="formText135" id="shortname" value="<%=shortname%>" size="20" maxlength="10" onKeyUp="upperMe(this),CheckUnique(this,'divunitnames','con_inv_m_bankname','CHR_SHORTNAME')" onBlur="upperMe(this), CheckUnique(this,'divunitnames','con_inv_m_bankname','CHR_SHORTNAME')"><div id='divunitnames'></div></td>
                        </tr>
                         
                         
                        <tr>
                          <td height="17" colspan="3" valign="top" class="boldEleven"><table width="131" border="0" align="center">
                              <tr>
                                <td width="54">
<input name="Submit" type="submit"	id="submit" class="buttonbold13" value="<%=value%>" ></td>
                                <td width="67"><div align="center">
                                  <input name="button" type="button" class="buttonbold13"  value="Close"   accesskey="c"  onClick="redirect('Bankview.jsp')">
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
