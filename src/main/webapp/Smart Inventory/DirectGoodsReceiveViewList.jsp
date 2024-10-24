<%@ page language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenAJAX.js"></script>
<script language="javascript">
	function Print(pono)
		{
			var width="800", height="400";
			var left = (screen.width/2) - width/2;
			var top = (screen.height/2) - height/2;
			var f =document.getElementById('serial').checked;
			var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=no,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
			var f ="PrintDirectGoodsReceived.jsp?gdreceiveno="+pono +"&serialyes="+f;;
			newWindow = window.open(f,"subWind",styleStr);
			newWindow.focus( );
			
	}
	
</script>
<link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
</head>
<%
try{
	String goodsRecNo=""+request.getParameter("gdreceiveno");
	
	if("null".equals(goodsRecNo))
		response.sendRedirect("GoodsRecived.jsp");
	
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
	sql ="select INT_BRANCHID,CHR_PURCHASEORDERNO,INT_VENDORID,DATE_FORMAT(DAT_ORDERDATE,'%d-%b-%Y'),INT_PAYMENTTERMID ";
	sql = sql +",CHR_DES,FIND_A_EMPLOYEE_ID_NAME(CHR_REF),DOU_AMOUNT,DOU_DISCOUNT,INT_TAXID,DOU_TAXAMOUNT,DOU_TOTALAMOUNT, ";
	sql = sql +" DOU_PAIDAMOUNT,CHR_PAYMENTSTATUS,INT_DIVIID,CHR_VENDORPO,DOU_ROUNDED,CHR_POREQUESTNO,DOU_FRIEGHT_CHARGE_BASE_AMOUNT,DOU_FRIEGHT_CHARGE_PERCENT, DOU_FRIEGHT_CHARGE  from inv_t_directpurchase WHERE CHR_PURCHASEORDERNO ='"+salesid+"'";
	//out.println(sql);
	String branchid = session.getAttribute("BRANCHID").toString();
	String cashdata[][] = CommonFunctions.QueryExecute(sql);
	
%>
<body >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   action="" method="post" name="frm" id="frm">
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
							<div align="center">Direct Goods Received</div>
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
									<div align="left"><strong>Ref. No. </strong></div>									</td>
									<td width="229" valign="top" class="boldEleven">
									<div align="left"><%=cashdata[0][1]%> <input
										name="ponumber" type="hidden" id="ponumber"
										value="<%=cashdata[0][1]%>"></div>									</td>
									<td width="150" valign="top" class="boldEleven"><strong>Purchase
									Date </strong></td>
									<td width="217" valign="top" class="boldEleven"><%=cashdata[0][3] %></td>
								</tr>

								<tr>
									<td valign="top" class="boldEleven"><strong>Division</strong></td>
									<td valign="top" class="boldEleven">
<%=CommonFunctions.QueryExecute("SELECT  CHR_DIVICODE FROM inv_m_division WHERE INT_DIVIID="+cashdata[0][14].trim())[0][0]%>
									<td valign="top" class="boldEleven"><strong>Payment
									Terms</strong></td>
									<td valign="top" class="boldEleven">
									<%
			
			String paymentids[][] = CommonFunctions.QueryExecute("Select INT_PAYMENTTERMID,CHR_PAYMENTNAME from inv_m_paymentterms");
			String pid = cashdata[0][4].trim();			
			for(int u=0; u<paymentids.length; u++)
			{
				if(pid.equals(paymentids[u][0]))
					out.print(paymentids[u][1]);
				
						
			}	
			%>									</td>
								</tr>
								<tr>
								  <td valign="top" class="boldEleven"><strong>Vendor Ref.No </strong></td>
								  <td valign="top" class="boldEleven"><%=cashdata[0][15]%>                                
								  <td valign="top" class="boldEleven"><strong>Purchase Request No </strong></td>
								  <td valign="top" class="boldEleven"><%=cashdata[0][17]%></td>
							  </tr>
								<tr>
								  <td valign="top" class="boldEleven"><a href="DirectGoodsReceiveModified.jsp?gdreceiveno=<%=goodsRecNo%>">Change Vender Ref.no</a></td>
								  <td valign="top" class="boldEleven">                                
								  <td valign="top" class="boldEleven">&nbsp;</td>
								  <td valign="top" class="boldEleven">&nbsp;</td>
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
if(vendor.length>0)
{
	out.println(vendor[0][0]+",<br>");
	if(!"-".equals(vendor[0][1]))
		out.println(vendor[0][1]+",<br>");
	if(!"-".equals(vendor[0][2]))	
		out.println(vendor[0][2]+",<br>");
	if(!"-".equals(vendor[0][3]))
		out.println(vendor[0][3]+",<br>");
	if(!"-".equals(vendor[0][4]))
		out.println(vendor[0][4]+".<br>");
}
						%>
									<td valign="top" class="boldEleven"><strong>Customer Name </strong></td>
									<td valign="top" class="boldEleven"><%
if(!"-".equals(cashdata[0][17]))
{
	sql="SELECT FUN_GET_CUSTOMER_ADDRESS(INT_CUSTOMERID,'<br>') FROM inv_t_purchaserequest WHERE CHR_POREQUESTNO='"+cashdata[0][17]+"'";
	String PR = CommonFunctions.QueryExecute("SELECT CHR_PR_BYPASS FROM m_inventorysetting WHERE INT_ROWID=1")[0][0];
	if(PR.equals("Y"))
		out.println(CommonFunctions.QueryExecute(sql)[0][0]);
	
}	
else
{
	out.println("<b>Purchased without PR</b>");
}
%></td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td>
							
<%

sql = " SELECT if(a.CHR_TYPE='I','ITEM','PRODUCT'), ";
sql = sql + " if( ";
sql = sql + "    a.CHR_TYPE='I', ";
sql = sql + "    (SELECT b.CHR_ITEMNAME FROM inv_m_item b WHERE b.CHR_ITEMID= a.CHR_ITEMID) , ";
sql = sql + "    (SELECT c.CHR_PRODUCTCODE FROM inv_m_produtlist c WHERE c.CHR_PRODUCTID= a.CHR_ITEMID)  ";
sql = sql + " ), ";

sql = sql + " if( ";
sql = sql + "    a.CHR_TYPE='I', ";
sql = sql + "    (SELECT d.CHR_DES FROM inv_m_item d WHERE d.CHR_ITEMID= a.CHR_ITEMID) , ";
sql = sql + "    (SELECT e.CHR_PRODUCTDESC FROM inv_m_produtlist e WHERE e.CHR_PRODUCTID= a.CHR_ITEMID)  ";
sql = sql + " ), ";
sql = sql + "  a.INT_QUANTITY ,a.DOU_UNITPRICE,a.DOU_DISCOUNT,a.DOU_UNITDISCOUNT,a.DOU_TOTAL, b.CHR_TAXNAME,a.DOU_TAX_AMOUNT, ";
sql = sql + "  CONCAT(INT_WARRANTY,' - Yrs ') ";
sql = sql + " From  inv_t_directpurchaseitem a , inv_m_tax b ";
sql = sql + " WHERE a.INT_TAXID =b.INT_TAXID AND a.CHR_PURCHASEORDERNO ='"+salesid+"'";
String idata[][] = CommonFunctions.QueryExecute(sql);
if(idata.length>0)
{
	out.println("<table width='100%'  border='0' align='center'cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
	out.println("<tr class='MRow1'>");
	out.println("<td width='10%'  class='boldEleven'><b>S.No</b></td>");
	out.println("<td width='10%'  class='boldEleven'><b>Type</b></td>");
	out.println("<td width='21%'  class='boldEleven'><b>Item / Product</b></td>");
	out.println("<td width='21%'  class='boldEleven'><b>Description</b></td>");
	out.println("<td width='15%'  class='boldEleven'><b>Order Qty / Units</b></td>");
	out.println("<td width='15%'  class='boldEleven'><b>Warranty</b></td>");
	out.println("<td width='15%'  class='boldEleven'><b>Unit Price</b></td>");
	out.println("<td width='15%'  class='boldEleven'><b>Discount(%)</b></td>");
	out.println("<td width='15%'  class='boldEleven'><b>Unit Discount</b></td>");
	out.println("<td width='15%'  class='boldEleven'><b>Tax</b></td>");
	out.println("<td width='15%'  class='boldEleven'><b>Tax Amount</b></td>");
	out.println("<td width='15%'  class='boldEleven'><b>Total</b></td>");
	out.println("</tr>");
	for(int u=0; u<idata.length;u++)
	{
	
		if(u%2==0)
			out.println("<tr class='MRow1'>");
		else
			out.println("<tr class='MRow2'>");
			
		out.println("<td class='boldEleven' >"+(u+1)+".</td>");
		out.println("<td class='boldEleven'>"+idata[u][0]+"</td>");
		out.println("<td class='boldEleven'>"+idata[u][1]+"</td>");
		out.println("<td class='boldEleven' align='right'>"+idata[u][2]+"</td>");
		out.println("<td class='boldEleven' align='right'>"+idata[u][3]+"</td>");
		out.println("<td class='boldEleven' align='right'>"+idata[u][10]+"</td>");
		out.println("<td class='boldEleven' align='right'>"+idata[u][4]+"</td>");
		out.println("<td class='boldEleven' align='right'>"+idata[u][5]+"</td>");
		out.println("<td class='boldEleven' align='right'>"+idata[u][6]+"</td>");
		out.println("<td class='boldEleven' align='right'>"+idata[u][8]+"</td>");
		out.println("<td class='boldEleven' align='right'>"+idata[u][9]+"</td>");
		out.println("<td class='boldEleven' align='right'>"+idata[u][7]+"</td>");
									 
		
	}
	out.println("</table>");
}	


%>						 
							 
							</td>
						</tr>

						<tr>
							<td>
<%
sql =" SELECT if(a.CHR_TYPE='I','ITEM','PRODUCT'),  ";
sql = sql+ " if(  ";
sql = sql+ "    a.CHR_TYPE='I',  ";
sql = sql+ "    (SELECT b.CHR_ITEMNAME FROM inv_m_item b WHERE b.CHR_ITEMID= a.CHR_ITEMID) ,  ";
sql = sql+ "    (SELECT c.CHR_PRODUCTCODE FROM inv_m_produtlist c WHERE c.CHR_PRODUCTID= a.CHR_ITEMID)   ";
sql = sql+ " )   ";
sql = sql+ " ,a.CHR_SERIALNO, a.CHR_WARRANTY,a.INT_ID,a.CHR_FLAG,a.CHR_RECEIVEDMODE,a.CHR_QUALITY,a.CHR_TYPE,a.CHR_ITEMID,  ";
sql = sql+ " DATE_FORMAT(DAT_PURCHASE_WARRANTY_START,'%d-%b-%Y'),DATE_FORMAT(DAT_PURCHASE_WARRANTY_END,'%d-%b-%Y')";
sql = sql+ "  From  inv_t_vendorgoodsreceived a  WHERE a.CHR_PURCHASEORDERNO = '"+goodsRecNo+"'";
sql = sql+ " and a.CHR_RECIVEDID='"+goodsRecNo+"'";
String stockdata[][] =CommonFunctions.QueryExecute(sql);
if(stockdata.length>0)
{
	out.println("<br><br>");
	out.println("<table width='100%'  border='0' align='center'cellpadding=2 cellspacing=1 bgcolor='#9900CC'>");
	out.println("<tr class='MRow1'>");
	out.println("<td class='boldEleven'><b>S.No</b></td>");
	out.println("<td class='boldEleven'><b>Type</b></td>");
	out.println("<td class='boldEleven'><b>Item Name</b></td>");
	out.println("<td class='boldEleven'><b>Serial Number</b></td>");
	out.println("<td class='boldEleven'><b>Waranty</b></td>");
	out.println("<td class='boldEleven'><b>Start Date</b></td>");
	out.println("<td class='boldEleven'><b>End Date</b></td>");
	out.println("<td class='boldEleven'><b>Status</b></td>");
	out.println("<td class='boldEleven'><b>&nbsp;</b>");
	out.println("</tr>");
	for(int u=0; u<stockdata.length;u++)
	{
		if(u%2==0)
			out.println("<tr class='MRow1'>");
		else
			out.println("<tr class='MRow2'>");
			
		out.println("<td class='boldEleven' >"+(u+1)+".</td>");
		out.println("<td class='boldEleven'>"+stockdata[u][0]+"</td>");
		out.println("<td class='boldEleven'>"+stockdata[u][1]+"</td>");
		out.println("<td class='boldEleven' align='right'>"+stockdata[u][2]+"</td>");
		out.println("<td class='boldEleven' align='right'>"+stockdata[u][3]+" - Years</td>");
		out.println("<td class='boldEleven' >"+stockdata[u][10]+"</td>");
		out.println("<td class='boldEleven' >"+stockdata[u][11]+"</td>");
		
		if("Y".equals(stockdata[u][7])) 
			out.println("<td class='boldEleven'>Good</td>");
		else if("H".equals(stockdata[u][7])) 
			out.println("<td class='boldEleven'><font class='bolddeepred' >DC Mode</font></td>");
		else if("N".equals(stockdata[u][7])) 
			out.println("<td class='boldEleven'><font class='bolddeepred' >Fault</font></td>");
		else if("T".equals(stockdata[u][6]))
				out.println("<td class='boldEleven'>Stock Transfered</td>");	 
		else
			out.println("<td class='boldEleven'><font class='bolddeepred' >Stock Available</font></td>");	
								
								
		String link="";
		link = "Serialnumberupdate.jsp?rowid="+stockdata[u][4];
		link=link+"&itype="+stockdata[u][8]+"&itemid="+stockdata[u][9]+"&refno="+goodsRecNo;
		
		if("Y".equals(stockdata[u][5])) 
			out.println("<td class='boldEleven'>Sold</td>");
		else
		{	
			if("D".equals(stockdata[u][6]))
			 out.println("<td class='boldEleven'><a href='"+link+"'><font class='boldgreen'>Update</font></td>");
			else if("N".equals(stockdata[u][6]))
				out.println("<td class='boldEleven'>Stock </td>");	 
			else if("T".equals(stockdata[u][6]))
				out.println("<td class='boldEleven'>Stock Transfered</td>");	 
			else
			  out.println("<td class='boldEleven'>Stock Available</td>");	 
				
		}	
		 out.println("</tr>");
		 
		 
	}
	
	out.println("</table>");
}
%> <input name="seriallength" type="hidden" id="seriallength" value="<%=stockdata.length%>"></td>
						</tr>
						<tr>
							<td>
							<table width="688" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="114" rowspan="4" valign="top" class="boldEleven"><strong>Description</strong></td>
									<td width="197" rowspan="4" valign="top" class="boldEleven"><%=cashdata[0][5]%></td>
									<td width="107" valign="top" class="boldEleven">
									<div align="left"><strong>Total</strong></div>									</td>
									<td width="169" valign="top" class="boldEleven" id="totals1">
									<div align="right"><%=cashdata[0][7]%></div>									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left"><strong><!--Total Discount (%) --></strong></div>									</td>
									<td width="169" valign="top" class="boldEleven"
										id="totaldiscount1">
									<div align="right"><!--<%=cashdata[0][8]%>--></div>									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left"><strong><!--Tax Group--> </strong></div>									</td>
									<td width="169" valign="top" class="boldEleven" id="tax1">
									<div align="right">
									<!--<%
	String taxids[][] =  CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME ,DOU_VALUE from inv_m_tax");
		String tid =  cashdata[0][9];
		for(int u=0; u<taxids.length; u++)
		{
			if(tid.trim().equals(taxids[u][0]))
				out.print(taxids[u][1]);
			
		}		
	%>-->
									</div>									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left"><strong><!--Sales Tax (%) --></strong></div>									</td>
									<td width="169" valign="top" class="boldEleven" id="salestax1">
									<div align="right">
									<!--<%
  String taxs[][] = CommonFunctions.QueryExecute("Select DOU_VALUE from inv_m_tax WHERE INT_TAXID ="+tid);
  %> <%=taxs[0][0]%>--></div>									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left"><strong>Reference </strong></div>									</td>
									<td class="boldEleven">
									<div align="left"><%=cashdata[0][6]%></div>									</td>
									<td class="boldEleven">
									<div align="left"><strong><!--Sales Tax Amount--> </strong></div>									</td>
									<td width="169" class="boldEleven" id="salestaxamount1">
									<div align="right"><!--<%=cashdata[0][10]%>--></div>									</td>
								</tr>
								<tr>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven"><strong>Frieght Amount </strong></td>
								  <td class="boldEleven" id="nettotal1"><div align="right"><%=cashdata[0][20]%></div></td>
							  </tr>
								<tr>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven"><strong>Rounded </strong></td>
								  <td class="boldEleven"  width="169" id="nettotal1"><div align="right"><%=cashdata[0][16]%></div></td>
							  </tr>
								<tr>
									<td class="boldEleven">
									<div align="left"></div>									</td>
									<td class="boldEleven">
									<div align="left"></div>									</td>
									<td class="boldEleven">
									<div align="left"><strong>Net Total </strong></div>									</td>
									<td width="169" class="boldEleven" id="nettotal1">
									<div align="right"><%=cashdata[0][11]%></div>									</td>
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
							<td valign="top" class="boldEleven"><span class="boldEleven">Including
							Serial Number</span> <span class="boldEleven">with Description</span> <input
								name="serial" type="checkbox" id="serial" value=" C"></td>
						</tr>
						<tr>
							<td valign="top" class="boldEleven">
							<table width="100" border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
									<td width="56"><input name="Submit2" type="button"
										class="tMLAscreenHead" value="Print"
										onClick="Print('<%=goodsRecNo%>')" /></td>
									<td width="56"><input name="Submit2" type="button"
										class="tMLAscreenHead" value="  Close  "
										onClick="redirect('Direct Purchase.jsp')" /></td>
								</tr>
							</table>
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
catch(Exception e)
{
	System.out.println("Error :"+e.getMessage());
	out.println("Error :"+e.getMessage());
}
%>
