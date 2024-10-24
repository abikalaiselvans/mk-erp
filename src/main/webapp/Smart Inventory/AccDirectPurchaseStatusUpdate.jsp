<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenAJAX.js"></script>
<script language="javascript">
function validate()
{
	if(	checkNull("desc","Enter Description"))
		return true;	
	else
		return false;	
}
</script>
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
</head>
<%
try{
	String goodsRecNo=""+request.getParameter("gdreceiveno");
	
	if("null".equals(goodsRecNo))
		response.encodeRedirectURL("GoodsRecived.jsp");
	
	String sql ="";
	boolean sflag = false;
	sql ="SELECT count(*) FROM inv_t_vendorgoodsreceived where CHR_RECIVEDID='"+goodsRecNo+"'";
	if(CommonInfo.RecordExist(sql))
	{
		sql="SELECT CHR_PURCHASEORDERNO,CHR_RECIVEDID,DAT_RECIVEDDATE,CHR_RECIVEDBY,CHR_DELIVARYNO,CHR_INVOICENO,CHR_RECEIVEDMODE ";
		sql=sql+" FROM inv_t_vendorgoodsreceived where CHR_RECIVEDID='"+goodsRecNo+"'";
		String goodsRecValue[][]=CommonFunctions.QueryExecute(sql);
		sflag =true;
	}	
	
	String salesid = goodsRecNo;
	sql ="select INT_BRANCHID,CHR_PURCHASEORDERNO,INT_VENDORID,DAT_ORDERDATE,INT_PAYMENTTERMID ";
	sql = sql +",CHR_DES,CHR_REF,DOU_AMOUNT,DOU_DISCOUNT,INT_TAXID,DOU_TAXAMOUNT,DOU_TOTALAMOUNT, ";
	sql = sql +" DOU_PAIDAMOUNT,CHR_PAYMENTSTATUS,INT_DIVIID,CHR_ACCOUNTFLAG,CHR_ACCOUNTDESC, CHR_VENDORPO from inv_t_directpurchase WHERE CHR_PURCHASEORDERNO ='"+salesid+"'";
	
	sql ="select INT_BRANCHID,CHR_PURCHASEORDERNO,INT_VENDORID,DATE_FORMAT(DAT_ORDERDATE,'%d-%b-%Y'),INT_PAYMENTTERMID ";
	sql = sql +",CHR_DES,FIND_A_EMPLOYEE_ID_NAME(CHR_REF),DOU_AMOUNT,DOU_DISCOUNT,INT_TAXID,DOU_TAXAMOUNT,DOU_TOTALAMOUNT, ";
	sql = sql +" DOU_PAIDAMOUNT,CHR_PAYMENTSTATUS,INT_DIVIID,CHR_ACCOUNTFLAG,CHR_ACCOUNTDESC, CHR_VENDORPO,CHR_POREQUESTNO from inv_t_directpurchase WHERE CHR_PURCHASEORDERNO ='"+salesid+"'";
	
	String branchid = session.getAttribute("BRANCHID").toString();
	String cashdata[][] = CommonFunctions.QueryExecute(sql);
	
%>
<body >

<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm"
	onSubmit="return validate()"><%@ include file="indexinv.jsp"%>
<div align="center"><br />
<table width="100%" border="0" cellspacing="1" cellpadding="1">
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
					<table width="663" border="0" align="center" cellpadding="1"
						cellspacing="1">

						<tr>
							<td width="650"></td>
						</tr>
						<tr>
							<td align="center" class="bolddeeplogin">
							<div align="center">Direct Purchase Orders</div>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td>
							<table width="673" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="150" valign="top" class="boldEleven">
									<div align="left"><strong>Direct Purchase No. </strong></div>									</td>
									<td width="229" valign="top" class="boldEleven">
									<div align="left"><%=cashdata[0][1]%> <input
										name="ponumber" type="hidden" id="ponumber"
										value="<%=cashdata[0][1]%>"></div>									</td>
									<td width="150" valign="top" class="boldEleven"><strong>Purchase
									Date </strong></td>
									<td width="217" valign="top" class="boldEleven"><%=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(cashdata[0][3])%></td>
								</tr>

								<tr>
									<td valign="top" class="boldEleven"><strong>Division</strong></td>
									<td valign="top" class="boldEleven">
									<%
						String vsql = "SELECT  CHR_DIVICODE FROM inv_m_division WHERE INT_DIVIID="+cashdata[0][4].trim() ;
						out.print(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(vsql, "CHR_DIVICODE"));
						%>
									<td valign="top" class="boldEleven"><strong>Payment
									Terms</strong></td>
									<td valign="top" class="boldEleven">
									<%
			
			String paymentids[][] =  CommonFunctions.QueryExecute("Select INT_PAYMENTTERMID,CHR_PAYMENTNAME from inv_m_paymentterms");
			String pid = cashdata[0][4].trim();			
			for(int u=0; u<paymentids.length; u++)
			{
				if(pid.equals(paymentids[u][0]))
					out.print(paymentids[u][1]);
				
						
			}	
			%>									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven"><strong>Vendor
									Address </strong></td>
									<td valign="top" class="boldEleven">
									 
						<%
									
									 sql =" SELECT  a.CHR_VENDORNAME,a.CHR_CONTACTPERSON,a.CHR_ADDRESS1,a.CHR_ADDRESS2, ";
sql = sql + " e.CHR_CITYNAME,d.CHR_DISTRICT,  ";
sql = sql + " c.CHR_STATENAME,   CONCAT('PIN :',a.INT_PINCODE),CONCAT('MOBILE :',a.CHR_MOBILE),   ";
sql = sql + " a.INT_ACTIVE,a.CHR_PHONE,a.CHR_EMAIL     ";
sql = sql + " FROM  inv_m_vendorsinformation a, com_m_country b,com_m_state c,com_m_district d,  ";
sql = sql + " com_m_city e  ,inv_m_vendorsgroup f   ";
sql = sql + " WHERE a.INT_GROUPID = f.INT_GROUPID  ";
sql = sql + " AND a.INT_COUNTRYID = b.INT_COUNTRYID   "; 
sql = sql + " AND a.INT_STATEID =c.INT_STATEID     ";
sql = sql + " AND a.INT_DISTRICTID= d.INT_DISTRICTID  ";
sql = sql + " AND a.INT_CITYID =e.INT_CITYID AND INT_VENDORID="+cashdata[0][2];  
String vendor[][]=CommonFunctions.QueryExecute( sql);
out.println(vendor[0][0]);           	



						 
						out.println(vendor[0][0]+",<br>");
						if(!"-".equals(vendor[0][1]))
							out.println(vendor[0][1]+",<br>");
						if(!"-".equals(vendor[0][2]))	
							out.println(vendor[0][2]+",<br>");
						if(!"-".equals(vendor[0][3]))
							out.println(vendor[0][3]+",<br>");
						if(!"-".equals(vendor[0][4]))
							out.println(vendor[0][4]+".<br>");
						%>
									<td valign="top" class="boldEleven"><strong>Customer Name </strong></td>
									<td valign="top" class="boldEleven"><%
if(!"-".equals(cashdata[0][18]))
{
	sql="SELECT FUN_GET_CUSTOMER_ADDRESS(INT_CUSTOMERID,'<br>') FROM inv_t_purchaserequest WHERE CHR_POREQUESTNO='"+cashdata[0][18]+"'";
	out.println(CommonFunctions.QueryExecute(sql)[0][0]);
}	
%></td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven"><strong>Vendor Ref.No </strong></td>
									<td valign="top" class="boldEleven"><%=cashdata[0][17]%>
									<td valign="top" class="boldEleven"><strong>Account
									Dept Status</strong></td>
									<td valign="top" class="boldEleven">
								<%
						if("Y".equals(cashdata[0][15]))
							out.println("<input name=\"flag\" type=\"checkbox\" id=\"flag\" value=\"Y\" checked>");
						else
							out.println("<input name=\"flag\" type=\"checkbox\" id=\"flag\" value=\"Y\" >");
						%>								</tr>
								<tr>
								  <td valign="top" class="boldEleven"><strong>Purchase Request No </strong></td>
								  <td valign="top" class="boldEleven"><%=cashdata[0][18]%></td>
								  <td valign="top" class="boldEleven"><strong>Description</strong></td>
								  <td valign="top" class="boldEleven"><textarea name="desc"
										cols="25" rows="5" id="desc">Received<%=cashdata[0][16]%></textarea></td>
							  </tr>
								<tr>
								  <td valign="top" class="boldEleven">&nbsp;</td>
								  <td valign="top" class="boldEleven">                                
								  <td valign="top" class="boldEleven">&nbsp;</td>
								  <td valign="top" class="boldEleven">&nbsp;</td>
							  </tr>
							</table>
							</td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td>
							<table width="100%" border="1" cellpadding="1" cellspacing="1">
								<tr>
									<td height="23" class="boldEleven"><b>S.No</b></td>
									<td height="23" class="boldEleven"><b>Type</b></td>
									<td height="23" class="boldEleven"><b>Item</b></td>
									<td class="boldEleven"><b>Description</b></td>
									<td class="boldEleven"><b>Quantity/Unit</b></td>
									<td class="boldEleven"><b>Unit Price</b></td>
									<td class="boldEleven"><b>Discount(%)</b></td>
									<td class="boldEleven"><b>Unit Discount</b></td>
                                    <td class="boldEleven"><b>Tax</b></td>
                                    <td class="boldEleven"><b>Tax Amount</b></td>
									<td class="boldEleven" valign="top"><b>Total</b></td>
									<%
						  
	 	String iname="";
		String itemname="";
		String itemcolor="";
		String iitype=""; 
						  
		sql ="SELECT CHR_PURCHASEORDERNO,CHR_ITEMID,CHR_TYPE,CHR_DESC, INT_QUANTITY,DOU_UNITPRICE, DOU_DISCOUNT,DOU_UNITDISCOUNT, ";
		sql = sql + " DOU_TOTAL,IF(CHR_TYPE ='I','Item','Product'),FUN_INV_PRODUCTCODE(CHR_TYPE,CHR_ITEMID), ";
		sql = sql + " FUN_GET_TAX_NAME(INT_TAXID),DOU_TAX_AMOUNT "; 
		sql = sql + " FROM inv_t_directpurchaseitem WHERE CHR_PURCHASEORDERNO='"+salesid+"'";
		//out.println(sql);
		String itemDatas[][] = CommonFunctions.QueryExecute(sql);
		
		int lens = itemDatas.length;
		iname="";
		itemname="";
		String stock="";
		String ptypes="";
		for(int u=0;u<itemDatas.length;u++)
		{
			
			out.print("<tr>");
			out.print("<td  class='boldEleven'  valign='top'>"+(u+1)+"</td>");
			out.print("<td  class='boldEleven'  valign='top'>"+itemDatas[u][9]+"</td>");
			out.print("<td  class='boldEleven'   valign='top'>"+itemDatas[u][10]+"</td>");
			out.print("<td  class='boldEleven'  valign='top' align='right'>"+itemDatas[u][3]+"</td>");
			out.print("<td  class='boldEleven'  valign='top' align='right'>"+itemDatas[u][4]+"</td>");
            out.print("<td  class='boldEleven'  valign='top' align='right'>"+itemDatas[u][5]+"</td>");
            out.print("<td  class='boldEleven'  valign='top' align='right'>"+itemDatas[u][6]+"</td>");
            out.print("<td  class='boldEleven'  valign='top' align='right'>"+itemDatas[u][7]+"</td>");
			out.print("<td  class='boldEleven'  valign='top' align='right'>"+itemDatas[u][11]+"</td>");
			out.print("<td  class='boldEleven'  valign='top' align='right'>"+itemDatas[u][12]+"</td>");
            out.print("<td  class='boldEleven'  valign='top' align='right'>"+itemDatas[u][8]+"</td>");
				
		}		
	%>
								
							</table>
							</td>
						</tr>

						<tr>
							<td>
							<%
					  	
						sql = " select CHR_TYPE , CHR_ITEMID ,CHR_SERIALNO, CHR_WARRANTY,INT_ID,CHR_FLAG,CHR_RECEIVEDMODE,CHR_QUALITY from inv_t_vendorgoodsreceived ";
						sql = sql +" WHERE CHR_PURCHASEORDERNO = '"+goodsRecNo+"' ";
						sql = sql +" and CHR_RECIVEDID='"+goodsRecNo+"'";
						//out.println(sql);
						itemcolor="";
						String stockdata[][] = com.my.org.erp.common.CommonInfo.RecordSetArray(sql);
						
						
						if(stockdata.length>0)
						{
							out.println("<table width='686'  border='0' bordercolor='Beige' cellspacing=2 cellpadding=2 >");
							out.println("<tr><td class='boldEleven'><b>S.No</b><td class='boldEleven'><b>Type<td class='boldEleven'><b>Item Name<td class='boldEleven'><b>Serial Number<td  class='boldEleven'><b>Waranty</b><td  class='boldEleven'><b>Status</b><td  class='boldEleven'><b>&nbsp;</b>");
							
							for(int u=0; u<stockdata.length;u++)
							{
								
								if(stockdata[u][0].equals("I"))
								{
									iname="Item";
									sql = "SELECT CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID='"+stockdata[u][1]+"'";
									itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
									itemcolor="MRow3";
								}	
								if(stockdata[u][0].equals("P"))
								{
									iname="Product";
									sql = "SELECT CHR_PRODUCTCODE FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+stockdata[u][1]+"'";
									itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
									itemcolor="MRow4";
								}	
								out.println("<tr class='"+itemcolor+"'>");
								out.println("<td class='boldEleven'>"+(u+1)+"</td>");
								out.println("<td class='boldEleven'>"+iname+"</td>");
								out.println("<td class='boldEleven'>"+itemname+"</td>");
								out.println("<td class='boldEleven'>"+stockdata[u][2]);
								out.println("<td class='boldEleven'>"+stockdata[u][3]+" - Years" );
								if("Y".equals(stockdata[u][7])) 
									out.println("<td class='boldEleven'>Good");
								else
									out.println("<td class='boldEleven'>Fault");
									
								
							}	
							out.println("</table>");
						}
						
					  %> <input name="seriallength" type="hidden" id="seriallength"
								value="<%=stockdata.length%>"></td>
						</tr>
						<tr>
							<td>
							<table width="688" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="114" rowspan="4" valign="top" class="boldEleven"><strong>Description</strong></td>
									<td width="197" rowspan="4" valign="top" class="boldEleven"><%=cashdata[0][5]%></td>
									<td width="107" valign="top" class="boldEleven">
									<div align="left"><strong>Total</strong></div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="totals1">
									<div align="right"><%=cashdata[0][7]%></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left"><strong>Total Discount (%) </strong></div>
									</td>
									<td width="169" valign="top" class="boldEleven"
										id="totaldiscount1">
									<div align="right"><%=cashdata[0][8]%></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left"><strong>Tax Group </strong></div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="tax1">
									<div align="right">
									<%
	String taxids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME ,DOU_VALUE from inv_m_tax");
		String tid =  cashdata[0][9];
		for(int u=0; u<taxids.length; u++)
		{
			if(tid.trim().equals(taxids[u][0]))
				out.print(taxids[u][1]);
			
		}		
	%>
									</div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left"><strong>Sales Tax (%) </strong></div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="salestax1">
									<div align="right">
									<%
  String taxs[][] = com.my.org.erp.common.CommonInfo.RecordSetArray("Select DOU_VALUE from inv_m_tax WHERE INT_TAXID ="+tid);
  %> <%=taxs[0][0]%></div>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left"><strong>Reference </strong></div>
									</td>
									<td class="boldEleven">
									<div align="left"><%=cashdata[0][6]%> <input
										name="filename" type="hidden" id="filename" value="Account">
									<input name="actionS" type="hidden" id="actionS"
										value="INVDirectDCUpdate"> <input name="pono"
										type="hidden" id="pono" value="<%=goodsRecNo%>"></div>
									</td>
									<td class="boldEleven">
									<div align="left"><strong>Sales Tax Amount </strong></div>
									</td>
									<td width="169" class="boldEleven" id="salestaxamount1">
									<div align="right"><%=cashdata[0][10]%></div>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left"></div>
									</td>
									<td class="boldEleven">
									<div align="left"></div>
									</td>
									<td class="boldEleven">
									<div align="left"><strong>Net Total </strong></div>
									</td>
									<td width="169" class="boldEleven" id="nettotal1">
									<div align="right"><%=cashdata[0][11]%></div>
									</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td>
							<div align="center" id="Rupees"><script
								language="javascript">
							numberWord("<%=cashdata[0][11]%>","Rupees") 
						  </script></div>
							</td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td valign="top" class="boldEleven">
							<div align="center">
							<table width="112" border="0" cellspacing="2" cellpadding="2">
								<tr>
									<td><input name="Submit" type="submit"
										class="tMLAscreenHead" value="Submit"   accesskey="s"   ></td>
									<td><input name="Submit2" type="button"
										class="tMLAscreenHead"  value="Close"   accesskey="c" 
										onClick="redirect('AccountDirectPurchase.jsp')"></td>
								</tr>
							</table>
							</div>
							</td>
						</tr>
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
					<td height="6"><spacer height="1" width="1" type="block" />
					<div align="center"></div>
					</td>
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
</div>
</form>
<%@ include file="../footer.jsp"%>
</body>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
</html>
<%
}
catch(Exception e){
	//System.out.println("Error :"+e.getMessage());
}
%>
