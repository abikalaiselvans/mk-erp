<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" errorPage="../error/index.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenAJAX.js"></script>
<script language="javascript">
<%
try{
	String goodsRecNo=request.getParameter("gdreceiveno");
%>
var ItemSerial=[
<%
String	sql=" SELECT CHR_ITEMID,CHR_SERIALNO from inv_t_vendorgoodsreceived where "+
" CHR_SERIALNO IS NOT NULL AND CHR_RECIVEDID NOT IN ('"+goodsRecNo+"')ORDER BY CHR_ITEMID";
String serialValue[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
for(int i=0;i<serialValue.length;i++)
{
	out.print("[\""+serialValue[i][0]+"\",\""+serialValue[i][1]+"\"],");
}
%>
];
	function CheckSerialNoValue(ser)	
	{		
		var txt=ser.value;
		var nam=ser.name;
		var namF=nam.substring(6);
		var valN= document.getElementById("item"+namF).value;
		var arrLen=ItemSerial.length;				
	    var found=0;
		for(i=0;i<arrLen-1;i++)
		{
			itm=ItemSerial[i][0];
			itmSer=ItemSerial[i][1];
			itmSer=itmSer.toUpperCase();
			txt=txt.toUpperCase();			
			tlen=txt.length;
			slen=itmSer.length;
			if(itm==valN && itmSer==txt)
			{
				found=1;
				break;
		    }
	    }	    
	    if(txt=="")  {
   			alert("Enter Correct Serial No....");
			return false;	    
	    }		  
		else if(found==1){
			alert("Serail Already Exits!");
			document.getElementById(nam).focus();
			return false;
		}		
	  var slen=document.getElementById('seriallength').value;
      txt=txt.toUpperCase();
	  for(i=1;i<=slen;i++)
	  {
		txt1=document.getElementById("serail"+i).value;
		txt1=txt1.toUpperCase();		
		//alert("TXT :"+txt +" -- TXT1 :"+txt1+ " LEN ::"+slen);
		if(txt1==txt && i != namF)
		{
			alert("Serail Already Entered...");
			document.getElementById("serail"+namF).focus();
			return false;
		}
	  }		
	}
	
	function checkSerialNo(ser)
	{
		var txt=ser.value;
		var nam=ser.name;
		var namF=nam.substring(6);
		var valN= document.getElementById("item"+namF).value;
		var arrLen=ItemSerial.length;
		var res="<font color='Red'> InValid</font>";
		var myTab="<div id='divscroll'  class='boldEleven'>";
		var flag=false;
		for(i=0;i<arrLen-1;i++)
		{
			itm=ItemSerial[i][0];
			itmSer=ItemSerial[i][1];
			itmSer=itmSer.toUpperCase();
			txt=txt.toUpperCase();			
			tlen=txt.length;
			slen=itmSer.length;
			//if(tlen<=slen)
			//{			
		//	 itmSer1=itmSer.substring(0,tlen)			 
			 if(itm==valN && itmSer==txt)
			 {			     
		 		 flag=true;
		 		 break;
		     } 
		   // }		   
		}
		if(txt=="") 
		  myTab=myTab+"<font color='red'>Enter Valid Serail No</font></div>";
		else if(flag==true)
			myTab=myTab+"<font color='red'>Serial Already Exits</font></div>";
		else
			myTab=myTab+"<font color='blue'>Valid Serial</font></div>";
		document.getElementById('Valid'+namF).innerHTML=myTab;

	}
function valid()
	{   		 	
   		if(
		checkNull('dcnumber',"Enter Delivery Challan number ...")
		&& checkNull('delDate',"Enter Delivery date ...")
		)
			return true;
		else
			return false		
	}
</script>
</head>
<%
	
	 sql="SELECT CHR_PURCHASEORDERNO,CHR_RECIVEDID,DAT_RECIVEDDATE,CHR_RECIVEDBY ";
	sql=sql+" FROM inv_t_vendorgoodsreceived where CHR_RECIVEDID='"+goodsRecNo+"'";
	String goodsRecValue[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);

	sql=" SELECT a.CHR_PURCHASEORDERNO,b.CHR_VENDORNAME,a.DAT_ORDERDATE,";
	sql = sql +" a.INT_ADDRESSID1,a.INT_ADDRESSID2,a.INT_ONHOLD,";
	sql = sql +" a.INT_CONDITIONID,a.INT_PAYMENTTERMID,a.CHR_DES,a.INT_PURCHASESTATUS ";
	sql = sql +" from  inv_t_vendorpurchaseorder  a , inv_m_vendorsinformation  b ";
	sql = sql +" where a.CHR_PURCHASEORDERNO='"+goodsRecValue[0][0]+"'  AND a.INT_VENDORID=b.INT_VENDORID";
	String SalenoInfo[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql); 
%>
<body >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm">
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
							<div align="center">Goods Received</div>
							</td>
						</tr>
						<tr>
							<td>
							<table width="673" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="123" class="boldEleven">
									<div align="left">Goods Receive No</div>
									</td>
									<td width="229" class="boldEleven">
									<div align="left"><%=goodsRecNo %> <input name="received"
										type="hidden" id="received" value="<%=goodsRecNo%>"></div>
									</td>
									<td width="107" class="boldEleven">
									<div align="left">On Hold</div>
									</td>
									<td width="201" class="boldEleven">
									<%
                        	if(SalenoInfo[0][5].equals("1"))
                        		out.println("<input name='hold' type='checkbox' checked='checked' id='hold' value='checkbox'  tabindex='4'/>");
                        	else
                        		out.println("<input name='hold' type='checkbox' id='hold' value='checkbox'  tabindex='4'/>");
                        %>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Vendor Id / Name</div>
									</td>
									<td class="boldEleven"><%=SalenoInfo[0][1] %></td>
									<td class="boldEleven">Order From</td>
									<td class="boldEleven">
									<div align="left">
									<%
								sql="Select INT_BRANCHID,CHR_BRANCHNAME from  com_m_branch WHERE INT_BRANCHID="+SalenoInfo[0][3];
                         		String branchids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								out.print(branchids[0][1]);
						 %>
									<div align="left"></div>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">Purchase Order No</td>
									<td class="boldEleven"><%=SalenoInfo[0][0] %> <input
										type="hidden" name="purchaseno" value="<%=SalenoInfo[0][0] %>">
									</td>
									<td class="boldEleven">ShippingTo</td>
									<td class="boldEleven">
									<%
							sql="Select INT_BRANCHID,CHR_BRANCHNAME from  com_m_branch WHERE INT_BRANCHID="+SalenoInfo[0][4];
	                 		String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							out.print(shipids[0][1]);
						%>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">PO Date</td>
									<td class="boldEleven"><%=SalenoInfo[0][2] %></td>
									<td class="boldEleven">Received Date</td>
									<td class="boldEleven"><%=goodsRecValue[0][2] %></td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Received By</div>
									</td>
									<td class="boldEleven"><%=goodsRecValue[0][3] %></td>
									<td class="boldEleven">Received Status</td>
									<td class="boldEleven">
									<%
                        	if(SalenoInfo[0][9].equals("1"))
                        		 out.print("Received");
                        	else if(SalenoInfo[0][9].equals("-1"))
	                       		 out.print("Partilly Received");
                        %>
									</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td>
							<table width="686" border="0" align="center" cellpadding="1"
								cellspacing="1" bordercolor="#ECACEF">
								<td width="100" class="boldEleven"><b>Item</b></td>
								<td width="113" class="boldEleven"><b>Description</b></td>
								<td width="99" class="boldEleven"><b>Order Qty</b></td>
								<td width="99" class="boldEleven"><b>TotalRec Qty</b></td>
								<td width="99" class="boldEleven"><b>Remin Qty</b></td>
								<td width="99" class="boldEleven"><b>Rec Qty</b></td>
							</table>
							</td>
						</tr>
						<tr>
							<td>
							<%
							sql = "SELECT b.CHR_ITEMNAME,a.CHR_DESC,INT_QUANTITY,INT_RECIVEDQUANTITY,INT_REMAINQUANTITY,a.CHR_ITEMID ";
							sql = sql +" FROM  inv_t_vendorpurchaseorderitem a, inv_m_item b WHERE ";
							sql = sql +" a.CHR_PURCHASEORDERNO = '"+SalenoInfo[0][0]+"' AND a.CHR_ITEMID = b.CHR_ITEMID  ";
							String saledata[][] = com.my.org.erp.common.CommonInfo.RecordSetArray(sql);
							out.println("<table width='686'  border='1' >");
							for(int u=0; u<saledata.length;u++)
							{
								sql="SELECT count(*) from inv_t_vendorgoodsreceived where CHR_RECIVEDID='"+goodsRecNo+"' AND CHR_ITEMID='"+saledata[u][5]+"'";
								String recCount[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								out.println("<tr><td width='100' class='boldEleven'>"+saledata[u][0]+"</td>");
								out.println("<td width='113' class='boldEleven'>"+saledata[u][1]+"</td>");
								out.println("<td width='99' class='boldEleven' align='right'>"+saledata[u][2]+"</td>");
								out.println("<td width='99' class='boldEleven' align='right'>"+saledata[u][3]+"</td>");
								out.println("<td width='99' class='boldEleven' align='right'>"+saledata[u][4]+"</td>");
								out.println("<td width='99' class='boldEleven' align='right'>"+recCount[0][0]+"</td>");
							}
							out.println("</table>");
					%>
							</td>
						</tr>
						<tr>
							<td>
							<%
					  	sql = "SELECT a.INT_ID,b.CHR_ITEMNAME,a.CHR_SERIALNO,a.CHR_WARRANTY ,a.CHR_ITEMID ";
						sql = sql+" from inv_t_vendorgoodsreceived a ,inv_m_item b WHERE a.CHR_RECIVEDID='"+goodsRecNo+"' ";
						sql = sql +" AND a.CHR_ITEMID = b.CHR_ITEMID  AND a.CHR_PURCHASEORDERNO='"+SalenoInfo[0][0]+"'";
						String stockdata[][] = com.my.org.erp.common.CommonInfo.RecordSetArray(sql);
						out.println("<table width='686'  border='1' >");
						out.println("<tr><td class='boldEleven'><b>Item Name<td class='boldEleven'><b>Serial Number<td>&nbsp;<td  class='boldEleven'><b>Waranty");
						for(int u=0; u<stockdata.length;u++)
						{
							out.println("<tr><td class='boldEleven'>"+stockdata[u][1]+"");
							out.println("<input type='hidden' name='row"+(u+1)+"' value='"+stockdata[u][0]+"'> </td>");
							out.println("<td class='boldEleven'>");
							out.println("<input type='hidden' id='oldSerail"+(u+1)+"' name='oldSerail"+(u+1)+"' value='"+stockdata[u][2]+"'>");
							out.println("<input type='text' onblur='CheckSerialNoValue(this)' onkeyup='checkSerialNo(this)' class='formText135' name='serail"+(u+1)+"' id='serail"+(u+1)+"' value='"+stockdata[u][2]+"'> </td>");
							out.println("<td class='boldEleven' width='150'><div id='Valid"+(u+1)+"'>&nbsp; </div>");
							out.println("<td class='boldEleven'>");
							out.println("<input type='text' class='formText135' name='warranty"+(u+1)+"' value='"+stockdata[u][3]+"'>");
							out.print("<input name='item"+(u+1)+"' type='hidden' id='item' value='"+stockdata[u][4]+"'></td>");
						}
						out.println("</table>");
						out.println("<input type='hidden' name='length' id='length' value='"+stockdata.length+"'>");	
					  %> <input name="seriallength" type="hidden" id="seriallength"
								value="<%=stockdata.length%>"></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td></td>
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
									<div align="left">Memo</div>
									</td>
									<td width="197" rowspan="4" valign="top" class="boldEleven">
									<div align="left"><%=SalenoInfo[0][8] %></div>
									</td>
									<td width="107" valign="top" class="boldEleven">
									<div align="left"></div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="totals1">
									<div align="right"></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left"></div>
									</td>
									<td width="169" valign="top" class="boldEleven"
										id="totaldiscount1">
									<div align="right"></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left"></div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="tax1">
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left"></div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="salestax1">
									<div align="right"></div>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left"></div>
									</td>
									<td class="boldEleven"></td>
									<td class="boldEleven">
									<div align="left"></div>
									</td>
									<td width="169" class="boldEleven" id="salestaxamount1">
									<div align="right"></div>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left"><input name="filename" type="hidden"
										value="GoodsReceived" /> <input name="actionS" type="hidden"
										value="INVGoodsReceivedSerialUpdate" /></div>
									</td>
									<td class="boldEleven">
									<div align="left"></div>
									</td>
									<td class="boldEleven">
									<div align="left">
									<div align="left"></div>
									</div>
									</td>
									<td width="169" class="boldEleven" id="nettotal1">
									<div align="right"></div>
									</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<table width="100" border="0" align="center" cellpadding="3"
										cellspacing="3">
										<tr>
											<td><input name="Button" type="submit"
												class="tMLAscreenHead" value="Update" onClick="" /></td>
											<td><input name="Submit2" type="button"
												class="tMLAscreenHead" value="  Close  "
												onClick="redirect('GoodsReceivedList.jsp')" /></td>
										</tr>
									</table>
									</td>
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
catch(Exception e){
	//System.out.println("Error :"+e.getMessage());
}
%>
