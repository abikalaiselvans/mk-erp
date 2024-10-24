<%@ page import="java.io.*,java.util.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.ServiceLogin.DateUtil"%>
 
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
 <style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
 </style>
</head>
<script language="javascript" src="../JavaScript/Inventory/InventAJAX.js"></script>
<script language="javascript" src="../JavaScript/Inventory/GoodsReturn.js"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 <script language="JavaScript">
	
	
	function Returns()
 	{		
		
		obj = findObj("refid"); 
		if(obj == null)
		{
			alert("Edit not available, please enter Goods Return No. & select invoice number");
			
			return false;
		}
		
		var count;
		count=0;
		coffee1=document.forms[0].refid
		txt=""
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].refid.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Return")
			if (name==true)
			{ 
				document.frm.action="../SmartLoginAuth";
				return true;			
			}
			else
				return false;
		}
		else
		{
		    alert("Select Atleast One Value");
		    return false;
		}		
 	}
 	
 
 
 	
   
  
  
  	 
 	
</script>

<body  >
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
		<td>
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
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
					<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm"
						 >
					<table cellspacing="2" cellpadding="2" width="627" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" align="center" valign="top" class="boldThirteen">GOODS RETURN  
								  <%
						
						String purchasetype = ""+request.getParameter("purchasetype");
						String month = ""+request.getParameter("month");
						String year = ""+request.getParameter("year");
						String sql = "";
						if("V".equals(purchasetype))
							out.println(" -  FOR VENDOR PURCHASE");
						else	
							out.println(" -  FOR DIRECT PURCHASE");
							
						
						if("V".equals(purchasetype))
						{
							sql ="SELECT CHR_PURCHASEORDERNO FROM  inv_t_vendorgoodsreceived ";
							sql = sql+" WHERE CHR_RECEIVEDMODE ='P' AND CHR_RECIVEDID is not null ";
							sql = sql+" AND MONTH(DAT_RECIVEDDATE) = "+month;
							sql = sql+" AND YEAR(DAT_RECIVEDDATE) = "+year;
							sql = sql+" GROUP BY  CHR_RECIVEDID ORDER BY CHR_PURCHASEORDERNO";
						}
						else
						{
							sql ="SELECT CHR_RECIVEDID FROM  inv_t_vendorgoodsreceived ";
							sql = sql+" WHERE CHR_RECEIVEDMODE ='D' AND CHR_RECIVEDID is not null ";
							sql = sql+" AND MONTH(DAT_RECIVEDDATE) = "+month;
							sql = sql+" AND YEAR(DAT_RECIVEDDATE) = "+year;
							sql = sql+" GROUP BY  CHR_RECIVEDID ORDER BY CHR_RECIVEDID";
						}
						//out.println(sql);	
						String GRNData[][] =  CommonFunctions.QueryExecute(sql);
					%>
								</td>
							</tr>
							<tr>
								<td height="19" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory</span></td>
							</tr>
							<tr>
								<td height="19" align="right" valign="top" class="boldgre">
								<div align="center"><%=DateUtil.getMonth(Integer.parseInt(month)) +" - " + year%>
								</div>
								</td>
							</tr>
							<tr>
								<td height="19" align="right" valign="top">
								<table width="718" border="0" cellspacing="1" cellpadding="1">
									<tr>
										<td>
										<table width="619" border="0" align="center" cellpadding="1"
											cellspacing="1">
											<tr>
												<td width="140" class="boldEleven">Goods Return No.</td>
												<td width="138" class="boldEleven"><input name="grtno"
													type="text" value="" class="formText135" id="grtno"
													onKeyUp="upperMe(this),CheckUniqueNO(this,'soValid','inv_t_vendorgoodsreturn','CHR_GRTNO')" maxlength="25">
												<div id=soValid></div>
											  </td>
												<td width="197" class="boldEleven">Goods Received No</td>
												<td width="131" class="boldEleven"><select name="rid"  id="rid"
													onChange="loadReceivedId()">
													<option>Select</option>
													<%
								for(int u=0; u<GRNData.length; u++)
									out.println("<option value='"+GRNData[u][0]+"'>"+GRNData[u][0]+"</option>");
							%>
												</select></td>
											</tr>
										</table>
										</td>
									</tr>
									<tr>
										<td></td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td>
										<div align="center" id="ReceivedIdTable"
											style="OVERFLOW:auto;width:900px;height:auto"
											class="boldEleven"></div>
										</td>
									</tr>
									<tr>
										<td>
										<table border="0" align="center" cellpadding="1"
											cellspacing="1">
											<tr>
											  <td width="56"><input name="filename" type="hidden"
													id="filename" value="GoodsReturn"> <input
													name="actionS" type="hidden" id="actionS"
													value="INVGoodsReturnAdd">
											    <input name="purchasetype" type="hidden" id="purchasetype" value="<%=purchasetype%>"></td>
												<td width="56">
												<div align="center">
												
												
												<input name="Return" id="Return" onClick=" return Returns()"
													type="submit" class="buttonbold13" value="Return"
													>  </div><!---->
												</td>
												<td width="56">
												<div align="center"><input name="Submit" type="button"
													class="buttonbold13"  value="Close"   accesskey="c"  id="Submit"
													onClick="redirect('Goods Return.jsp')"></div>
												</td>
											</tr>
										</table>
										</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>

								</table>
								</td>
							</tr>
						</tbody>
						<input type="hidden" name="mobileBookingOption" />
					</table>
					</form>
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
</table>
<%@ include file="../footer.jsp"%>
</body>
</html>
