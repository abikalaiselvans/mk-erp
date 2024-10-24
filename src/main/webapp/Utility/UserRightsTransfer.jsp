<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.*, com.my.org.erp.ServiceLogin.*"%>
<html>
<head>

<title> :: UTILITY :: </title>
 <style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
 </style>
 
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

 
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script type="text/javascript" src="../JavaScript/common/StaffSearch.js"> </script>

<script language="javascript">
function formAction()
{
	
  
  if( checkNull('From','Select From Employee ') && checkNull('To','Select To Employee ' ) && checkNull('Modules','Select To Module ') )
    	return true;
  else
  	return false
		
}
</script>

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
 
<form action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return formAction()">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td> </td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="400"
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
					<td width="412"><table width="600" border="0" align="center">
                      <tr>
                        <td width="123">&nbsp;</td>
                        <td width="234">&nbsp;</td>
                        <td width="39">&nbsp;</td>
                        <td width="189">&nbsp;</td>
                        <td width="87">&nbsp;</td>
                      </tr>
                      <tr>
                        <td colspan="2"><table width="100%" border="0">
                          <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                          </tr>
                          <tr>
                            <td class="boldEleven">Search By Name 
                            <%
				String sql ="SELECT CHR_EMPID,CHR_STAFFNAME FROM com_m_staff  ORDER BY CHR_STAFFNAME";
				String data[][]= CommonFunctions.QueryExecute(sql);
			%></td>
                            <td>
<input name="search1" type="text" class="formText135" id="search1"   onKeyUp="loadSearchStaff(this,'From')"></td>
                          </tr>
                          <tr>
                            <td class="boldEleven">From</td>
                            <td><div id='Fromstaff'>
                              <select name="From" size='10' class="formText135" id="From" style="width:200">
                               <option value="">Select</option>
                                <%
							for(int u=0;u<data.length;u++)
								out.println("<option   value='"+data[u][0]+"'>"+data[u][0]+" / "+data[u][1]+"</option>");
						%>
                              </select>
                            </div></td>
                          </tr>
                          <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                          </tr>
                        </table></td>
                        <td align="center"><p>
                          <input type="button" name="add" value=">>" onClick="addItem()" class="search">
                                                   <br>
                            <input name="button" type="button" class="search" onClick="removeItem()" value="&lt;&lt;" /><br>
						<br>
<script language="javascript">  
function addItem()
{
	var count,k,i;
	count=document.frm.From.length;
	var _targ=document.getElementsByName('To')[0];   
	i=_targ.options.length;
	for(k=0;k<count;k++)
	{
		if(document.frm.From[k].selected==true)
		{     	   		
			selVal=document.frm.From.options[k].value;
			selText=document.frm.From.options[k].text;
			_targ.options[i]=new Option(selText,selVal);
			i=i+1;
		}
	}   
	_targ.options.length=i;  
	_targ.options.selectedIndex=0;  
	 
}

function removeItem()
{
	var count,k,i;
	count=document.frm.To.length;
	if(count>0)
	{
		for(k=0;k<count;k++)
		{
			if(document.frm.To[k].selected==true)
			{
				var x=document.getElementById("To")
				x.remove(x.selectedIndex)
			}
		}
	}
	else
	{
		alert('There is Emp to Remove');
	}
} 	 
</script>					
                        </td>
                        <td colspan="2"><table width="100%" border="0">
                          <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                          </tr>
                          <tr>
                            <td>&nbsp; </td>
                            <td> </td>
                          </tr>
                          <tr>
                            <td class="boldEleven">To</td>
                            <td><div id='Tostaff'>
                              <select name="To"  size='10' multiple class="formText135" id="To"   style="width:200"  >
                                <option value="">Select</option>
                                <%
							//for(int u=0;u<data.length;u++)
								//out.println("<option value='"+data[u][0]+"'>"+data[u][0]+" / "+data[u][1]+"</option>");
						%>
                              </select>
                            </div></td>
                          </tr>
                          <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                          </tr>
                        </table></td>
                      </tr>
                      <tr>
                        <td colspan="5"><table width="299" border="0" align="center" cellpadding="0" cellspacing="0">
                          <tr>
                            <td class="boldEleven">Select Module </td>
                            <td><select name="Modules"  size='10' multiple class="formText135" id="Modules">
                               
                                <%
								String mdata[][]= CommonFunctions.QueryExecute("SELECT CHR_FIELD,CHR_MODULE FROM   m_projectmodule   ORDER BY CHR_MODULE");
							for(int u=0;u<mdata.length;u++)
								out.println("<option value='"+mdata[u][0]+"'>"+  mdata[u][1]+"</option>");
						%>
                              </select></td>
                          </tr>
                        </table></td>
                      </tr>
                      <tr>
                        <td colspan="5"><table width="166" border="0" align="center" cellpadding="0" cellspacing="0">
                          <tr>
                            <td class="boldEleven">Uncluding User Type </td>
                            <td><input name="usertype" type="checkbox" class="formText135" id="usertype" value="Y"></td>
                          </tr>
                        </table></td>
                      </tr>
                      <tr>
                        <td>&nbsp; </td>
                        <td>&nbsp; </td>
                        <td>&nbsp;</td>
                        <td><input name="filename" type="hidden"
								id="filename" value="UserRights" />
                          <input name="actionS"
								type="hidden" id="actionS" value="UTIUserRightsTransfer" /></td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td colspan="5"><table align="center">
								<tr>
									<td width="56"><input name="Submit" type="submit"
										class="buttonbold" value="Submit"   accesskey="s"     >									</td>
									<td width="56"><input name="Button" type="button"
										class="buttonbold"  value="Close"   accesskey="c"  onClick="redirect('Userframe.jsp')"></td>
								</tr>
							</table></td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                    </table>					</td>
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
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td width="100%" align="center">&nbsp;</td>
	</tr>
	<tr>
		<td> </td>
	</tr>
</table>
</form>
 

</html>
