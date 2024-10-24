<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" errorPage="../error/index.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<%
	String transNo=request.getParameter("transNo");
	String divanme = request.getParameter("divanme");
	String sql="";
	sql=" SELECT CHR_STOCKTRANSFERID,INT_BRANCHID_FROM,INT_BRANCHID_TO,"
	+"DAT_TRANSFERDATE,CHR_DES,INT_STATUS,DAT_RECEIVEDDATE,CHR_TRANSFERBY,CHR_RECEIVEDBY from inv_t_stocktransfer "
	+" where CHR_STOCKTRANSFERID='"+transNo+"'";	
	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql); 
	sql="SELECT CHR_BRANCHNAME from com_m_branch where INT_BRANCHID="+readData[0][1];
	String fBarnch=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_BRANCHNAME");
	sql="SELECT CHR_BRANCHNAME from com_m_branch where INT_BRANCHID="+readData[0][2];
	String tBarnch=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_BRANCHNAME");
	String status="";
	int s=Integer.parseInt(readData[0][5]);
	if(s==0)
		status="Transfered";
	else
		status="Received";	
 
%>
<body >
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
							<div align="center">Stock Transfer</div>
							</td>
						</tr>
						<tr>
							<td>
							<table width="673" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="123" class="boldEleven">
									<div align="left">Trans Ref No</div>
									</td>
									<td width="229" class="boldEleven">
									<div align="left"><%=readData[0][0] %> <input
										name="salno" type="hidden" id="salno"
										value="<%=readData[0][0]%>"></div>
									</td>
									<td width="107" class="boldEleven">
									<div align="left">
									<DIV align="left">Status</DIV>
									</div>
									</td>
									<td width="201" class="boldEleven"><%=status %></td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">
									<DIV align="left">From Branch</DIV>
									</div>
									</td>
									<td class="boldEleven"><%=fBarnch %></td>
									<td class="boldEleven">To Branch</td>
									<td class="boldEleven">
									<div align="left"><%=tBarnch	%>
									<div align="left"></div>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">Transfer Date</td>
									<td class="boldEleven"><%=readData[0][3] %></td>
									<td class="boldEleven">Received Date</td>
									<td class="boldEleven"><%=readData[0][6] %></td>
								</tr>
								<tr>
									<td class="boldEleven">Transfer By</td>
									<td class="boldEleven"><%=readData[0][7] %></td>
									<td class="boldEleven">Received By</td>
									<td class="boldEleven"><%=readData[0][8] %></td>
								</tr>

							</table>
							</td>
						</tr>
						<tr>
							<td>
							<%
						sql = "SELECT INT_ID,CHR_ITEMID ,CHR_TYPE,CHR_DESC,INT_QUANTITY  ";	
						sql = sql+" from inv_t_stocktransferitem  WHERE CHR_STOCKTRANSFERID='"+readData[0][0]+"' ";
						String saledata[][] = com.my.org.erp.common.CommonInfo.RecordSetArray(sql);
						String iname="";
						String itemname="";
						out.println("<table width='100%'  border='1' cellpadding='0' cellspacing='0'>");
						out.println("<tr>");
						out.println("<td width='200' class='boldEleven'><b>Type</b></td>");
						out.println("<td width='200' class='boldEleven'><strong>Item / Product </strong></td>");
						out.println("<td width='200' class='boldEleven'><b>Description</b></td>");
						out.println("<td width='200' class='boldEleven'><b>Transfer Qty</b></td>");
						out.println("</tr>");
						for(int u=0; u<saledata.length;u++)
						{
							if(saledata[u][2].equals("I"))
							{
							iname="Item";
							sql = "SELECT CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID='"+saledata[u][1]+"'";
							itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
							 
							}	
							if(saledata[u][2].equals("P"))
							{
							  iname="Product";
							  sql= "SELECT CHR_PRODUCTCODE FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+saledata[u][1]+"'";
							  itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
							  
							}	
							
								out.println("<tr><td width='200' class='boldEleven'>"+iname+"</td>");
								out.println("<td width='200' class='boldEleven'>"+itemname+"</td>");
								out.println("<td width='200' class='boldEleven'  >"+saledata[u][3]+"</td>");
								out.println("<td width='200' class='boldEleven'  >"+saledata[u][4]+"</td>");
							}	
						out.println("</table>");
							
						%>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td>
							<%
		sql = "SELECT INT_ID,CHR_ITEMID ,CHR_TYPE,CHR_SERIALNO,CHR_WARRANTY,CHR_RECEIVEDBY,CHR_RECEIVEDSTATUS ";	
		sql = sql+" from inv_t_stocktransferitemserial  WHERE CHR_STOCKTRANSFERID='"+readData[0][0]+"' ";
		
		String stockdata[][] = com.my.org.erp.common.CommonInfo.RecordSetArray(sql);
		String bgcolor="";
		
		if(stockdata.length>0)
		{
			out.println("<table width='686'  border='1' cellpadding='0' cellspacing='0' ><tr><td class='boldEleven'><b>");
			out.println("Type<td class='boldEleven'><b>Item Name<td class='boldEleven'><b>Serial Number<td class='boldEleven'><b>Warranty<td class='boldEleven'><b>Received Status");
			for(int u=0; u<stockdata.length;u++)
			{		
				if(stockdata[u][2].equals("I"))
				{
					iname="Item";
					sql = "SELECT CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID='"+stockdata[u][1]+"'";
					itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
					bgcolor="MRow3";
				}	
				if(stockdata[u][2].equals("P"))
				{
				  iname="Product";
				  sql= "SELECT CHR_PRODUCTCODE FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+stockdata[u][1]+"'";
				  itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
				  bgcolor="MRow4";
				}	
				out.println("<tr class='"+bgcolor+"'><td class='boldEleven'>"+iname+"</td>");
				out.println("<td class='boldEleven'>"+itemname);
				out.println("<input type='hidden' name='rowid"+(u+1)+"' value='"+stockdata[u][0]+"'>");
				out.println("<input type='hidden' name='itemid"+(u+1)+"' value='"+stockdata[u][1]+"'>");
				out.println("<input type='hidden' name='itype"+(u+1)+"' value='"+stockdata[u][2]+"'></td>");
				out.println("<td class='boldEleven'>"+stockdata[u][3]);
				out.println("<td class='boldEleven'>"+stockdata[u][4] +" - Years");
				if("Y".equals(stockdata[u][6]))
					out.println("<td class='boldgreen'>Received");
				else
					out.println("<td class='boldred'>Not Received");
				
									
		}	
		out.println("</table>");
		
		}
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
									<div align="left">Memo</div>									</td>
									<td width="197" rowspan="4" valign="top" class="boldEleven">
									<div align="left"><%=readData[0][4] %></div>									</td>
									<td width="107" valign="top" class="boldEleven">
									<div align="left">&nbsp;</div>									</td>
									<td width="169" valign="top" class="boldEleven" id="totals1">
									<div align="right"></div>									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">&nbsp;</td>
									<td width="169" valign="top" class="boldEleven"
										id="totaldiscount1">&nbsp;</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">&nbsp;</td>
									<td width="169" valign="top" class="boldEleven" id="tax1">&nbsp;</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">&nbsp;</td>
									<td width="169" valign="top" class="boldEleven" id="salestax1">&nbsp;</td>
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
</body>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%@ page import="com.my.org.erp.common.CommonFunction"%>
</html>
