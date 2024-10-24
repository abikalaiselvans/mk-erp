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
		checkNull("itemgroup","Enter Itemgroup")
		&& checkNull("description","Enter Description")
		&& checkNullSelect("unit","Select Unit" ,'0')
	   )
		return true;
	else
		return false
}
 
</script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="document.getElementById('item').focus()" >
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
                          <td height="16" colspan="3" align="center" valign="top" 	class="boldThirteen">Item Group  Informatormations 
						    <%
							String action=request.getParameter("action1");
							String itemlistid="",itemgroupid="",itemname="",description="",pprice="",sprice="",actionS="",value="";
							String sql="";
							if("Add".equals(action))
							{
								itemlistid="";itemgroupid="";itemname="";description="";pprice="";sprice="";
								actionS="STKItemListAdd";
								value="Add";
							}
							else
							{
								itemlistid="";itemgroupid="";itemname="";description="";pprice="";sprice="";
								itemlistid=request.getParameter("itemlistid");
								sql = " SELECT INT_ITEMID,INT_GROUPID,CHR_ITEMNAME,CHR_DESC,DOU_PPRICE,DOU_SPRICE  FROM con_inv_m_itemlist WHERE INT_ITEMID="+itemlistid;
								String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								itemlistid=data[0][0];itemgroupid=data[0][1];itemname=data[0][2];description=data[0][3];
								pprice=data[0][4];sprice=data[0][5];
								actionS="STKItemListEdit";
								value="Update";
							}
							
						%>			
									
						<input
											name="itemlistid" type="HIDDEN" id="itemlistid" value="<%=itemlistid%>">
                        <input type="hidden" name="filename" value="ItemList" />
                        <input type="hidden" name="actionS" value="<%=actionS%>" /></td>
                        </tr>
                         
                        <tr>
                          <td width="116" height="17" class="boldEleven">Item Name <font
									color="ff0000">*</font></td>
                          <td width="258" colspan="2" align="left"><input name="item" type="text" class="formText135" id="item" value="<%=itemname%>" size="20" maxlength="45" onKeyUp="upperMe(this),CheckUnique(this,'divitemname','con_inv_m_itemlist','CHR_ITEMNAME')" onBlur="upperMe(this), CheckUnique(this,'divitemname','con_inv_m_itemlist','CHR_ITEMNAME')"><div id='divitemname'></div>
						  
						 
						  
						  </td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven" valign="top">Item Group  Name <font
									color="ff0000">*</font></td>
                          <td colspan="2" align="left" valign="top">
						  
						  <select id="itemgroupid" name="itemgroupid" class="formText135">
						  <option value="0">Select</option>
						  <%
						  	String ss="SELECT INT_GROUPID,CHR_GROUPNAME FROM con_inv_m_itemgroup  ORDER BY CHR_GROUPNAME";
							String itemgroupdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(ss);
							for(int y=0;y<itemgroupdata.length;y++)
								out.println("<option value='"+itemgroupdata[y][0]+"'>"+itemgroupdata[y][1]+" </option>");
						  %>
						  </select>
						  <%
						  	if(!"Add".equals(action))
							{
							%>
							<script language="javascript">setOptionValue('itemgroupid','<%=itemgroupid%>')</script>
							<%
							}
							else
							{
								if(!"".equals(request.getParameter("itemgroupid")))
								{
								%>
								<script language="javascript">setOptionValue('itemgroupid','<%=request.getParameter("itemgroupid")%>')</script>
								<%
								}
							}
						  %>						  </td>
                        </tr>
                         
                        <tr>
                          <td height="17" class="boldEleven" valign="top">Description   <font
									color="ff0000">*</font></td>
                          <td colspan="2" align="left" valign="top"><textarea name="description" cols="30" rows="5" class="formText135" id="description" onKeyUp="textArea('description','220')"  ><%=description%></textarea>
                            <div id='divshortname'></div></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven" valign="top">Purchase Price <font
									color="ff0000">*</font></td>
                          <td colspan="2" align="left"><input name="pprice" type="text" class="formText135" id="pprice" value="<%=pprice%>" size="20" maxlength="8"   style='text-align:right' onKeyPress="doubleValue('pprice',8)" ></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven" valign="top">Sales Price  <font
									color="ff0000">*</font></td>
                          <td colspan="2" align="left"><input name="sprice" type="text" class="formText135" id="sprice" value="<%=sprice%>" size="20" maxlength="8"  style='text-align:right' onKeyPress="doubleValue('sprice',8)"></td>
                        </tr>
                         
                        <tr>
                          <td height="17" colspan="3" valign="top" class="boldEleven"><table width="131" border="0" align="center">
                              <tr>
                                <td width="54">
<input name="Submit" type="submit"	id="submit" class="buttonbold13" value="<%=value%>" ></td>
                                <td width="67"><div align="center">
                                  <input name="button" type="button" class="buttonbold13"  value="Close"   accesskey="c"  onClick="redirect('ItemListview.jsp')">
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
