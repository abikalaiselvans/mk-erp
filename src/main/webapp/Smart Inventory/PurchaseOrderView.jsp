<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
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
 <body >
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
					<%	
		   	try
			{
			  	String purchaseno=request.getParameter("ponumber");
				String sql = "SELECT * FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
				
				boolean flag = false;
				flag = com.my.org.erp.common.CommonInfo.RecordExist(sql);
				if(flag)
				{
					sql = " SELECT a.CHR_PURCHASEORDERNO,b.CHR_VENDORNAME, ";
					sql = sql+ " DATE_FORMAT(a.DAT_ORDERDATE,'%d-%b-%Y'),DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%b-%Y'), ";
					sql = sql+ " d.CHR_PAYMENTNAME,c.CHR_PAYMENTNAME, ";
					sql = sql+ " ( SELECT e.CHR_BRANCHNAME FROM  com_m_branch e WHERE e.INT_BRANCHID= a.INT_ADDRESSID1), ";
					sql = sql+ " ( SELECT f.CHR_BRANCHNAME FROM  com_m_branch f WHERE f.INT_BRANCHID= a.INT_ADDRESSID2) , ";
					sql = sql+ " a.CHR_DES,FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF),a.DOU_AMOUNT,a.CHR_DISCOUNT,";
					sql = sql+ "  h.CHR_TAXNAME,h.DOU_VALUE,a.DOU_TAXAMOUNT,a.DOU_TOTALAMOUNT,a.INT_VENDORID,a.DOU_FRIEGHT_CHARGE";
					sql = sql+ "  FROM inv_t_vendorpurchaseorder a, inv_m_vendorsinformation b,inv_m_paymentterms c, ";
					sql = sql+ " inv_m_paymentcondition d, inv_m_tax h ";
					sql = sql+ " WHERE a.INT_VENDORID = b.INT_VENDORID ";
					sql = sql+ " AND a.INT_PAYMENTTERMID =c.INT_PAYMENTTERMID ";
					sql = sql+ " AND a.INT_CONDITIONID =d.INT_PAYMENTCONDITIONID ";
					sql = sql+ " AND a.INT_TAXID = h.INT_TAXID ";
					sql = sql+ " AND a.CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					//out.println(sql);
				    String purchaseData[][]=CommonFunctions.QueryExecute(sql);
		  %>
					<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm">
					<table width="663" border="0" align="center" cellpadding="1"
						cellspacing="1">
						<tr>
							<td width="650"></td>
						</tr>
						<tr>
							<td>
							<div align="center" class="copyright">Purchase Order View</div>
							</td>
						</tr>
						<tr>
							<td valign="bottom">
							<table width="668" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="123" align="left" valign="top" class="boldEleven">
									<div align="left">Purchase Order No</div>
								  </td>
									<td width="198" align="left" valign="top" class="boldEleven"> <%=purchaseData[0][0]%></td>
									<td width="102" align="left" valign="top" class="boldEleven">
									<div align="left">Payment Mode</div>
								  </td>
									<td width="237" align="left" valign="top" class="boldEleven">
								     <%=purchaseData[0][4]%>									</td>
								</tr>
								<tr>
									<td align="left" valign="top" class="boldEleven">
									<div align="left">Vendor</div>
								  </td>
									<td align="left" valign="top" class="boldEleven">
								     <%
						 	sql =" SELECT  a.CHR_VENDORNAME,a.CHR_ADDRESS1,a.CHR_ADDRESS2, ";
							sql = sql + " e.CHR_CITYNAME,d.CHR_DISTRICT,  ";
							sql = sql + " c.CHR_STATENAME,   CONCAT('PIN :',a.INT_PINCODE),CONCAT('MOBILE :',a.CHR_MOBILE),   ";
							sql = sql + " a.CHR_PHONE,a.CHR_EMAIL     ";
							sql = sql + " FROM  inv_m_vendorsinformation a, com_m_country b,com_m_state c,com_m_district d,  ";
							sql = sql + " com_m_city e  ,inv_m_vendorsgroup f   ";
							sql = sql + " WHERE a.INT_GROUPID = f.INT_GROUPID  ";
							sql = sql + " AND a.INT_COUNTRYID = b.INT_COUNTRYID   "; 
							sql = sql + " AND a.INT_STATEID =c.INT_STATEID     ";
							sql = sql + " AND a.INT_DISTRICTID= d.INT_DISTRICTID  ";
							sql = sql + " AND a.INT_CITYID =e.INT_CITYID AND INT_VENDORID="+purchaseData[0][16];  
							String vendor[][]=CommonFunctions.QueryExecute( sql);
out.println("<b>"+vendor[0][0]+"</b>,<br>");
							 
							if(!"-".equals(vendor[0][1]))
								out.println(vendor[0][1]+",<br>");
							if(!"-".equals(vendor[0][2]))	
								out.println(vendor[0][2]+",<br>");
							if(!"-".equals(vendor[0][3]))
								out.println(vendor[0][3]+",<br>");
							if(!"-".equals(vendor[0][4]))
								out.println(vendor[0][4]+".<br>"); 
							if(!"-".equals(vendor[0][5]))
								out.println(vendor[0][5]+".<br>"); 
							if(!"-".equals(vendor[0][6]))
								out.println(vendor[0][6]+".<br>"); 
								         	
						%>									</td>
									<td align="left" valign="top" class="boldEleven">
									<div align="left">Payment Terms</div>
								  </td>
									<td align="left" valign="top" class="boldEleven">
								     <%=purchaseData[0][5]%>									</td>
								</tr>
								<tr>
									<td align="left" valign="top" class="boldEleven">
									<div align="left">Order Date</div>
								  </td>
									<td align="left" valign="top" class="boldEleven">
								     <%=purchaseData[0][2]%>									</td>
									<td align="left" valign="top" class="boldEleven">
									<div align="left">Order From</div>
								  </td>
									<td align="left" valign="top" class="boldEleven">
								     <%=purchaseData[0][6]%>									</td>
								</tr>
								<tr>
									<td align="left" valign="top" class="boldEleven">
									<div align="left">Request Date</div>
								  </td>
									<td align="left" valign="top" class="boldEleven">
								     <%=purchaseData[0][3]%>									</td>
									<td align="left" valign="top" class="boldEleven">
									<div align="left">Shipping To</div>
								  </td>
									<td align="left" valign="top" class="boldEleven">
								     <%=purchaseData[0][7]%>									</td>
								</tr>
								<tr>
									<td align="left" valign="top" class="boldEleven">
									<div align="left">On Hold</div>
								  </td>
									<td align="left" valign="top" class="boldEleven">
									<%
					sql = "SELECT INT_ONHOLD FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					if("1".equals(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "INT_ONHOLD").trim()))
						out.println("On Hold");
					else
						out.println("-");
					%>
								  </td>
									<td align="left" valign="top" class="boldEleven">&nbsp;</td>
									<td align="left" valign="top" class="boldEleven">&nbsp;</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td>
							 <%
			  
				 sql = " SELECT  ";
				sql = sql + "  if(a.CHR_TYPE='I','Item','Product'),  ";
				sql = sql + "  if(a.CHR_TYPE='I',  ";
				sql = sql + "  (SELECT b.CHR_ITEMNAME FROM inv_m_item b WHERE b.CHR_ITEMID=a.CHR_ITEMID)  ";
				sql = sql + "  ,  ";
				sql = sql + "  (SELECT c.CHR_PRODUCTCODE  FROM inv_m_produtlist  c WHERE c.CHR_PRODUCTID=a.CHR_ITEMID)  ";
				sql = sql + "  ),  ";
				sql = sql + "  if(a.CHR_TYPE='I',  ";
				sql = sql + "  (SELECT d.CHR_DES FROM inv_m_item d WHERE d.CHR_ITEMID=a.CHR_ITEMID)  ";
				sql = sql + "  ,  ";
				sql = sql + "  (SELECT e.CHR_PRODUCTDESC  FROM inv_m_produtlist  e WHERE e.CHR_PRODUCTID=a.CHR_ITEMID)  ";
				sql = sql + "  ),  ";
				sql = sql + " a.INT_QUANTITY, a.DOU_UNITPRICE,a.CHR_DISCOUNT,a.DOU_UNITDISCOUNT, b.CHR_TAXNAME,a.DOU_TAX_PERCENTAGE,a.DOU_TAX_AMOUNT,a.DOU_TOTAL ";
				sql = sql +" From  inv_t_vendorpurchaseorderitem a ,inv_m_tax b WHERE  a.INT_TAXID =b.INT_TAXID AND a.CHR_PURCHASEORDERNO ='"+purchaseno+"'";

				//out.println(sql);
				String itemData[][]= CommonFunctions.QueryExecute(sql);
				out.print("<table width='100%' class='boldEleven'  id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
				out.print("<tr class='MRow1'>");
				out.print("<td  class='boldEleven'><b>S.No</b></td>");
				out.print("<td  class='boldEleven'><b>Type</b></td>");
				out.print("<td  class='boldEleven'><b>Item / Product</b></td>");
          		out.print("<td  class='boldEleven'><b>Description</b></td>");
                out.print("<td  class='boldEleven'><b>Quantity</b></td>");
                out.print("<td  class='boldEleven'><b>Unit Price</b></td>");
                out.print("<td  class='boldEleven'><b>Discount(%)</b></td>");
                out.print("<td  class='boldEleven'><b>Unit Discount</b></td>");
                out.print("<td  class='boldEleven'><b>Tax</b></td>");
				out.print("<td  class='boldEleven'><b>Tax [ % ]</b></td>");
				out.print("<td  class='boldEleven'><b>Tax Amount</b></td>");
				out.print("<td  class='boldEleven'><b>Total</b></td>");
				out.print("</tr>");
				for(int u=0; u<itemData.length;u++)
				{
					
					if(u%2==0)
						out.print("<tr class='MRow1'>");
					else
						out.print("<tr class='MRow2'>");	
						
					out.print("<td class='boldEleven'>"+(u+1)+"</td>");	
					out.print("<td class='boldEleven'>"+itemData[u][0]+"</td>");
					out.print("<td class='boldEleven'>"+itemData[u][1]+"</td>");
					out.print("<td class='boldEleven'>"+itemData[u][2]+"</td>");
                	out.print("<td class='boldEleven'>"+itemData[u][3]+"</td>");
                	out.print("<td class='boldEleven'>"+itemData[u][4]+"</td>");
                	out.print("<td class='boldEleven'>"+itemData[u][5]+"</td>");
                	out.print("<td class='boldEleven'>"+itemData[u][6]+"</td>");
                	out.print("<td class='boldEleven'>"+itemData[u][7]+"</td>");
					out.print("<td class='boldEleven'>"+itemData[u][8]+"</td>");
					out.print("<td class='boldEleven'>"+itemData[u][9]+"</td>");
					out.print("<td class='boldEleven'>"+itemData[u][10]+"</td>");
					
					out.print("</tr>");
				}
				
				out.print("</table>");
			   
			  %>
							</td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td valign="top" class="boldEleven">
							<table width="688" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="114" rowspan="4" valign="top" class="boldEleven">
									<div align="left">Description</div>									</td>
									<td width="200" rowspan="4" valign="top" class="boldEleven">
									<div style="OVERFLOW:auto;width:200px;height:100px"
										class="boldEleven">
									  <span class="boldEleven" style="OVERFLOW:auto;width:200px;height:100px"><%=purchaseData[0][8]%></span>									</div>									</td>
									<td width="107" valign="top" class="boldEleven">
									<div align="left">Total</div>									</td>
								    <td valign="top" class="boldEleven" id="tax1"><div align="right"> <%=purchaseData[0][10]%> </div></td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Total Discount (%)</div>									</td>
								    <td valign="top" class="boldEleven" id="tax1"><div align="right"><%=purchaseData[0][11]%></div></td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Tax Group</div>									</td>
									<td valign="top" class="boldEleven" id="tax1"><div align="right"><strong><%=purchaseData[0][12]%></strong></div></td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Sales Tax (%)</div>									</td>
								    <td width="129" valign="top" class="boldEleven" id="tax1"><div align="right"><%=purchaseData[0][13]+" %"%></div></td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left"></div>									</td>
									<td class="boldEleven">&nbsp;</td>
									<td class="boldEleven">
									<div align="left">Sales Tax Amount</div>									</td>
								    <td width="129" class="boldEleven" id="salestaxamount1"><div align="right"><%=purchaseData[0][14]%></div></td>
								</tr>
								<tr>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">Freight Charge</td>
								  <td class="boldEleven" width="129" id="nettotal1"><div align="right"></div>
							      <div align="right"> <%=purchaseData[0][17]%> </div></td>
							  </tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Reference <input name="filename"
										type="hidden" value="PurchaseOrder" /> <input name="actionS"
										type="hidden" value="INVPurchaseOrderView" /> <input
										name="purchaseno" type="hidden" id="ponumber"
										value="<%=purchaseno%>"></div>									</td>
									<td class="boldEleven">
										<span class="boldEleven" style="OVERFLOW:auto;width:200px;height:100px"><%=purchaseData[0][9]%></span> </td>
									<td class="boldEleven">
									<div align="left">Net Total</div>									</td>
								    <td width="129" class="boldEleven" id="nettotal1"><div align="right"> <%=purchaseData[0][15]%> </div></td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<table border="0" align="center" cellpadding="1"
										cellspacing="1">
										<tr>
											<td width="56"><input name="Submit" type="submit"
												class="buttonbold" value="Accept" /></td>
											<td width="56"><input name="Submit" type="submit"
												class="buttonbold" value="Denied" /></td>
											<td width="56"><input type="button" class="buttonbold"
												onClick="javascript:history.back(2)"  value="Close"   accesskey="c"  /></td>
										</tr>
									</table>									</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<div align="center"></div>									</td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</form>
					<%
		  	}
			else
			{
				response.sendRedirect("Purchase Order.jsp");
				out.print("<center><font color='red'> Record not found</font></center>");
			}
		}
		catch(Exception e)
		{
			out.print(e.getMessage());
		}
		
		
		  %>
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
