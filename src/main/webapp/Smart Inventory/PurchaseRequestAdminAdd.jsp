<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.Math.*"%>
<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.SmartInventory.InventoryInvoiceFunctions"%>
<%
try
{
%>
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
 

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"	type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InventAJAX.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenCustomerAJAX.js" type="text/javascript"></script>
 
<body >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit=" return  Validate() ">
<table width="900" border="0" cellspacing="1" cellpadding="1">
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
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="800"
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
								<td height="16" colspan="4" align="center" valign="top"
									class="boldThirteen">PURCHASE REQUEST DIVISION
									
									
									<%
				String Requestno = request.getParameter("Requestno");							
				String sql = " ";
				sql = " SELECT "; 
				sql = sql + " a.INT_POREQUESTID,b.CHR_BRANCHNAME,c.CHR_DIVICODE, a.CHR_POREQUESTNO,DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%m-%Y'), ";
				sql = sql + " h.CHR_NAME,h.CHR_NAME, ";
				sql = sql + " f.CHR_PAYMENTNAME, ";
				sql = sql + " a.INT_CUSTOMERCOMMITMENTDAYS,a.CHR_REF,g.CHR_STAFFNAME,a.CHR_DES,a.CHR_APPROVEDSTATUS, ";
				sql = sql + " a.CHR_APPROVEDBY,DATE_FORMAT(a.DAT_APPROVEDDATE,'%d-%m-%Y'),a.CHR_APPROVEDDESCRIPTION ,a.INT_BRANCHID,a.INT_DIVIID,a.INT_CUSTOMERID  ";
				sql = sql + " FROM inv_t_purchaserequest a, com_m_branch b,inv_m_division c,inv_m_customerinfo d, inv_m_customergroup h, ";
				sql = sql + " inv_m_paymentterms f,com_m_staff g ";
				sql = sql + " WHERE a.INT_BRANCHID = b.INT_BRANCHID ";
				sql = sql + " AND a.INT_DIVIID =c.INT_DIVIID ";
				sql = sql + " AND a.INT_CUSTOMERID = d.INT_CUSTOMERID AND d.INT_CUSTOMERGROUPID= h.INT_CUSTOMERGROUPID ";
				 
				sql = sql + " AND a.INT_PAYMENTTERMID = f.INT_PAYMENTTERMID ";
				sql = sql + " AND a.CHR_REF=g.CHR_EMPID AND 	CHR_POREQUESTNO='"+Requestno+"'";
				//out.println(sql);
				String data[][] =  CommonFunctions.QueryExecute(sql);
				
				double contributionlevel =0;
				boolean contributionflag = false;
				boolean contributionflag1 = false;
				String cdata[][] =  CommonFunctions.QueryExecute("SELECT INT_CONTRIBUTION_LEVEL1 FROM  m_inventorysetting WHERE INT_ROWID=1");
				if(cdata.length>0)
					contributionlevel = Double.parseDouble(cdata[0][0]);
				
				
									%>									</td>
						    </tr>

							<tr>
								<td height="19" colspan="4" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
						    </tr>
							 
							<tr>
								<td width="118" height="17" valign="top" class="bold1">Request date </td>
							  <td width="199" align="left" valign="top"><span class="boldEleven"><%=data[0][3] +"  dated on " +data[0][4]%></span></td>
							    <td width="105" class="bold1"><!--DWLayoutEmptyCell-->&nbsp;</td>
						        <td width="148" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							</tr>
							
							<tr>
							  <td height="17" valign="top" class="bold1"><div align="left">CustomerName</div></td>
							  <td align="left"><span class="boldEleven"><%=data[0][5]%>
                                  <input name="customer" type="hidden" id="customer" value="<%=data[0][18]%>">
                              </span></td>
						      <td class="bold1">Vendor Payment </td>
						      <td class="boldEleven"><%=data[0][7]%> </td>
							</tr>
							<tr>
							  <td class="bold1">Division</td>
							  <td class="boldEleven"><%=data[0][2]%>
                                <input name="divis" type="hidden" id="divis" value="<%=data[0][17]%>"></td>
							  <td class="bold1">Customer Commitment days </td>
							  <td class="boldEleven"><%=data[0][8]+"- Days"%> </td>
							</tr>
							<tr>
							  <td valign="top" class="bold1">Description </td>
							  <td valign="top" class="boldEleven"><%=data[0][11]%>  </td>
							  <td valign="top" class="bold1">M.E </td>
							  <td valign="top" class="boldEleven"><%=data[0][9]+" / "+data[0][10]%> </td>
							</tr>
							<tr>
							  <td valign="top" class="bold1">Accept
							  							  </td>
							  <td valign="top" class="boldEleven">
							  <select name="Accept" class="formText135" id="Accept">
                              	<option value="Y">Yes</option>
							  	<option value="N">No</option>
							  </select>
							  </td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td valign="top" class="bold1"><span class="bold1">Description </span><span class="errormessage">*</span> </td>
							  <td valign="top" class="boldEleven"><textarea name="memo" cols="30"
										rows="5" onKeyUp="textArea('memo','500')" class="formText135" id="memo" tabindex="9"><%=data[0][15]%></textarea></td>
							  <td valign="top" class="bold1"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td valign="top" class="boldEleven"> 					  </td>
						  </tr>
							 
							 
							
							
							 
							 
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven">
 							  </td>
						  </tr>
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td height="17" colspan="4" valign="top" class="formTableOuterDesign">PURCHASE REQUEST DETAILS </td>
						  </tr>
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven">

 
<%
sql = " SELECT if(a.CHR_TYPE=\"I\",\"Item\",\"Product\"), ";
sql = sql +" if(a.CHR_TYPE=\"I\",(SELECT c.CHR_ITEMNAME FROM inv_m_item c WHERE c.CHR_ITEMID=a.CHR_ITEMID) , ";
sql = sql +" (SELECT d.CHR_PRODUCTCODE  FROM inv_m_produtlist d WHERE d.CHR_PRODUCTID=a.CHR_ITEMID) ";
sql = sql +"  ), ";
sql = sql +" a.CHR_DESC,a.INT_QUANTITY,a.DOU_UNITPRICE,a.DOU_PURCHASEPRICE,DOU_UNITSALEPRICE,a.DOU_SALESPRICE, ";
sql = sql +" if(a.CHR_ADDITIONALWARRANTY=\"Y\",\"Yes\",\"No\"), a.DOU_INSTALLATION, a.DOU_DELIVERY,a.DOU_ADDITIONALWARRANTY, ";
sql = sql +" a.DOU_GROSSVALUE,a.DOU_CONTRIBUTION, a.DOU_CONTRIBUTION_PERCENTAGE, a.CHR_ACCEPT,a.INT_ROWID,a.DOU_UNITSALEPRICE, ";
sql = sql +" ROUND(a.DOU_SALESPRICE/a.INT_QUANTITY,2)  ,b.CHR_VENDORNAME,DOU_MARGIN,a.CHR_TYPE ,a.CHR_ITEMID "; 
sql = sql +"  FROM inv_t_purchaserequestitem  a , inv_m_vendorsinformation  b ";
sql = sql +" WHERE a.INT_VENDORID  =b.INT_VENDORID  AND a.CHR_POREQUESTNO='"+Requestno+"' ORDER BY a.CHR_TYPE  ";
String itemDatas[][] =  CommonFunctions.QueryExecute(sql);
if(itemDatas.length>0)
{
	out.print("<div id='divscroll' style='OVERFLOW:auto;width:100%;height:auto'>  ");
	out.print("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' > ");
	out.print("<tr class='MRow1'> ");
	out.print("<th class='boldEleven'><b>S.No</b></th> ");
	out.print("<th class='boldEleven'><b>Vendor</b></th> ");
	out.print("<th class='boldEleven'><b>Type</b></th> ");
	out.print("<th class='boldEleven'><b>Item / Product Code</b></th> ");
	out.print("<th class='boldEleven'><b>Description</b></th> ");
	out.print("<th class='boldEleven'><b>Quantity</b></th> ");
	out.print("<th class='boldEleven'><strong><b>Unit PurchasePrice</strong></th> ");
	out.print("<th class='boldEleven'><strong><b>PurchasePrice</strong></th> ");
	out.print("<th class='boldEleven'><strong><b>Unit Sale Price</strong></th> ");
	out.print("<th class='boldEleven'><strong><b>Sale Price</strong></th> ");
	out.print("<th class='boldEleven'><strong><b>Contribution</strong></th> ");
	out.print("<th class='boldEleven'><strong><b>Contribution(%)</strong></th> ");
	out.print("<th class='boldEleven'><strong><b>If Installation /Delivery/Additional Warranty Required: Yes/No</strong></th> ");
	out.print("<th class='boldEleven'><strong><b>Installation</strong></th> ");
	out.print("<th class='boldEleven'><strong><b>Delivery</strong></th> ");
	out.print("<th class='boldEleven'><strong><b>Additional Warranty</strong></th> ");
	out.print("<th class='boldEleven'><strong><b>Gross Margin</strong></th> ");
	out.print("<th class='boldEleven'><strong><b>Margin (%)</strong></th> ");
	out.print("</tr> ");

		
		
		for(int u=0;u<itemDatas.length;u++)
		{
			 
			if(u%2==0)
				out.print("<tr class='MRow1'>");
			else
				out.print("<tr class='MRow2'>");
				
			out.println("<td  class='boldEleven' valign='top'   valign='top'>"+(u+1)+".</td>");
			out.println("<td  class='boldEleven' valign='top'   valign='top'>"+itemDatas[u][19] +"</td>");
			out.println("<td  class='boldEleven' valign='top'   valign='top'>"+itemDatas[u][0] +"</td>");
			out.println("<td  class='boldEleven' valign='top'   valign='top'>"+itemDatas[u][1] +"</td>");
			out.println("<td  class='boldEleven' valign='top'   valign='top'>&nbsp;</td>");//"+itemDatas[u][2] +"
			out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][3] +"</td>");
			out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][4] +"</td>");
			out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][5] +"</td>");
			out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][6] +"</td>");
			out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][7] +"</td>");
			out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][13] +"</td>");
			out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][14] +"</td>");//Contribution
		    out.println("<td  class='boldEleven' valign='top'   align='left'>"+itemDatas[u][8] +"</td>");
			out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][9] +"</td>");
			out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][10] +"</td>");
			out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][11] +"</td>");
			out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][12] +"</td>");
			out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][20] +"</td>");
			if(Double.parseDouble(itemDatas[u][14]) < contributionlevel)
					contributionflag1 = true;
				
			 }
		
			
		sql = " SELECT SUM(INT_QUANTITY),SUM(DOU_UNITPRICE),SUM(DOU_PURCHASEPRICE),SUM(DOU_UNITSALEPRICE), ";
		sql = sql + "SUM(DOU_SALESPRICE), SUM(DOU_GROSSVALUE),SUM(DOU_CONTRIBUTION), SUM(DOU_CONTRIBUTION_PERCENTAGE), ";
		sql = sql + " ROUND( (SUM(DOU_CONTRIBUTION) /SUM(DOU_PURCHASEPRICE) *100 ),2) ";
		sql = sql + " FROM inv_t_purchaserequestitem WHERE CHR_POREQUESTNO='"+Requestno+"' ORDER BY CHR_TYPE ";
		String sumdata[][] = CommonFunctions.QueryExecute(sql);
		out.print("<tr class='MRow1'>");
		out.print("<td  class='boldEleven'  valign='top'>&nbsp;</td>");
		out.print("<td  class='boldEleven'  valign='top'>&nbsp;</td>");
		out.print("<td  class='boldEleven'  valign='top'>&nbsp;</td>");
		out.print("<td  class='boldEleven'  valign='top'>&nbsp;</td>");
		out.print("<td  class='boldEleven'  valign='top'>&nbsp;</td>");
		out.print("<td  class='boldEleven'  valign='top' align='right'>&nbsp;</td>");
		out.print("<td  class='boldEleven'  valign='top' align='right'>&nbsp;</td>");
		out.print("<td  class='boldEleven'  valign='top' align='right'><img src=\"../Image/report/Rupee.gif\" width='10' height='10'>"+ sumdata[0][2] +"</td>");
		out.print("<td  class='boldEleven'  valign='top' align='right'>&nbsp;</td>");
		out.print("<td  class='boldEleven'  valign='top' align='right'><img src=\"../Image/report/Rupee.gif\" width='10' height='10'>"+ sumdata[0][4] +"</td>");
		out.print("<td  class='boldEleven' align='right'><img src=\"../Image/report/Rupee.gif\" width='10' height='10'>&nbsp;"+ sumdata[0][6] +"</td>");
		out.println("<th class='boldEleven' align='right'><img src=\"../Image/report/Rupee.gif\" width='10' height='10'>&nbsp;"+ sumdata[0][8] +"</th>");
		out.print("<td  class='boldEleven'  valign='top' align='right'>&nbsp;</td>");
		out.print("<td  class='boldEleven'  valign='top' align='right'>&nbsp;</td>");
		out.print("<td  class='boldEleven'  valign='top' align='right'>&nbsp;</td>");
		out.print("<td  class='boldEleven'  valign='top' align='right'>&nbsp;</td>");
		out.print("<td  class='boldEleven'  valign='top' align='right'><img src=\"../Image/report/Rupee.gif\" width='10' height='10'>"+ sumdata[0][5] +"</td>");
		out.print("<td  class='boldEleven'  valign='top' align='right'>&nbsp;</td>");
		 out.print("</tr>"); 	
		
		out.print("</table>");
	out.print("</div>");

		
}
	
%>														   
 						  </tr>
							 
							 
							 
							<tr>
							  <td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td colspan="3" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
								<td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="3" align="left"><input name="filename" type="hidden" value="PurchaseRequest" />
							    <input name="actionS"
									type="hidden" value="INVPurchaseRequestAdmin" />
							    <input name="Requestno" type="hidden" id="Requestno" value="<%=Requestno%>"></td>
							</tr>
							<tr>
								<td height="17" colspan="4" class="boldEleven">
								<table width="160" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit" id="Submit" type="submit"
											class="buttonbold13" value="Acknowledge"></td>
										<td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('PurchaseRequestDivision.jsp')"></td>
									</tr>
								</table>								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="3" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
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
<script language="JavaScript">

function Validate()
{
	if( checkNull( "memo","Enter Description" ))
		return true;
	else
		return false;				
		
 } 	
 
 
</script> 
<%@ include file="../footer.jsp"%></form>
</body>
</html>
<%
}
catch (Exception e) 
{
	System.out.println(e.getMessage());
	
}

%>