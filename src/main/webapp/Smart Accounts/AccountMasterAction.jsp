 <%@ page import="java.sql.*,java.util.*,java.io.*"%>
<html>
<head>

<title>:: ACCOUNTS ::</title>

 
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

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<%
try
{
%>
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="JavaScript">

function Validate()
  {
	if( 
	 checkNull( "name","Enter name" )
	 && checkNullSelect( "Groupname","Select Group name" ,'0')
	 && checkNull( "alias","Enter Alais name" )
	 && checkNull( "printname","Enter Print name" )
	 && checkNull( "opbalance","Enter Opening Balance" )
	 && checkNullSelect( "opbalancetype","Select Opening Balance Type" ,'0')
	 && checkNull( "prbalance","Enter Previous Balance" )
	 && checkNullSelect( "prbalancetype","Select Previous Balance Type" ,'0')
	 && checkNull( "address","Enter Address" )
	 && checkNull( "mobile","Enter Mobile" )
	 && checkNull( "contactperson","Enter Contact Person" )
	 
	)
		return true;
	else
		return false;				
		
	
 } 	
</script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<%@ include file="indexacct.jsp"%>
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
    <td><table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
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
		  <form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return Validate()">
		    <table width="500" border="0" align="center" cellpadding="3" cellspacing="3">
              <tr>
                <td colspan="2" class="bold1"><div align="center"> Account Master 
				
				    <%
							String action=request.getParameter("action1");
							String id="",Name="",actionS="",value="";
							String Groupname="",alias="",printname="",opbalance="",opbalancetype="",prbalance="",prbalancetype="";
							String address="",phone="",fax="",mobile="",email="",contactperson="",itpan="",lst="";
							String gst="",tin="",ward="",service="";

							String sql="";
							if("Add".equals(action))
							{
								id="";Name="";
								Groupname="";alias="";printname="";opbalance="";opbalancetype="";
								prbalance="";prbalancetype="";address="";phone="";fax="";mobile="";email="";
								contactperson="";itpan="";lst="";
								gst="";tin="";ward="";service="";
								actionS="ACCAccountMasterAdd";
								value="Add";
							}
							else
							{
								id="";Name="";
								id=request.getParameter("id");
sql = " SELECT INT_ACCOUNTMASTERID,INT_ACCOUNTGROUPID,CHR_NAME,CHR_ALIAS,CHR_PRINTNAME,DOU_OPENING,CHR_OPENINGTYPE,DOU_PREVIOUS, ";
sql = sql + " CHR_PREVIOUSTYPE,CHR_ADDRESS,CHR_PHONE,CHR_FAX,CHR_MOBILE,CHR_EMAIL,CHR_CONTACTPERSON,";
sql = sql + " CHR_ITPAN,CHR_LST,CHR_GST,CHR_TIN,CHR_WARD,CHR_SERVICETAX";
sql = sql + " FROM acc_m_accountmaster WHERE INT_ACCOUNTMASTERID="+id;
 
								String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								 
								id=data[0][0];Name=data[0][2];
								Groupname=data[0][1];alias=data[0][3];printname=data[0][4];opbalance=data[0][5];
								opbalancetype=data[0][6];
								prbalance=data[0][7];prbalancetype=data[0][8];address=data[0][9];phone=data[0][10];
								fax=data[0][11];mobile=data[0][12];email=data[0][13];
								contactperson=data[0][14];itpan=data[0][15];lst=data[0][16];
								gst=data[0][17];tin=data[0][18];ward=data[0][19];service=data[0][20];
								
								actionS="ACCAccountMasterEdit";
								value="Update";
							}
							
						%>			
				
				</div></td>
                </tr>
              <tr>
                <td class="boldEleven"> Name<span class="errormessage"> * </span></td>
                <td class="boldEleven"><input name="name" type="text" class="formText135" id="name" onBlur="upperMe(this) "
				 onKeyUp="upperMe(this) " value="<%=Name%>" maxlength="50">
				<div id='divunitname'></div>				</td>
              </tr>
              <tr>
                <td class="boldEleven">Account group <span class="errormessage"> * </span></td>
                <td class="boldEleven">
				<select name="Groupname" class="formText135" id="Groupname">
					<option value="0">Select</option>
				<%
					String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_ACCOUNTGROUPID, CHR_ACCOUNTGROUPNAME FROM  acc_m_accountgroup ORDER BY CHR_ACCOUNTGROUPNAME");
					for(int u=0;u<readData.length;u++)
						out.println("<option value='"+readData[u][0]+"'>"+readData[u][1]+"</option>");
				%>
                </select>
				 <script language="javascript" >setOptionValue('Groupname','<%=Groupname%>')</script>
                </td>
              </tr>
              <tr>
                <td class="boldEleven">Alias<span class="errormessage"> * </span></td>
                <td class="boldEleven"><input name="alias" type="text" class="formText135" id="alias" value="<%=alias%>" size="50" maxlength="100"></td>
              </tr>
              <tr>
                <td class="boldEleven">Print Name <span class="errormessage"> * </span></td>
                <td class="boldEleven"><input name="printname" type="text" class="formText135" id="printname" value="<%=printname%>" size="50" maxlength="100"></td>
              </tr>
              <tr>
                <td class="boldEleven">Opening Balance <span class="errormessage"> * </span></td>
                <td class="boldEleven"><table width="56" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td><input name="opbalance" type="text" class="formText135" id="opbalance" value="<%=opbalance%>" size="15" maxlength="15"></td>
                      <td><select name="opbalancetype" class="formText135" id="opbalancetype">
					  		<option value="0">Select Type</option>
							<option value="C">Credit</option>
							<option value="D">Debit</option>
                      </select>
					  <script language="javascript" >setOptionValue('opbalancetype','<%=opbalancetype%>')</script>
                      </td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td class="boldEleven">Previous Balance <span class="errormessage"> * </span></td>
                <td class="boldEleven"><table width="56" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td><input name="prbalance" type="text" class="formText135" id="prbalance" value="<%=prbalance%>" size="15" maxlength="15"></td>
                      <td><select name="prbalancetype" class="formText135" id="prbalancetype">
					  <option value="0">Select Type</option>
                        <option value="C">Credit</option>
                        <option value="D">Debit</option>
                      </select>
					  
					  <script language="javascript" >setOptionValue('prbalancetype','<%=prbalancetype%>')</script>
					  </td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td valign="top" class="boldEleven">Address<span class="errormessage"> * </span></td>
                <td valign="top" class="boldEleven"><textarea name="address" cols="50" rows="5" class="formText135" id="address"><%=address%>
</textarea></td>
              </tr>
              <tr>
                <td class="boldEleven">Phone<span class="errormessage"> * </span></td>
                <td class="boldEleven"><input name="phone" type="text" class="formText135" id="phone" value="<%=phone%>" size="30" maxlength="50"></td>
              </tr>
              <tr>
                <td class="boldEleven">Fax</td>
                <td class="boldEleven"><input name="fax" type="text" class="formText135" id="fax" value="<%=fax%>" size="30" maxlength="50"></td>
              </tr>
              <tr>
                <td class="boldEleven">Mobile<span class="errormessage"> * </span></td>
                <td class="boldEleven"><input name="mobile" type="text" class="formText135" id="mobile" value="<%=mobile%>" size="30" maxlength="50"></td>
              </tr>
              <tr>
                <td class="boldEleven">Email id <span class="errormessage"> * </span></td>
                <td class="boldEleven"><input name="email" type="text" class="formText135" id="email" value="<%=email%>" size="30" maxlength="100"></td>
              </tr>
              <tr>
                <td class="boldEleven">Contact Person <span class="errormessage"> * </span></td>
                <td class="boldEleven"><input name="contactperson" type="text" class="formText135" id="contactperson" value="<%=contactperson%>" size="30" maxlength="100"></td>
              </tr>
              <tr>
                <td class="boldEleven">IT PAN </td>
                <td class="boldEleven"><input name="itpan" type="text" class="formText135" id="itpan" value="<%=itpan%>" size="30" maxlength="100"></td>
              </tr>
              <tr>
                <td class="boldEleven">L.S.T</td>
                <td class="boldEleven"><input name="lst" type="text" class="formText135" id="lst" value="<%=lst%>" size="30" maxlength="100"></td>
              </tr>
              <tr>
                <td class="boldEleven">G.S.T</td>
                <td class="boldEleven"><input name="gst" type="text" class="formText135" id="gst" value="<%=gst%>" size="30" maxlength="100"></td>
              </tr>
              <tr>
                <td class="boldEleven">T.I.N</td>
                <td class="boldEleven"><input name="tin" type="text" class="formText135" id="tin" value="<%=tin%>" size="30" maxlength="100"></td>
              </tr>
              <tr>
                <td class="boldEleven">Ward</td>
                <td class="boldEleven"><input name="ward" type="text" class="formText135" id="ward" value="<%=ward%>" size="30" maxlength="100"></td>
              </tr>
              <tr>
                <td class="boldEleven">Service tax </td>
                <td class="boldEleven"><input name="service" type="text" class="formText135" id="service" value="<%=service%>" size="30" maxlength="100"></td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">
				<input type="hidden" name="filename" value="AccountMaster" />
                <input type="hidden" name="actionS"  value="<%=actionS%>" />
                    <input name="id" type="HIDDEN" id="id" value="<%=id%>">
                </td>
              </tr>
              <tr>
                <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input name="Submit" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   ></td>
                    <td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('AccountMaster.jsp')"></td>
                  </tr>
                </table></td>
                </tr>
            </table>
		  </form></td>
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
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}

%>
<%@ include file="../footer.jsp"%>
</body>
</html>
