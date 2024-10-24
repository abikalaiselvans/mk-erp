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
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="javascript" >
function validate()
{

	if( 
		checkNull("customername","Enter Customer Name")
		&& checkNull("legalname","Enter Legal Name")
		&& checkNull("street","Enter Street")
		&& checkNull("city","Enter City")
		&& checkNull("state","Enter State")
		&& checkNull("postal","Enter Postal")
		&& checkNull("mobile","Enter Mobile")
		&& checkNull("email","Enter email")
		&& chkemail('email')
		
		&& checkNullSelect("groupid","Select Customer Group ","0")
		&& checkNull("contactmobile","Enter Contact Mobile")
		&& checkNull("contactperson","Enter Contact Person")
		//&& checkNull("tin","Enter TIN Number")
		
		 
		 
	   )
		return true;
	else
		return false
}
 
</script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="document.getElementById('customername').focus()" >
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
                  <td width="412"><table cellspacing="2" cellpadding="2" width="86%" align="center"
						border="0">
                      <!--DWLayoutTable-->
                      <tbody>
                        <tr>
                          <td height="16" colspan="3" align="center" valign="top" 	class="boldThirteen">CUSTOMER 
                            <%
							String action=request.getParameter("action1");
							String branch="",customerid="",customername="",legalname="",street="",city="",state="";
							String postal="",country="",areacode="",phone="",mobile="",fax="",email="",website="";
							String active="",sincefrom="",groupid="",contactmobile="",contactperson="",tin="",actionS="",value="";

							String sql="";
							if("Add".equals(action))
							{
								branch="";customerid="";customername="";legalname="";street="";city="";state="";
								postal="";country="";areacode="";phone="";mobile="";fax="";email="";website="";
								active="";sincefrom="";groupid="";contactmobile="";contactperson="";tin="";
								actionS="STKCustomerAdd";
								value="Add";
							}
							else
							{
								branch="";customerid="";customername="";legalname="";street="";city="";state="";
								postal="";country="";areacode="";phone="";mobile="";fax="";email="";website="";
								active="";sincefrom="";groupid="";contactmobile="";contactperson="";tin="";
								customerid=request.getParameter("Customerid");
								sql = " SELECT INT_BRANCHID,INT_CUSTOMERID,CHR_CUSTOMERNAME,CHR_LEGALNAME,CHR_STREET, ";
								sql =sql+"CHR_CITY,CHR_STATE,CHR_POSTAL,CHR_COUNTRY,CHR_AREACODE,CHR_PHONE,CHR_MOBILE,CHR_FAX,";
								sql =sql+"CHR_EMAIL,CHR_WEBSITE,INT_ACTIVE,DATE_FORMAT(DAT_SINCE,'%d-%m-%Y'),INT_CUSTOMERGROUPID,";
								sql =sql+" CHR_CONTACTMOBILE, CHR_CONTACTPERSON,CHR_TIN FROM con_inv_m_customerinfo ";
								sql =sql+" WHERE INT_CUSTOMERID="+customerid;
								String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								branch=data[0][0];customerid=data[0][1];customername=data[0][2];legalname=data[0][3];
								street=data[0][4];city=data[0][5];state=data[0][6];
								postal=data[0][7];country=data[0][8];areacode=data[0][9];phone=data[0][10];
								mobile=data[0][11];fax=data[0][12];email=data[0][13];website=data[0][14];
								active=data[0][15];sincefrom=data[0][16];groupid=data[0][17];contactmobile=data[0][18];
								contactperson=data[0][19];tin=data[0][20];
								actionS="STKCustomerEdit";
								value="Update";
							}
						%>			
						<input	name="customerid" type="HIDDEN" id="customerid" value="<%=customerid%>">
                        <input type="hidden" name="filename" value="Customer" />
                        <input type="hidden" name="actionS" value="<%=actionS%>" /></td>
                        </tr>
                         
                        <tr>
                          <td height="17" colspan="3" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                          </tr>
                        <tr>
                          <td height="17" class="boldEleven">Customer  Name  <font
									color="ff0000">*</font></td>
                          <td colspan="2" align="left"><input name="customername" type="text" class="formText135" id="customername" value="<%=customername%>" size="30" maxlength="100" onKeyUp="upperMe(this)"></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">Legal Name  <font
									color="ff0000">*</font></td>
                          <td colspan="2" align="left"><input name="legalname" type="text" class="formText135" id="legalname" value="<%=legalname%>" size="30" maxlength="100" onKeyUp="upperMe(this)"></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">Street  <font
									color="ff0000">*</font></td>
                          <td colspan="2" align="left"><input name="street" type="text" class="formText135" id="street" value="<%=street%>" size="30" maxlength="100" onKeyUp="upperMe(this)"></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">City  <font
									color="ff0000">*</font></td>
                          <td colspan="2" align="left"><input name="city" type="text" class="formText135" id="city" value="<%=city%>" size="30" maxlength="100" onKeyUp="upperMe(this)"></td>
                        </tr>
                        <tr>
                          <td width="130" height="17" class="boldEleven">State <font
									color="ff0000"> <font
									color="ff0000">*</font></font></td>
                          <td width="209" colspan="2" align="left"><input name="state" type="text" class="formText135" id="state" value="<%=state%>" size="30" maxlength="50" onKeyUp="upperMe(this)"></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven" valign="top">Pincode  <font
									color="ff0000">*</font></td>
                          <td colspan="2" align="left" valign="top"><input name="postal" type="text" class="formText135" id="postal" value="<%=postal%>" size="30" maxlength="6" onKeyUp="upperMe(this)"  onKeyPress="numericValue('postal','6')"></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven" valign="top">Country  <font
									color="ff0000">&nbsp; </font></td>
                          <td colspan="2" align="left" valign="top"><input name="country" type="text" class="formText135" id="country" value="<%=country%>" size="30" maxlength="50" ></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven" valign="top">Area Code</td>
                          <td colspan="2" align="left" valign="top"><input name="areacode" type="text" class="formText135" id="areacode" value="<%=areacode%>" size="30" maxlength="10"  onKeyUp="upperMe(this)"   onKeyPress="numericValue('areacode','10')"></td>
                        </tr>
                        <tr>
                          <td class="boldEleven" valign="top">Phone</td>
                          <td colspan="2" align="left" valign="top"><span class="boldEleven">
                            <input name="phone" type="text" class="formText135" id="phone" value="<%=phone%>" size="30" maxlength="25"  onKeyUp="upperMe(this)">
                          </span></td>
                        </tr>
                         
                         
                        <tr>
                          <td height="17" class="boldEleven" valign="top">Mobile<font
									color="ff0000"> <font
									color="ff0000">*</font></font></td>
                          <td colspan="2" align="left" valign="top"><input name="mobile" type="text" class="formText135" id="mobile" value="<%=mobile%>" size="30" maxlength="25"   onKeyPress="numericValue('mobile','10')" ></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven" valign="top">Fax</td>
                          <td colspan="2" align="left" valign="top"><input name="fax" type="text" class="formText135" id="fax" value="<%=fax%>" size="30" maxlength="30"></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven" valign="top">E-mail  <font
									color="ff0000">*</font></td>
                          <td colspan="2" align="left" valign="top"><input name="email" type="text" class="formText135" id="email" value="<%=email%>" size="30" maxlength="50"></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven" valign="top">Website</td>
                          <td colspan="2" align="left" valign="top"><input name="website" type="text" class="formText135" id="website" value="<%=website%>" size="30" maxlength="100"></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven" valign="top">Active</td>
                          <td colspan="2" align="left" valign="top">
						  <select name="active" class="formText135" id="active">
						  	<option value="1">Active</option>
						  	<option value="0">Inactive</option>
                          </select>
						  <%
						  if(!"Add".equals(action))
						  {
						  %>
						  <script language="javascript">setOptionValue('active','<%=active%>')</script>
						  <%
						  }
						  
						  %>
                          </td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven" valign="top">Since</td>
                          <td colspan="2" align="left" valign="top">
						  
						  <input name="sincefrom" type="text"
									class="formText135" id="sincefrom" readonly> <a
									href="javascript:cal1.popup();"> <img
									src="../JavaScript/img/cal.gif" width="16" height="16"
									border="0" /> </a> <script language='JavaScript'>
		<!--			
				var cal1 = new calendar1(document.forms['frm'].elements['sincefrom']);
				cal1.year_scroll = true;
				cal1.time_comp = false;
				setCurrentDate('sincefrom'); 
		//-->
                    </script>
						   <%
						  if(!"Add".equals(action))
						  {
						  %>
						  <script language="javascript">document.getElementById('sincefrom').value="<%=sincefrom%>" </script>
						  <%
						  }
						  
						  %>
						   </td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven" valign="top">Customer Group   <font
									color="ff0000">*</font></td>
                          <td colspan="2" align="left" valign="top">
						  <select name="groupid"  id="groupid" class="formText135" >
						  <option value="0">Select</option>
						  <%
						  String groupsql="SELECT INT_CUSTOMERGROUPID,CHR_NAME FROM con_inv_m_customergroup ORDER BY CHR_NAME";
						  String Data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(groupsql);
						  for(int u=0;u<Data.length;u++)
								out.println("<option value='"+Data[u][0]+"'>"+Data[u][1]+"</option>");
						  %>
						  </select>
						  <%
						  if(!"Add".equals(action))
						  {
						  %>
						  <script language="javascript">setOptionValue('groupid','<%=groupid%>')</script>
						  <%
						  }
						  
						  %>
						  </td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven" valign="top">Contact Mobile   <font
									color="ff0000">*</font></td>
                          <td colspan="2" align="left" valign="top"><input name="contactmobile" type="text" class="formText135" id="contactmobile" value="<%=contactmobile%>" size="30" maxlength="50"    onKeyPress="numericValue('contactmobile','10')"></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven" valign="top">Contact Person   <font
									color="ff0000">*</font></td>
                          <td colspan="2" align="left" valign="top"><input name="contactperson" type="text" class="formText135" id="contactperson" value="<%=contactperson%>" size="30" maxlength="50"></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven" valign="top">TIN Number <font
									color="ff0000">&nbsp;</font></td>
                          <td colspan="2" align="left" valign="top"><input name="tin" type="text" class="formText135" id="tin" value="<%=tin%>" size="30" maxlength="50"></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                          <td colspan="2" align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                        </tr>
                        
                         
                         
                        <tr>
                          <td height="17" colspan="3" valign="top" class="boldEleven"><table width="131" border="0" align="center">
                              <tr>
                                <td width="54">
<input name="Submit" type="submit"	id="submit" class="buttonbold13" value="<%=value%>" ></td>
                                <td width="67"><div align="center">
                                  <input name="button" type="button" class="buttonbold13"  value="Close"   accesskey="c"  onClick="redirect('CustomerView.jsp')">
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
