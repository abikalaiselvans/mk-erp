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
		checkNullSelect("bankid","Select Bank ","0")
		&& checkNull("branch","Enter Branch Name")
		&& checkNull("branchcode","Enter Branch Code")
		&& checkNull("phone","Enter Phone number")
		&& chkemail('email')
		&& checkNull("swiftcode","Enter SwiftCode")
		
		 
	   )
		return true;
	else
		return false
}
 
</script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="document.getElementById('branch').focus()" >
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
                  <td width="412"><table cellspacing="2" cellpadding="2" width="100%" align="center"
						border="0">
                      <!--DWLayoutTable-->
                      <tbody>
                        <tr>
                          <td height="16" colspan="3" align="center" valign="top" 	class="boldThirteen">Bank Branch 
                            <%
							String action=request.getParameter("action1");
							String branchid="",bankid="",bankbranchid="",branch="",branchcode="",add1="",add2="",city="",State="",pincode="",phone="",fax="",email="",website="",swiftcode="", actionS="",value="";
							String sql="";
							if("Add".equals(action))
							{
								bankid="";bankbranchid="";branch="";branchcode="";add1="";add2="";city="";State="";
								pincode="";phone="";fax="";email="";website="";swiftcode="";
								actionS="STKBankBranchAdd";
								value="Add";
							}
							else
							{
								bankid="";bankbranchid="";branch="";branchcode="";add1="";add2="";city="";State="";
								pincode="";phone="";fax="";email="";website="";swiftcode="";
								bankbranchid=request.getParameter("BankBranchid");
								sql = " SELECT INT_BANKBRANCHID,INT_BANKID,CHR_BRANCH,CHR_BRANCHCODE,CHR_ADDRESS1,CHR_ADDRESS2,CHR_CITY,CHR_STATE,CHR_PINCODE,CHR_PHONENO,CHR_FAX,CHR_EMAIL,CHR_WEBSITE,CHR_SWIFTCODE FROM con_inv_m_bankbranchname WHERE INT_BANKBRANCHID="+bankbranchid;
								String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								branchid=data[0][0];bankid=data[0][1];branch=data[0][2];branchcode=data[0][3];
								add1=data[0][4];add2=data[0][5];city=data[0][6];State=data[0][7];
								pincode=data[0][8];phone=data[0][9];fax=data[0][10];email=data[0][11];
								website=data[0][12];swiftcode=data[0][13];
								actionS="STKBankBranchEdit";
								value="Update";
							}
						%>			
						<input	name="bankbranchid" type="HIDDEN" id="bankbranchid" value="<%=bankbranchid%>">
                        <input type="hidden" name="filename" value="BankBranch" />
                        <input type="hidden" name="actionS" value="<%=actionS%>" /></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">Bank Name </td>
                          <td colspan="2" align="left">
						  <select name="bankid" id="bankid" class="formText135" >
                            <option value="0">Select</option>
							<%
						  	String ss="SELECT INT_BANKID,CHR_BANKNAME,CHR_SHORTNAME FROM con_inv_m_bankname  ORDER BY CHR_BANKNAME";
							String bankdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(ss);
							for(int y=0;y<bankdata.length;y++)
								out.println("<option value='"+bankdata[y][0]+"'>"+bankdata[y][1]+"</option>");
						  %>
                          </select>
						  <%
						  if(!"Add".equals(action))
						  {
						  %>
						  <script language="javascript">setOptionValue('bankid','<%=bankid%>')</script>
						  <%
						  }
						  %>					  </td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">Branch Name  <font
									color="ff0000">*</font></td>
                          <td colspan="2" align="left"><input name="branch" type="text" class="formText135" id="branch" value="<%=branch%>" size="30" maxlength="50" onKeyUp="upperMe(this)"></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">Branch Code  <font
									color="ff0000">*</font></td>
                          <td colspan="2" align="left"><input name="branchcode" type="text" class="formText135" id="branchcode" value="<%=branchcode%>" size="30" maxlength="50" onKeyUp="upperMe(this)"></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">Address1</td>
                          <td colspan="2" align="left"><input name="add1" type="text" class="formText135" id="add1" value="<%=add1%>" size="30" maxlength="50" onKeyUp="upperMe(this)"></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">Address2</td>
                          <td colspan="2" align="left"><input name="add2" type="text" class="formText135" id="add2" value="<%=add2%>" size="30" maxlength="50" onKeyUp="upperMe(this)"></td>
                        </tr>
                        <tr>
                          <td width="89" height="17" class="boldEleven">City</td>
                          <td width="180" colspan="2" align="left"><input name="city" type="text" class="formText135" id="city" value="<%=city%>" size="30" maxlength="50" onKeyUp="upperMe(this)"></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven" valign="top">State</td>
                          <td colspan="2" align="left" valign="top"><input name="State" type="text" class="formText135" id="State" value="<%=State%>" size="30" maxlength="50" onKeyUp="upperMe(this)"></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven" valign="top">Pincode</td>
                          <td colspan="2" align="left" valign="top"><input name="pincode" type="text" class="formText135" id="pincode" value="<%=pincode%>" size="30" maxlength="50" onKeyPress="numericValue('pincode','6')"></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven" valign="top">Phone                             <font
									color="ff0000">*</font></td>
                          <td colspan="2" align="left" valign="top"><input name="phone" type="text" class="formText135" id="phone" value="<%=phone%>" size="30" maxlength="50"  onKeyUp="upperMe(this)"></td>
                        </tr>
                        <tr>
                          <td class="boldEleven" valign="top">Fax</td>
                          <td colspan="2" align="left" valign="top"><span class="boldEleven">
                            <input name="fax" type="text" class="formText135" id="fax" value="<%=fax%>" size="30" maxlength="6"  onKeyUp="upperMe(this)">
                          </span></td>
                        </tr>
                         
                        <tr>
                          <td height="17" class="boldEleven" valign="top">E-mail <font
									color="ff0000">*</font></td>
                          <td colspan="2" align="left" valign="top"><input name="email" type="text" class="formText135" id="email" value="<%=email%>" size="30" maxlength="50" ></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven" valign="top">Website</td>
                          <td colspan="2" align="left" valign="top"><input name="website" type="text" class="formText135" id="website" value="<%=website%>" size="30" maxlength="50"></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven" valign="top">Swift code  <font
									color="ff0000">*</font></td>
                          <td colspan="2" align="left" valign="top"><h5>
                            <input name="swiftcode" type="text" class="formText135" id="swiftcode" value="<%=swiftcode%>" size="30" maxlength="50"  onKeyUp="upperMe(this)">
                          </h5></td>
                        </tr>
                        
                         
                         
                        <tr>
                          <td height="17" colspan="3" valign="top" class="boldEleven"><table width="131" border="0" align="center">
                              <tr>
                                <td width="54">
<input name="Submit" type="submit"	id="submit" class="buttonbold13" value="<%=value%>" ></td>
                                <td width="67"><div align="center">
                                  <input name="button" type="button" class="buttonbold13"  value="Close"   accesskey="c"  onClick="redirect('BankBranchview.jsp')">
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
