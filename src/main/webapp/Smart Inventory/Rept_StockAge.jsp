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
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="javascript">
 
function disable()
{
		s2.style.visibility="hidden";
 		s1.style.visibility="Visible"; 
		document.getElementById('Agetype').value ='D';
}
function enable()
{
		s2.style.visibility="Visible";
		s1.style.visibility="hidden";
		document.getElementById('Agetype').value ='E';
}

function Validate()
{
	var Agetype = document.getElementById('Agetype').value;
	if(Agetype =="D")
	{
		if( 
			checkNull('fdate','Enter From Date')
			&& checkNull('tdate','Enter To Date')
			&& checkNull('Branch','Select Branch')
			&& checkNullSelect('Item','Select Item','0')  
			 )
			 	return true;
			 else
			 	return false;
	}
	else
	{
		if( 
			checkNull('from','Enter From  ')
			&& checkNull('to','Enter To ')
			&& checkNull('Branch','Select Branch')
			&& checkNullSelect('Item','Select Item','0')  
			 )
			 	return true;
			 else
			 	return false;
		
	}
	//Agetype,Item,Branch,from,to,fdate,tdate
	return false;
}
</script>
<body    onLoad="disable()"  >
<%@ include file="indexinv.jsp"%>
<form action="Rept_StockAgeResponse.jsp" method="post"   name="frm"   onSubmit="return Validate()"  AUTOCOMPLETE = "off">
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
		<td>
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="350"
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
					<td width="412">
					<table cellspacing="2" cellpadding="2" width="350" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">Stock Age  
									<%
									String branchid=""+session.getAttribute("BRANCHID");
				String usertype=""+session.getAttribute("USRTYPE");
				String user= ""+session.getAttribute("USRID"); 
									%>									</td>
							</tr>

							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>
							<tr>
							  <td height="17" colspan="3" class="boldEleven"><table width="100" border="0" align="center" cellpadding="0" cellspacing="0">
                                <tr>
                                  <td><input name="Selection" type="radio" value="D" checked onClick="disable()"></td>
                                  <td class="boldEleven">Date</td>
                                  <td class="boldEleven"><input name="Selection" type="radio" value="E" onClick="enable()"></td>
                                  <td class="boldEleven">Days</td>
                                </tr>
                              </table></td>
						  </tr>
							<tr>
							  <td height="17" colspan="3" class="boldEleven"><table id="s1" width="80%" border="0" align="center" cellpadding="2" cellspacing="2">
                                <tr>
                                  <td class="boldEleven">From Date <span
									class="bolddeepred">* </span></td>
                                  <td class="boldEleven"><input
									tabindex="2" name="fdate" type="text" class="formText135"
									id="fdate" size="15" readonly="readonly">
                                    <a
									href="javascript:cal2.popup();"> <img
									src="../JavaScript/img/cal.gif" width="16" height="16"
									border="0" /> </a>
                                    <script language='JavaScript'
									type="text/javascript">
		<!--			
				 
				var cal2 = new calendar1(document.forms['frm'].elements['fdate']);
				cal2.year_scroll = true;
				cal2.time_comp = false;
				setCurrentDate('fdate'); 
		//-->
                                    </script></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">To Date <span
									class="bolddeepred">* </span></td>
                                  <td class="boldEleven"><input tabindex="2"
									name="tdate" type="text" class="formText135" id="tdate"
									size="15" readonly="readonly">
                                    <a
									href="javascript:cal3.popup();"> <img
									src="../JavaScript/img/cal.gif" width="16" height="16"
									border="0" /> </a>
                                    <script language='JavaScript'
									type="text/javascript">
		<!--			
				 
				var cal3 = new calendar1(document.forms['frm'].elements['tdate']);
				cal3.year_scroll = true;
				cal3.time_comp = false;
				setCurrentDate('tdate'); 
		//-->
                                    </script></td>
                                </tr>
                                 
                              </table></td>
						  </tr>
							
							<tr>
							  <td height="19" align="right" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td align="left" valign="top" class="boldEleven"><table id="s2" width="249" border="0" align="left" cellpadding="0" cellspacing="0">
                                <tr>
                                  <td class="boldEleven">Days</td>
                                  <td class="boldEleven">&gt;=</td>
                                  <td class="boldEleven"><input name="from" type="text" class="formText135" id="from"   onKeyPress="return numeric_only(event,'from','4')"  size="10" maxlength="6"></td>
                                  <td class="boldEleven">&lt;=</td>
                                  <td class="boldEleven"><input name="to" type="text" class="formText135" id="to"  onKeyPress="return numeric_only(event,'to','4')"  size="10" maxlength="6"></td>
                                </tr>
                              </table></td>
						  </tr>
							<tr>
							  <td   height="19" align="right" valign="top" class="boldEleven"><div align="left">Company <span
									class="bolddeepred">* </span></div></td>
							  <td  align="right" valign="top" class="boldEleven"> 
                                <div align="left">
                                  <select name="Branch" class="formText135" id="Branch" tabindex="6" style="width:200"  >
                                      <option value="0">All</option>
                                    <%
								
				String sql ="Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID ";	
				if("N".equals(CommonFunctions.QueryExecute("SELECT  CHR_DISPLAYINACTIVECOMPANY FROM m_institution  WHERE INT_ID=1")[0][0]))			  
					sql = sql + " AND b.INT_ACTIVE =1 ";
								
				String shipids[][] =  CommonFunctions.QueryExecute(sql);
				if(usertype.equals("F") || usertype.equals("B"))
				{
				  for(int u=0; u<shipids.length; u++)
					out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+" @ "+shipids[u][1]+"</option>");
				}
				else
				{
					for(int u=0; u<shipids.length; u++)
						if(shipids[u][0].equals(branchid))
							out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+" @ "+shipids[u][1]+"</option>");
												
				}
						
							%>
                                  </select> 
                                  <script language="javascript">
						  	setOptionValue("Branch","<%=branchid%>") 
						        </script>
                                </div></td>
						  </tr>
							 
							<tr>
								<td height="17" class="boldEleven">Select Type  <span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left">
								<select name="Item" id="Item"  style="width:200">
								<option value="0">Select</option>
								<option value="I">Item</option>
								<option value="P">Product</option>
							    </select>  <span class="boldEleven">
							    <input name="Agetype" type="hidden" id="Agetype" value="D">
							    </span></td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   ></td>
										<td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="javascript:window.close()"></td>
									</tr>
								</table>								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
							</tr>
						</tbody>
						<input type="hidden" name="mobileBookingOption" />
					</table>
					</td>
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
<%@ include file="../footer.jsp"%></form>
</body>
</html>
