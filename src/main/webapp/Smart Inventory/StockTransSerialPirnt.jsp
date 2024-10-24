<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 </head>
<%
	String sql="";
	String transNo=request.getParameter("transNo");
	sql=" SELECT CHR_STOCKTRANSFERID,INT_BRANCHID_FROM,INT_BRANCHID_TO,"
	+"DAT_TRANSFERDATE,CHR_DES,INT_STATUS,DAT_RECEIVEDDATE,FIND_A_EMPLOYEE_ID_NAME(CHR_TRANSFERBY),FIND_A_EMPLOYEE_ID_NAME(CHR_RECEIVEDBY) from inv_t_stocktransfer "
	+" where CHR_STOCKTRANSFERID='"+transNo+"'";	
	String readData[][] =  CommonFunctions.QueryExecute(sql); 
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
							<div align="center">Stock Transfer</div>							</td>
						</tr>
						<tr>
							<td>
							<table width="673" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="123" class="boldEleven">
									<div align="left">Trans Ref No</div>									</td>
									<td width="229" class="boldEleven">
									<div align="left"><%=readData[0][0] %> <input
										name="salno" type="hidden" id="salno"
										value="<%=readData[0][0]%>"></div>									</td>
									<td width="107" class="boldEleven">
									<div align="left">
									<DIV align="left">Status</DIV>
									</div>									</td>
									<td width="201" class="boldEleven"><%=status %></td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">
									<DIV align="left">From Branch</DIV>
									</div>									</td>
									<td class="boldEleven"><%=fBarnch %></td>
									<td class="boldEleven">To Branch</td>
									<td class="boldEleven">
									<div align="left"><%=tBarnch	%>
									<div align="left"></div>									</td>
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
							</table>							</td>
						</tr>
						<tr>
							<td>
							  <div align="center">
							    <%
							
sql = " SELECT a.INT_ID , ";
sql = sql +" if( ";
sql = sql +" a.CHR_TYPE='I', ";
sql = sql +" (SELECT b.CHR_ITEMNAME FROM inv_m_item b WHERE b.CHR_ITEMID=a.CHR_ITEMID), ";
sql = sql +" (SELECT c.CHR_PRODUCTCODE FROM inv_m_produtlist c WHERE c.CHR_PRODUCTID=a.CHR_ITEMID)    ";
sql = sql +" ), ";
sql = sql +" if(a.CHR_TYPE='P','PRODUCT','ITEM'),  ";

sql = sql +" if( ";
sql = sql +" a.CHR_TYPE='I', ";
sql = sql +" (SELECT d.CHR_DES FROM inv_m_item d WHERE d.CHR_ITEMID=a.CHR_ITEMID), ";
sql = sql +" (SELECT e.CHR_PRODUCTDESC FROM inv_m_produtlist e WHERE e.CHR_PRODUCTID=a.CHR_ITEMID)    ";
sql = sql +" ), ";



sql = sql +" a.INT_QUANTITY  from inv_t_stocktransferitem  a WHERE a.CHR_STOCKTRANSFERID='"+readData[0][0]+"' ";
String saledata[][] = CommonFunctions.QueryExecute(sql);
out.println("<table width='80%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
out.println("<tr class='MRow1'>");
out.println("<td class='boldEleven'><b>S.No</b></td>");
out.println("<td class='boldEleven'><b>Type</b></td>");
out.println("<td class='boldEleven'><b>Item / Product </b></td>");
out.println("<td class='boldEleven'><b>Description</b></td>");
out.println("<td class='boldEleven'><b>Transfer Qty</b></td>");
out.println("</tr>");
if(saledata.length >0)
{
	for(int u=0; u<saledata.length;u++)
	{
		if(u%2==0)
			out.println("<tr class='MRow1'>");
		else
			out.println("<tr class='MRow2'>");	
		out.println("<td class='boldEleven'>"+(u+1)+".</td>");
		out.println("<td  class='boldEleven'>"+saledata[u][1]+"</td>");
		out.println("<td class='boldEleven'>"+saledata[u][2]+"</td>");
		out.println("<td class='boldEleven'  >"+saledata[u][3]+"</td>");
		out.println("<td class='boldEleven'  >"+saledata[u][4]+"</td>");
		out.println("</tr>");
	}
}
out.println("</table>");							
 %>
					          </div></td>
						</tr>
						<tr>
							<td><div align="center"></div></td>
						</tr>
						<tr>
							<td>
							  <div align="center">
							    <%
		
sql = " SELECT a.INT_ID,  ";
sql = sql+ " if(  ";
sql = sql+ " a.CHR_TYPE='I',  ";
sql = sql+ " (SELECT b.CHR_ITEMNAME FROM inv_m_item b WHERE b.CHR_ITEMID=a.CHR_ITEMID),  ";
sql = sql+ " (SELECT c.CHR_PRODUCTCODE FROM inv_m_produtlist c WHERE c.CHR_PRODUCTID=a.CHR_ITEMID)     ";
sql = sql+ " ),  ";
sql = sql+ " if(a.CHR_TYPE='P','PRODUCT','ITEM'),  ";
sql = sql+ " a.CHR_SERIALNO,a.CHR_WARRANTY,a.CHR_RECEIVEDBY, a.CHR_RECEIVEDSTATUS 	  ";
sql = sql+ " from inv_t_stocktransferitemserial a   ";
sql = sql+ " WHERE a.CHR_STOCKTRANSFERID='"+readData[0][0]+"' ";
String saledata1[][] = CommonFunctions.QueryExecute(sql);

if(saledata1.length >0)
{
	
	out.println("<table width='80%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
	out.println("<tr class='MRow1'>");
	out.println("<td class='boldEleven'><b>S.No</b></td>");
	out.println("<td class='boldEleven'><b>Type</b></td>");
	out.println("<td class='boldEleven'><b>Item / Product </b></td>");
	out.println("<td class='boldEleven'><b>Serial</b></td>");
	out.println("<td class='boldEleven'><b>Warranty</b></td>");
	out.println("<td class='boldEleven'><b>Status</b></td>");
	out.println("</tr>");
	for(int u=0; u<saledata1.length;u++)
	{
		if(u%2==0)
			out.println("<tr class='MRow1'>");
		else
			out.println("<tr class='MRow2'>");	
		out.println("<td class='boldEleven'>"+(u+1)+".</td>");
		out.println("<td  class='boldEleven'>"+saledata1[u][1]+"</td>");
		out.println("<td class='boldEleven'>"+saledata1[u][2]+"</td>");
		out.println("<td class='boldEleven'  >"+saledata1[u][3]+"</td>");
		out.println("<td class='boldEleven'  >"+saledata1[u][4]+" -Years</td>");
		if("Y".equals(saledata1[u][6]))
			out.println("<td class='boldgreen'>Received</td>");
		else
			out.println("<td class='boldred'>Not Received</td>");
		out.println("</tr>");
	}
	out.println("</table>");
} 

 %> 
					                                   </div></td>
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
									<td width="169" valign="top" class="boldEleven" id="tax1"> </td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">&nbsp;</td>
									<td width="169" valign="top" class="boldEleven" id="salestax1">&nbsp;</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<table width="56" border="0" align="center" cellpadding="3"
										cellspacing="3">
										<tr>
											<td width="56"><input name="Submit2" type="button"
												class="tMLAscreenHead" value="  Close  "
												onClick="redirect('Stock Transfer.jsp')" /></td>
										</tr>
									</table>									</td>
								</tr>
							</table>							</td>
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
<%@ page import="com.my.org.erp.common.CommonFunction"%>
</html>
