<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*"%>
<%@ page import="com.my.org.erp.common.*"%>
 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenAJAX.js"></script>
<script language="javascript" src="../JavaScript/Inventory/InvenCustomerAJAX.js"></script>
<script language="JavaScript" src="../JavaScript/AJAX.js"></script>
<script language="javascript">
var ItemSerial=[
<%
String branchId=""+session.getAttribute("BRANCHID");
String	sql=" SELECT CHR_ITEMID,CHR_SERIALNO from inv_t_vendorgoodsreceived where CHR_FLAG='N'"+
"AND CHR_GRTFLAG='N' AND CHR_SERIALNO IS NOT NULL AND INT_BRANCHID="+ branchId+" ORDER BY CHR_ITEMID ";
String serialValue[][]=CommonFunctions.QueryExecute(sql);
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
			return false		
	}
	function RemoveItem(ser)
	{
		
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
@import url("../JavaScript/SmartStyles.css");
</style>
</head>
<%
	try
	{
			String transNo=""+request.getParameter("transferId");
			//System.out.println(transNo);
			sql=" SELECT CHR_STOCKTRANSFERID,INT_BRANCHID_FROM,INT_BRANCHID_TO,"
			+" DAT_TRANSFERDATE,CHR_DES,INT_STATUS from inv_t_stocktransfer "
			+" where CHR_STOCKTRANSFERID='"+transNo+"'";
			String readData[][] = CommonFunctions.QueryExecute(sql); 
			
			sql="SELECT CHR_BRANCHNAME from com_m_branch where INT_BRANCHID="+readData[0][1];
			String fBarnch=CommonInfo.stringGetAnySelectField(sql, "CHR_BRANCHNAME");
			sql="SELECT CHR_BRANCHNAME from com_m_branch where INT_BRANCHID="+readData[0][2];
			String tBarnch=CommonInfo.stringGetAnySelectField(sql, "CHR_BRANCHNAME");
			String status="";
			int s=Integer.parseInt(readData[0][5]);
			if(s==0)
				status="Transfered";
			else
				status="Received"; 
%>
<body >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm"
	onSubmit="return Validate()">
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
										value="<%=readData[0][0]%>"> <input name="transNo"
										type="hidden" id="transNo" value="<%=readData[0][0]%>">
									</div>									</td>
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
									<td class="boldEleven"><%=fBarnch %> <input type="hidden"
										name="from" id="from" value="<%=readData[0][1]%>"></td>
									<td class="boldEleven">To Branch</td>
									<td class="boldEleven">
									<div align="left"><%=tBarnch	%> <input type="hidden"
										name="to" id="to" value="<%=readData[0][2]%>">
									<div align="left"></div>									</td>
								</tr>
								<tr>
									<td class="boldEleven">Transfer Date</td>
									<td class="boldEleven"><%=readData[0][3] %></td>
									<td class="boldEleven">Received Date</td>
									<td class="boldEleven"><%=readData[0][3] %></td>
								</tr>
								 
							</table>							</td>
						</tr>
						<tr>
							<td align="left"></td>
						</tr>
						<tr>
							<td align="left">
							  <div align="center">
							    <%
sql = " SELECT a.INT_ID , ";
sql = sql +" if( ";
sql = sql +" a.CHR_TYPE='I', ";
sql = sql +" (SELECT b.CHR_ITEMNAME FROM inv_m_item b WHERE b.CHR_ITEMID=a.CHR_ITEMID), ";
sql = sql +" (SELECT c.CHR_PRODUCTCODE FROM inv_m_produtlist c WHERE c.CHR_PRODUCTID=a.CHR_ITEMID)    ";
sql = sql +" ), ";
sql = sql +" if(a.CHR_TYPE='P','PRODUCT','ITEM'),";

sql = sql +" if( ";
sql = sql +" a.CHR_TYPE='I', ";
sql = sql +" (SELECT d.CHR_DES FROM inv_m_item d WHERE d.CHR_ITEMID=a.CHR_ITEMID), ";
sql = sql +" (SELECT e.CHR_PRODUCTDESC FROM inv_m_produtlist e WHERE e.CHR_PRODUCTID=a.CHR_ITEMID)    ";
sql = sql +" ), ";
sql = sql +" a.INT_QUANTITY,a.DOU_AVERAGEPRICE, (a.INT_QUANTITY*a.DOU_AVERAGEPRICE)  from inv_t_stocktransferitem  a WHERE a.CHR_STOCKTRANSFERID='"+readData[0][0]+"' ";
String saledata[][] = CommonFunctions.QueryExecute(sql);
out.println("<table width='80%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
out.println("<tr class='MRow1'>");
out.println("<td class='boldEleven'><b>S.No</b></td>");
out.println("<td class='boldEleven'><b>Type</b></td>");
out.println("<td class='boldEleven'><b>Item / Product </b></td>");
out.println("<td class='boldEleven'><b>Description</b></td>");
out.println("<td class='boldEleven'><b>Transfer Qty</b></td>");
out.println("<td class='boldEleven'><b>Unit Price</b></td>");
out.println("<td class='boldEleven'><b>Total</b></td>");
out.println("</tr>");
if(saledata.length >0)
{
	double d=0;
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
		out.println("<td class='boldEleven' align='right' >"+saledata[u][4]+"</td>");
		out.println("<td class='boldEleven' align='right' >"+saledata[u][5]+"</td>");
		out.println("<td class='boldEleven' align='right' >"+saledata[u][6]+"</td>");
		d = d+Double.parseDouble(saledata[u][6]);
		out.println("</tr>");
	}
	String strDouble = String.format("%.2f", d);
	out.println("<tr  bgcolor='#ffffff' >");	
	out.println("<td class='boldEleven' align='right' colspan='6'><h3>Net Total : </h3></td>");
	out.println("<td class='boldEleven' align='right' >"+strDouble+"</td>");
	out.println("</tr>");
}
out.println("</table>");
%>
					          </div></td>
						</tr>
						<tr>
							<td>
							<div align="center" id="error" class="bolddeepred"></div>							</td>
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
sql = sql+ " a.CHR_SERIALNO,a.CHR_WARRANTY,a.CHR_TYPE, a.CHR_ITEMID 	  ";
sql = sql+ " from inv_t_stocktransferitemserial a   ";
sql = sql+ " WHERE a.CHR_STOCKTRANSFERID='"+readData[0][0]+"' ";
String stockdata[][] = CommonFunctions.QueryExecute(sql);
String h1 ="";
if(stockdata.length>0)
{
	out.println("<table width='80%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
	out.println("<tr class='MRow1'>");
	out.println("<td class='boldEleven'><b>S.No</b></td>");
	out.println("<td class='boldEleven'><b>Type</b></td>");
	out.println("<td class='boldEleven'><b>Item Name</b></td>");
	out.println("<td class='boldEleven'><b>Serial Number</b></td>");
	out.println("<td class='boldEleven'><b>Warranty</b></td>");
	out.println("</tr>");	
	for(int u=0; u<stockdata.length;u++)
	{	
		h1="";
		if(u%2==0)
			out.println("<tr class='MRow1'>");
		else
			out.println("<tr class='MRow2'>");	
		out.println("<td class='boldEleven'>"+(u+1)+".</td>");
		out.println("<td  class='boldEleven'>"+stockdata[u][2]+"</td>");
		out.println("<td class='boldEleven'>"+stockdata[u][1]+"");
		out.println("<input type='hidden' name='rowid"+(u+1)+"'     id='rowid"+(u+1)+"'     value='"+stockdata[u][0]+"'>");
		out.println("<input type='hidden' name='itemid"+(u+1)+"'    id='itemid"+(u+1)+"'    value='"+stockdata[u][6]+"'>");
		out.println("<input type='hidden' name='itype"+(u+1)+"'     id='itype"+(u+1)+"'     value='"+stockdata[u][5]+"'></td>");
				
		String h=" onBlur=\"getValues('serial','"+stockdata.length+"' ,'error' , 'Submit')\" ";
		h1=" onKeyUp=\"LoadUniqueCheckSales('serial"+(u+1)+"','Valid"+(u+1)+"' , 'inv_t_vendorgoodsreceived','CHR_SERIALNO','Submit','"+stockdata[u][5]+"','"+stockdata[u][6]+"')\" ";
		out.println("</td>");				
			
		out.println("<td class='boldEleven'>");
		out.println("<input type='text' class='formText135' "+h1+ h+" id='serial"+(u+1)+"' name='serial"+(u+1)+"' >");
		out.println("</td>");				
		
		out.println("<td class='boldEleven' ><div id='Valid"+(u+1)+"'> </div><div id='Warranty"+(u+1)+"'></DIV>");						
		
		out.print("<select name='Warrantys"+(u+1)+"' id='Warrantys"+(u+1)+"' class='formText135' >");
		%> <jsp:include page="Warranty.jsp" flush="true" /> <%
		out.println("</select>");
		out.println("<script language='javascript'>setOptionValue('Warrantys"+(u+1)+"','1')</script>");
	 
		out.println("</td>");						
				
				
	}
	out.println("</table>");
}
%> 
  <input name="seriallength" type="hidden" id="seriallength" value="<%=stockdata.length%>">
                              </div></td>
						</tr>
						<tr>
						  <td><div id="mythra"></div>&nbsp;</td>
					  </tr>
						<tr>
						  <td>
						  
<%
if(stockdata.length>0)
{
%>

						  
						  <table width="80%" border="0" align="right" cellpadding="5" cellspacing="0">
                            <tr>
                              <td width="267" rowspan="2" valign="top" class="bolddeeplogin"><div align="right">
                                  <textarea name="randomserials" cols="25" rows="5" id="randomserials"></textarea>
                              </div></td>
                              <td width="317" valign="top" class="bolddeeplogin" >
							  
<script language="javascript">
							   
function assignrandomserial()
 {
 	var l=parseInt("<%=stockdata.length%>");
 	var randomss = document.getElementById('randomserials').value;
	if(randomss=="")
	{
		alert("Check Random Serial Number...");
		document.getElementById('randomserials').focus();
	}
	else
	{
		var arrayarandomserial = randomss.split(",");
		if(arrayarandomserial.length<1)
		{
			alert("Check Random Serial Number...");
		}
		else
		{
			var seriallength = parseInt(arrayarandomserial.length);
			for(u=0;u<seriallength;u++)
				{
					var ty="serial"+(u+1);
					var obj = findObj(ty);
					if(obj != null)
						document.getElementById(ty).value=trim(arrayarandomserial[u]);
					
				}
				document.getElementById('serial1').focus();
			
				
		}
	}	
 }  


function assignSerialWarranty()
 {
 	var l=parseInt("<%=stockdata.length%>");
	var warranty=prompt("Enter the Warranty for an e.g  3 month means 0.3 , 1 Year means 1","1"); 
 	for(u=0;u<l;u++)
	{
		var ty="Warrantys"+(u+1);
		var obj = findObj(ty);
		if(obj != null)
			setOptionValue(ty,warranty);
			
	}
 }  

 function checkserialnumbers()
							  {
							  	if(checkNull('randomserials','Enter the serial numbers'))
								{
									var query="CheckSerialnumberResponse.jsp?serials="+document.getElementById('randomserials').value;
									var width="800", height="400";
									var left = (screen.width/2) - width/2;
									var top = (screen.height/2) - height/2;
									var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
									newWindow = window.open(query,"subWind",styleStr);
									newWindow.focus( );
									 
								}
								 
								
								
							  }



							  </script>
							  
							  <a href='javascript:assignrandomserial()'>Serialnumber Assign </a><br>
                                (E.g S12,S10,S5,)</td>
                              <td width="317" rowspan="2" valign="top" class="bolddeeplogin" ><a href='javascript:assignSerialWarranty()'> </a><a href='javascript:assignSerialWarranty()'>Warranty Assign</a></td>
                            </tr>
                            <tr>
                              <td valign="top" class="bolddeeplogin" ><a     href='javascript:checkserialnumbers()' >check serialnumber</a>
                                   
                              </td>
                            </tr>
                          </table>
						  
						  
<%
}
%>						  
						  
						  
						  </td>
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
									<td width="114" rowspan="4" valign="top" class="boldEleven">&nbsp;</td>
									<td width="197" rowspan="4" valign="top" class="boldEleven">&nbsp;</td>
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
									<div align="left">
<input name="filename" type="hidden" value="StockTransfer" /> 
<input name="actionS" type="hidden"  value="INVStockTransSerialAdd" /> 
<input name="checkserialflag" type="hidden" id="checkserialflag" value="false">
</div>									</td>
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
<input name="Submit"   id="Submit" type="submit"	class="tMLAscreenHead" value="Submit"   accesskey="s"    /></td>
											<td>
<input name="Submit2" type="button" class="tMLAscreenHead" value="  Close  " onClick="redirect('Stock Transfer.jsp')" /></td>
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
</form>
<script language="javascript">
function Validate()
{
	var salesserialno="";
	var swapr = "<%=stockdata.length%>";
	var cfh=document.getElementById('checkserialflag').value;
	if(swapr >0)
	{
		for(u=0;u<swapr;u++)
		{
			if((document.getElementById("serial"+(u+1)).value)=="")
				salesserialno=salesserialno+"-";
			else
				salesserialno=salesserialno+document.getElementById("serial"+(u+1)).value;
			
			salesserialno=salesserialno+"~"+document.getElementById("itemid"+(u+1)).value+"~"+document.getElementById("itype"+(u+1)).value+"~,";
		}
	}
	else
	{
		document.getElementById('checkserialflag').value="true";
	}
	
	if(swapr >0)
	{
		checkSerial(salesserialno,'mythra');
	}	
	if(cfh=="true")
		return true;
	else
		return false;
}
</script>
<%
}
catch(Exception e)
{
}
%>
<%@ include file="../footer.jsp"%>
</body>
</html>
