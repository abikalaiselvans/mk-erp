<%@ page import="java.io.*,java.util.*" errorPage="../error/index.jsp"%>
<jsp:directive.page import="com.my.org.erp.SmartInventory.Product" />
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
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript"
	src="../JavaScript/Inventory/InventAJAX.js"></script>

<script language="javascript">
	function Validate()
	{
		
		if(	
			checkNullSelect("customerid","Enter Customer Id",'0')
			&&checkNull("Amcid","Enter AMC ID...")
			&&checkNullSelect("type","Enter Type...",'0')
			&&checkNull("serialno","Enter Serial Number")
			&&checkNull("description","Enter Description")	
			&&checkNull("startdate","Enter Start Date")	
			&&checkNull("amcamount","Enter AMC Amount")		
			
			)
			{
			return true;	
			}
		else
			return false;	
	}
</script>

<body >
<!-- onLoad="loadAMCCustomer()"-->
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" action="../SmartLoginAuth" method="post"
	onSubmit="return Validate()">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="586"
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
					<td>
					<table cellspacing="2" cellpadding="2" width="100%" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">AMC</td>
							</tr>
							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">
								Mandatory </span></td>
							</tr>
							<tr>
								<td width="168" height="17" valign="top" class="boldEleven">AMC
								Number <%
				  	String sql ="";
					String amcid = request.getParameter("amcid");
					 
					 
					sql = "SELECT INT_CUSTOMERID,CHR_CUSTOMERFLAG,CHR_ITEMID,CHR_TYPE,CHR_SERIALNO,CHR_WARRANTY,CHR_AMCDESC, ";
					sql = sql +"DT_STARTDATE,DT_ENDDATE,DOU_AMCAMOUNT,CHR_ITEMFLAG FROM inv_t_amc WHERE CHR_AMCID	='"+amcid+"'";
					//System.out.print(sql);
					String readDatas[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					String dbvalue="";

				  %>
								</td>
								<td width="244" colspan="2" align="left" valign="top"
									class="boldEleven"><%=amcid%><input name="amcid"
									type="hidden" value="<%=amcid%>"></td>
							</tr>

							<tr>
								<td height="17" valign="top" class="boldEleven">Customer
								Type</td>
								<td colspan="2" align="left" valign="top" class="boldEleven"><!--"-->

								<%
				   
				  if("C".equals(readDatas[0][1]))
				  	 out.println("Customer");
				  if("N".equals(readDatas[0][1]))
				  	out.println("Non - Customer");
				  
				%>
								</td>
							</tr>


							<tr>
								<td height="17" valign="top" class="boldEleven">Customer
								Name</td>
								<td colspan="2" align="left" valign="top" class="boldEleven">
								</td>
							</tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Type</td>
								<td colspan="2" align="left" valign="top" class="boldEleven">
								<%
				   String iname="";
				   String itemname="";
				   if(readDatas[0][3].equals("I")  )
					{
						iname="Item";
						sql = "SELECT CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID='"+readDatas[0][2]+"'";
						itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
					}	
					if(readDatas[0][3].equals("P")  )
					{
					  iname="Product";
					  sql= "SELECT CHR_PRODUCTCODE FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+readDatas[0][2]+"'";
					  itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
					}
					out.print(iname);
				%>
								</td>
							</tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Customer
								Item / Product</td>
								<td colspan="2" align="left" valign="top" class="boldEleven"><%=readDatas[0][2]%>
								</td>
							</tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Serial
								Number</td>
								<td colspan="2" align="left" valign="top" class="boldEleven"><input
									name="serialno" type="text" class="formText135" id="serialno"
									size="30" maxlength="50" value="<%=readDatas[0][4]%>"></td>
							</tr>
							<tr id="chk1">
								<td height="17" valign="top" class="boldEleven">Description</td>
								<td colspan="2" align="left" valign="top"><textarea
									name="description" cols="30" rows="5" class="formText135"
									id="description"><%=readDatas[0][6]%></textarea></td>
							</tr>
							<tr id="chk2">
								<td height="17" valign="top" class="boldEleven">Starting
								Date</td>
								<td colspan="2" align="left" valign="top"><input
									name="startdate" type="text" class="formText135" id="startdate"
									size="27" onKeyPress="dateOnly(this)" /> <a
									href="javascript:cal1.popup();"> <img
									src="../JavaScript/img/cal.gif" width="16" height="16"
									border="0" /> </a> <script language='JavaScript'
									type="text/javascript">
						<!--			
							var cal1 = new calendar1(document.forms['frm'].elements['startdate']);
							cal1.year_scroll = true;
							cal1.time_comp = false;
							setCurrentDate('startdate'); 
						//-->
                       </script></td>
							</tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">No of Years
								</td>
								<td colspan="2" align="left" valign="top">
								<%
				  	dbvalue=readDatas[0][5];
				  %> <select name="warranty" class="formText135" id="warranty">
									<option value="1">1 Year</option>
									<option value="2">2 Years</option>
									<option value="3">3 Years</option>
									<option value="4">4 Years</option>
									<option value="5">5 Years</option>
								</select></td>
							</tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">AMC Amount
								</td>
								<td colspan="2" align="left" valign="top"><input
									name="amcamount" type="text" class="formText135" id="amcamount"
									size="30" maxlength="8" onKeyPress="priceOnly(this)"
									value="<%=readDatas[0][9]%>"></td>
							</tr>


							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left"><input name="filename"
									type="hidden" value="AMC" /> <input name="actionS"
									type="hidden" value="INVAMCUpdate" /></td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit" type="submit" id="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   ></td>
										<td><input name="Close" type="Button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('amc.jsp')"></td>
									</tr>
								</table>
								</td>
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
</table>


</form>
<%@ include file="../footer.jsp"%>
</body>
</html>
