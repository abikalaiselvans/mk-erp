<%@ page language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%@ page import="com.my.org.erp.common.CommonFunction"%>

<%
try
{
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenAJAX.js"></script>
<script language="javascript">
 

var ItemSerial=[
<%
String	sql=" SELECT CHR_ITEMID,CHR_SERIALNO from inv_t_vendorgoodsreceived where CHR_FLAG='N'"+
"AND CHR_GRTFLAG='N' AND CHR_SERIALNO IS NOT NULL ORDER BY CHR_ITEMID";
String serialValue[][] = CommonFunctions.QueryExecute(sql);
for(int i=0;i<serialValue.length;i++)
{
	out.print("[\""+serialValue[i][0]+"\",\""+serialValue[i][1]+"\"],");
}
%>
];
	function valid()
	{
   		 	
   		if(
		checkNull('dcnumber',"Enter Delivery Challan number ...")
		&& checkNull('delDate',"Enter Delivery date ...")
		)
			return true;
		else
			return false;		
	}
	function RemoveItem(ser)
	{
		//var nam=ser.name;
		//var namF=nam.substring(6);
		//document.getElementById('Valid'+namF).innerHTML="";
	}
	function CheckSerial1(ser)
	{
		var txt=ser.value;
		var nam=ser.name;
		var namF=nam.substring(6);
		var valN= document.getElementById("itemid"+namF).value;
		var arrLen=ItemSerial.length;
		var res="<font color='Red'> InValid</font>";
		var myTab="<div id='divscroll' style='OVERFLOW:auto;width:200px;height:50px' class='boldEleven'><table>";	
		for(i=0;i<arrLen-1;i++)
		{
			itm=ItemSerial[i][0];
			itmSer=ItemSerial[i][1];
			itmSer=itmSer.toUpperCase();
			txt=txt.toUpperCase();			
			tlen=txt.length;
			slen=itmSer.length;
			if(tlen<=slen)
			{			
			 itmSer1=itmSer.substring(0,tlen)			 
			 if(itm==valN && itmSer1==txt)
			 {
			     myTab=myTab+"<tr><td><a href=JavaScript:AssignValue('"+itmSer+"','"+nam+"')>"+itmSer+"</a></td></tr>";
//		 		 break;
		     }		    
		    }		   
		}	
		 myTab=myTab+"</table>";	
		document.getElementById('Valid'+namF).innerHTML=myTab;
	}
	function AssignValue(sval,onam)
	{
		document.getElementById(onam).value=sval;
		var namF=onam.substring(6);
		document.getElementById('Valid'+namF).innerHTML="";
	}	
	function CheckSerial(ser)
	{
		var txt=ser.value;
		var nam=ser.name;
		var namF=nam.substring(6);
		var valN= document.getElementById("itemid"+namF).value;
		var arrLen=ItemSerial.length;
		var res="<font color='Red'> InValid</font>";
		for(i=0;i<arrLen-1;i++)
		{
			itm=ItemSerial[i][0];
			itmSer=ItemSerial[i][1];
			itmSer=itmSer.toUpperCase();
			txt=txt.toUpperCase();			
			if(itm==valN && itmSer==txt)
			{
				 res="<font color='blue'>Valid</font>";
				 break;
			}
		}		
		document.getElementById('Valid'+namF).innerHTML=res;
	}
</script>
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
</head>
<%
	String userbranchid=""+session.getAttribute("BRANCHID");
	String transNo=request.getParameter("itemId");
	sql=" SELECT CHR_STOCKTRANSFERID,INT_BRANCHID_FROM,INT_BRANCHID_TO,"
	+"DAT_TRANSFERDATE,CHR_DES,INT_STATUS,CHR_TRANSFERBY ,INT_TRANSFERSTATUS,INT_DIVIID from inv_t_stocktransfer "
	+" where INT_ID="+transNo;	
	out.println(sql);
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
							<div align="center">Stock Transfer</div>
							</td>
						</tr>
						<tr>
							<td>
							<table width="673" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="123" class="bold1">
								  <div align="left">Trans Ref No</div>									</td>
									<td width="229" class="boldEleven">
									<div align="left"><%=readData[0][0] %> <input
										name="salno" type="hidden" id="salno"
										value="<%=readData[0][0]%>"> <input name="transNo"
										type="hidden" id="transNo" value="<%=readData[0][0]%>">
									</div>									</td>
									<td width="107" class="bold1">
									<div align="left">
									<DIV align="left">Status</DIV>
								  </div>									</td>
									<td width="201" class="boldEleven"><%=status %></td>
								</tr>
								<tr>
									<td class="bold1">
									<div align="left">
									<DIV align="left">From Branch</DIV>
								  </div>									</td>
									<td class="boldEleven"><%=fBarnch %> <input type="hidden"
										value="<%=readData[0][1] %>" id="fromBranch" name="fromBranch">									</td>
									<td class="bold1">To Branch</td>
									<td class="boldEleven">
									<div align="left"><%=tBarnch	%> <input type="hidden"
										value="<%=readData[0][2] %>" id="toBranch" name="toBranch">
									<div align="left"></div>									</td>
								</tr>
								<tr>
									<td class="bold1">Transfer Date</td>
									<td class="boldEleven"><%=readData[0][3] %></td>
									<td class="bold1">Received Date</td>
									<td class="boldEleven">
									<div align="left"><input tabindex="2" name="recDate"
										type="text" class="formText135" id="recDate" size="15"
										readonly="readonly" /> <a href="javascript:cal2.popup();">
									<img src="../JavaScript/img/cal.gif" width="16" height="16"
										border="0" /> </a> <script language='JavaScript'
										type="text/javascript">
		<!--			
				var cal2 = new calendar1(document.forms['frm'].elements['recDate']);
				cal2.year_scroll = true;
				cal2.time_comp = false;
				setCurrentDate('recDate'); 
		//-->
                          </script></div>									</td>
								</tr>
								<tr>
									<td align="left" valign="top" class="bold1">Transfer By</td>
									<td align="left" valign="top" class="boldEleven"><%=readData[0][6] %></td>
									<td align="left" valign="top" class="bold1">Received By</td>

									<td class="boldEleven"><select name="reveivedBy"
										id="reveivedBy" class="formText135" size="7" style="width:200">

										<jsp:include page="Staffload.jsp" flush="true" />
									</select></td>
								</tr>
								<tr>
								  <td class="bold1">Division</td>
								  <td class="boldEleven">
								  <%
								  	String ssql="SELECT CHR_DIVICODE from inv_m_division where INT_DIVIID=" +readData[0][8];
									String dt[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(ssql);
									out.println(dt[0][0]);
								  
								  %><input name="division"  id="division" type="hidden" value="<%=readData[0][8]%>">
								  </td>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
							  </tr>
							</table>
							</td>
						</tr>
						 
						<tr>
							<td>
							<%

	sql = " SELECT a.INT_ID ,a.CHR_ITEMID,a.CHR_TYPE, a.INT_QUANTITY,a.CHR_RECEIVEDSTATUS, ";
	sql = sql +" if(a.CHR_TYPE='P','PRODUCT','ITEM'),  ";
	sql = sql +" if( ";
	sql = sql +" a.CHR_TYPE='I', ";
	sql = sql +" (SELECT b.CHR_ITEMNAME FROM inv_m_item b WHERE b.CHR_ITEMID=a.CHR_ITEMID), ";
	sql = sql +" (SELECT c.CHR_PRODUCTCODE FROM inv_m_produtlist c WHERE c.CHR_PRODUCTID=a.CHR_ITEMID)    ";
	sql = sql +" ), ";
	
	sql = sql +" if( ";
	sql = sql +" a.CHR_TYPE='I', ";
	sql = sql +" (SELECT d.CHR_DES FROM inv_m_item d WHERE d.CHR_ITEMID=a.CHR_ITEMID), ";
	sql = sql +" (SELECT e.CHR_PRODUCTDESC FROM inv_m_produtlist e WHERE e.CHR_PRODUCTID=a.CHR_ITEMID)    ";
	sql = sql +" ) , ";
	sql = sql +" ROUND(a.DOU_AVERAGEPRICE,2), ROUND((a.INT_QUANTITY*a.DOU_AVERAGEPRICE),2)  ";
	sql = sql +"  from inv_t_stocktransferitem  a WHERE a.CHR_STOCKTRANSFERID='"+readData[0][0]+"' ";
							
	String saledata[][] = CommonFunctions.QueryExecute(sql);
	String iname="";
	String itemname="";
	out.println("<table width='100%'  cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
	out.println("<tr class='MRow1'>");
	out.println("<td class='boldEleven'><b>S.no</b></td>");
	out.println("<td class='boldEleven'><b>Type</b></td>");
	out.println("<td class='boldEleven'><b>Item / Product </b></td>");
	out.println("<td class='boldEleven'><b>Description</b></td>");
	out.println("<td class='boldEleven'><b>Transfer Qty</b></td>");
	out.println("<td class='boldEleven'><b>Received Status</b></td>");
	out.println("<td class='boldEleven' align='center'><b>Unit Price</b></td>");
	out.println("<td class='boldEleven' align='center'><b>Total</b></td>");
	out.println("</tr>");
	double d=0;
	for(int u=0; u<saledata.length;u++)
	{
		 
		if(u%2==0)
			out.println("<tr class='MRow1'>");
		else
			out.println("<tr class='MRow2'>");	
			
		out.println("<td class='boldEleven'>"+(u+1)+".</td>");
		out.println("<td class='boldEleven'>"+saledata[u][5]+"</td>");
		out.println("<td class='boldEleven'>"+saledata[u][6]);
		out.println("<input type='hidden' name='irowid"+(u+1)+"' value='"+saledata[u][0]+"'>");
		out.println("<input type='hidden' name='iitemid"+(u+1)+"' value='"+saledata[u][1]+"'>");
		out.println("<input type='hidden' name='iitype"+(u+1)+"' value='"+saledata[u][2]+"'>");
		out.println("<input type='hidden' name='iqty"+(u+1)+"' value='"+saledata[u][3]+"'></td>");

		out.println("<td class='boldEleven'  >"+saledata[u][7]+"</td>");
		out.println("<td class='boldEleven'  >"+saledata[u][3]+"</td>");
		if("Y".equals(saledata[u][4]) )
			out.println("<td class='boldgreen'>Received</td>");
		else
			out.println("<td class='boldred'>&nbsp;-</td>");	
			
		out.println("<td class='boldEleven' align='right' >"+saledata[u][8]+"</td>");
		out.println("<td class='boldEleven' align='right' >"+saledata[u][9]+"</td>");
		d = d+Double.parseDouble(saledata[u][9]);
			
		out.println("</tr>");
		}
		String strDouble = String.format("%.2f", d);
		out.println("<tr  bgcolor='#ffffff' >");	
		out.println("<td class='boldEleven' align='right' colspan='7'><h3>Net Total : </h3></td>");
		out.println("<td class='boldEleven' align='right' >"+strDouble+"</td>");
		out.println("</tr>");	
	out.println("</table>");
		
						%> 
						
<input name="iseriallength" type="hidden" id="iseriallength" value="<%=saledata.length%>"></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td>
							<%
		 
		sql = "SELECT a.INT_ID,a.CHR_ITEMID ,a.CHR_TYPE,a.CHR_SERIALNO,a.CHR_WARRANTY ,a.CHR_RECEIVEDSTATUS ,";	
		sql = sql +" if(a.CHR_TYPE='P','PRODUCT','ITEM'),  ";
		sql = sql +" if( ";
		sql = sql +" a.CHR_TYPE='I', ";
		sql = sql +" (SELECT b.CHR_ITEMNAME FROM inv_m_item b WHERE b.CHR_ITEMID=a.CHR_ITEMID), ";
		sql = sql +" (SELECT c.CHR_PRODUCTCODE FROM inv_m_produtlist c WHERE c.CHR_PRODUCTID=a.CHR_ITEMID)    ";
		sql = sql +" ), ";
	
		sql = sql +" if( ";
		sql = sql +" a.CHR_TYPE='I', ";
		sql = sql +" (SELECT d.CHR_DES FROM inv_m_item d WHERE d.CHR_ITEMID=a.CHR_ITEMID), ";
		sql = sql +" (SELECT e.CHR_PRODUCTDESC FROM inv_m_produtlist e WHERE e.CHR_PRODUCTID=a.CHR_ITEMID)    ";
		sql = sql +" )  ";
		sql = sql+" from inv_t_stocktransferitemserial a  WHERE a.CHR_STOCKTRANSFERID='"+readData[0][0]+"' ";
		
		 
		String stockdata[][] =  CommonFunctions.QueryExecute(sql);
		
		out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
		out.println("<tr class='MRow1'>");
		out.println("<td class='boldEleven'><b>S.No</b></td>");
		out.println("<td class='boldEleven'><b>Type</b></td>");
		out.println("<td class='boldEleven'><b>Item / Product </b></td>");
		out.println("<td class='boldEleven'><b>Serial Number</b></td>");
		out.println("<td class='boldEleven'><b>Warranty</b></td>");
		out.println("<td class='boldEleven'><b> Receive All <input type='checkbox' name='checkboxall' id='checkboxall' value='checkbox' onClick='SelectAll()'> </b></td>");
		out.println("</tr>");

		for(int u=0; u<stockdata.length;u++)
		{		
			if(u%2==0)
				out.println("<tr class='MRow1'>");
			else
				out.println("<tr class='MRow2'>");	
			out.println("<td class='boldEleven'>"+(u+1)+".</td>");
			out.println("<td class='boldEleven'>"+stockdata[u][6]+"</td>");
			out.println("<td class='boldEleven'>"+stockdata[u][7]);
			out.println("<input type='hidden' name='rowid"+(u+1)+"' value='"+stockdata[u][0]+"'>");
			out.println("<input type='hidden' name='itemid"+(u+1)+"' value='"+stockdata[u][1]+"'>");
			out.println("<input type='hidden' name='itype"+(u+1)+"' value='"+stockdata[u][2]+"'></td>");
			out.println("<input type='hidden' name='serial"+(u+1)+"' value='"+stockdata[u][3]+"'></td>");
			out.println("<td class='boldEleven'>"+stockdata[u][3]);
			out.println("<td class='boldEleven'>"+stockdata[u][4]+" - Years");
			if("N".equals(stockdata[u][5]))
				out.println("<td class='boldEleven'><input type='checkbox' id='"+("checkbox"+(u+1))+"'   name='"+("checkbox"+(u+1))+"'  value='"+stockdata[u][3]+"'></td>");	
			else
				out.println("<td class='boldEleven'>Received</td>");	
			
			out.println("</tr>");
									
		}	
		out.println("</table>");
	  %> 
	  
	  <input name="seriallength" type="hidden" id="seriallength" value="<%=stockdata.length%>"></td>
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
							<table width="688" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
								  <td width="114" rowspan="4" valign="top" class="boldEleven"><div align="left" class="bold1">Memo</div></td>
								  <td width="197" rowspan="4" valign="top" class="boldEleven"><div align="left"><%=readData[0][4] %></div></td>
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
								<tr>
									<td class="boldEleven">
									<div align="left">&nbsp;</div>									</td>
									<td class="boldEleven">&nbsp;</td>
									<td class="boldEleven">&nbsp;</td>
									<td width="169" class="boldEleven" id="salestaxamount1">&nbsp;</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left"><input name="filename" type="hidden"
										value="StockTransfer" /> <input name="actionS" type="hidden"
										value="INVStockTransReceive" /></div>									</td>
									<td class="boldEleven">
									<div align="left"></div>									</td>
									<td class="boldEleven">&nbsp;</td>
									<td width="169" class="boldEleven" id="nettotal1">&nbsp;</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<table width="100" border="0" align="center" cellpadding="3"
										cellspacing="3">
										<tr>
											<td>
											<%
											
											
		   //	if("1".equals(readData[0][7]) && (userbranchid.equals(readData[0][2])))
			{
			out.println("<input name='Submit2' type='submit' class='tMLAscreenHead' value=' Submit ' onClick='return valid()'/>");	
			}	
		   %>											</td>
											<td><input name="Submit2" type="button"
												class="tMLAscreenHead" value="  Close  "
												onClick="redirect('Stock Transfer.jsp')" /></td>
										</tr>
									</table>									</td>
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
<script language="javascript">
  	function valid()
	{
   		
		if(
			checkNull("recDate","Enter Received date")
			&&checkNull("reveivedBy","Enter Received By")
			//&& checkNullSelect("fromBranch","Select From Branch ","Select")
			
			
			)
		{	
			return true;
		}
		else
		{
			return false;
		}
	}
	
	
	


function SelectAll()
{	
	
	var val=document.getElementById("checkboxall").checked;
	var totalchkbox = "<%=stockdata.length%>";
	if(val==false)
	{
		for(i=1;i<=totalchkbox;i++)
		{
			var s = "checkbox"+i;
			document.getElementById(s).checked=false;
		}
	}
	else
	{
		for(i=1;i<=totalchkbox;i++)
		{		
			var s = "checkbox"+i;
			document.getElementById(s).checked=true;		
		}
	}
	
}
	
	
  </script></form>
<%@ include file="../footer.jsp"%>
</body>
</html>
<%
}
catch(Exception e)
{
	System.out.println(e.getMessage());
}
%>