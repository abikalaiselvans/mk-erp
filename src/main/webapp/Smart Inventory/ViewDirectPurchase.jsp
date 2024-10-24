<%@ page import="java.io.*,java.util.*"%>
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
	sql ="select INT_BRANCHID,CHR_PURCHASEORDERNO,INT_VENDORID,DAT_ORDERDATE,INT_PAYMENTTERMID ";
	sql = sql +",CHR_DES,CHR_REF,DOU_AMOUNT,DOU_DISCOUNT,INT_TAXID,DOU_TAXAMOUNT,DOU_TOTALAMOUNT, ";
	sql = sql +" DOU_PAIDAMOUNT,CHR_PAYMENTSTATUS,INT_DIVIID,CHR_VENDORPO from inv_t_directpurchase WHERE CHR_PURCHASEORDERNO ='"+salesid+"'";
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
									<div align="left"><strong>Ref. No. </strong></div>
									</td>
									<td width="229" valign="top" class="boldEleven">
									<div align="left"><%=cashdata[0][1]%> <input
										name="ponumber" type="hidden" id="ponumber"
										value="<%=cashdata[0][1]%>"></div>
									</td>
									<td width="150" valign="top" class="boldEleven"><strong>Purchase
									Date </strong></td>
									<td width="217" valign="top" class="boldEleven"><%=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(cashdata[0][3])%></td>
								</tr>

								<tr>
									<td valign="top" class="boldEleven"><strong>Division</strong></td>
									<td valign="top" class="boldEleven">
									<%
						String vsql = "SELECT  CHR_DIVICODE FROM inv_m_division WHERE INT_DIVIID="+cashdata[0][14].trim() ;
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
			%>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven"><strong>Vendor Name &amp;
									Address </strong></td>
									<td valign="top" class="boldEleven">
									<%
						 
							
							sql="SELECT a.INT_CUSTOMERID,f.CHR_NAME,a.CHR_CONTACTPERSON, e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME,  CONCAT('PIN :',a.INT_PINCODE),CONCAT('MOBILE :',a.CHR_MOBILE),CONCAT('Phone :',a.CHR_PHONE),CONCAT('E-Mail :',a.CHR_EMAIL) FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f   WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   AND a.INT_COUNTRYID = b.INT_COUNTRYID    AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID   AND a.INT_CITYID =e.INT_CITYID AND   a.INT_CUSTOMERID="+cashdata[0][2];
String vendor[][]=CommonFunctions.QueryExecute(sql);
						 
						
						
						if(!"-".equals(vendor[0][1]))
							out.println(vendor[0][1]+",<br>");
						if(!"-".equals(vendor[0][2]))	
							out.println(vendor[0][2]+",<br>");
						if(!"-".equals(vendor[0][3]))
							out.println(vendor[0][3]+".");
							
						%>
									
									<td valign="top" class="boldEleven"><strong>Vendor Ref.No </strong></td>
									<td valign="top" class="boldEleven"><%=cashdata[0][15]%></td>
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
									<td class="boldEleven" valign="top"><b>Total</b></td>
									<%
						  
	 	String iname="";
		String itemname="";
		String itemcolor="";
		String iitype=""; 
						  
		 sql ="SELECT CHR_PURCHASEORDERNO,CHR_ITEMID,CHR_TYPE,CHR_DESC,INT_QUANTITY,DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,DOU_TOTAL FROM inv_t_directpurchaseitem WHERE CHR_PURCHASEORDERNO='"+salesid+"'";
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
			if(itemDatas[u][2].equals("I"))
			{
				iname="Item";
				sql = "SELECT CHR_ITEMNAME ,INT_STOCKINHAND FROM inv_m_item WHERE CHR_ITEMID='"+itemDatas[u][1]+"'";
				itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
				sql ="SELECT INT_STOCKINHAND FROM inv_t_stock WHERE CHR_ITEMID  = '"+itemDatas[u][1]+"' AND CHR_TYPE='I' AND INT_BRANCHID="+branchid;					
				stock = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "INT_STOCKINHAND");
				ptypes="";
			}	
			if(itemDatas[u][2].equals("P"))
			{
			  iname="Product";
			  sql= "SELECT CHR_PRODUCTCODE ,INT_STOCKINHAND,CHR_PTYPE FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+itemDatas[u][1]+"'";
			  ptypes=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PTYPE");
			  itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
			  sql ="SELECT INT_STOCKINHAND FROM inv_t_stock WHERE CHR_ITEMID  = '"+itemDatas[u][1]+"' AND CHR_TYPE='P' AND INT_BRANCHID="+branchid;	
			  stock = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "INT_STOCKINHAND");
			  
			}	
			out.print("<td   class='boldEleven'  valign='top'>"+(u+1)+"</td>");
			out.print("<td   class='boldEleven'  valign='top'>"+iname+"</td>");
			out.print("<td  class='boldEleven'   valign='top'>"+itemname);
			out.print("<td  class='boldEleven'  valign='top' align='right'>"+itemDatas[u][3]);
			out.print("<td  class='boldEleven'  valign='top' align='right'>"+itemDatas[u][4]+"</td>");
            out.print("<td  class='boldEleven'  valign='top' align='right'>"+itemDatas[u][5]+"</td>");
            out.print("<td  class='boldEleven'  valign='top' align='right'>"+itemDatas[u][6]+"</td>");
            out.print("<td  class='boldEleven'  valign='top' align='right'>"+itemDatas[u][7]+"</td>");
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
									
								String link="";
								link = "Serialnumberupdate.jsp?rowid="+stockdata[u][4];
								link=link+"&itype="+stockdata[u][0]+"&itemid="+stockdata[u][1]+"&refno="+goodsRecNo;
								
								if("Y".equals(stockdata[u][5])) 
									out.println("<td class='boldEleven'>Sold");
								else
								{	
									if("D".equals(stockdata[u][6]))
									 out.println("<td class='boldEleven'><a href='"+link+"'><font class='boldgreen'>Update</font>");
									else
									 out.println("<td class='boldEleven'>Stock Transfered</td>");	 
										
								}	
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
									<div align="left"><%=cashdata[0][6]%></div>
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
</html>
<%
}
catch(Exception e){
	//System.out.println("Error :"+e.getMessage());
}
%>
