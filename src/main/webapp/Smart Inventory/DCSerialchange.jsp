<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" errorPage="../error/index.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenAJAX.js"></script>
<script language="JavaScript" src="../JavaScript/AJAX.js"></script>
</head>
<%
	String Saleno=request.getParameter("Saleno");
	String branchId=""+session.getAttribute("BRANCHID");
	String Dcno=request.getParameter("Dcno");
	String sql="";
	String dcnumber =Dcno;
%>
<body >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm"
	onSubmit="return valid()">
<div align="center"><br />
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="705"
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
					<td width="9"><spacer height="1" width="1" type="block" /></td>
					<td width="687">
					<table width="100%" border="0" cellpadding="2" cellspacing="2">
						<tr>
							<td colspan="5">
							<div align="center" class="boldThirteen">Delivery Details</div>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						<tr bgcolor="#FFFFFF">
							<td colspan="5"   class="bolddeeplogin"></td>
						</tr>
						<tr bgcolor="#FFFFFF">
							<td colspan="5"   class="bolddeeplogin"></td>
						</tr>
						<tr bgcolor="#FFFFFF">
							<td colspan="5"   class="bolddeeplogin">
							<%
					  
					sql = " select CHR_TYPE,CHR_ITEMID, count(*) from  inv_t_customersalesorderitemserial ";
					sql = sql + " WHERE CHR_SALESORDERNO = '"+Saleno+"'  ";
					sql = sql + " AND CHR_DELIVERYNO ='"+dcnumber+"' group by CHR_TYPE ";
					String saledata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					String iname="";
					String itemname="";
					out.println("<table width='100%'  border='1' cellspacing=0 cellpadding=0 >");
					out.println("<td   class='boldEleven'><b>Type</b></td>");
					out.println("<td   class='boldEleven'><b>Item / Product</b></td>");
					out.println("<td   class='boldEleven'><b>Order Qty</b></td>");
					out.println("<td   class='boldEleven'><b>Delivery Qty </b></td>");
					
					for(int u=0; u<saledata.length;u++)
					{
						if(saledata[u][0].equals("I"))
						{
							iname="Item";
							sql = "SELECT CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID='"+saledata[u][1]+"'";
							itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
						}	
						if(saledata[u][0].equals("P"))
						{
						  iname="Product";
						  sql= "SELECT CHR_PRODUCTCODE FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+saledata[u][1]+"'";
						  itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
						}	
						out.println("<tr><td   class='boldEleven' >"+iname+"</td>");
						out.println("<td  class='boldEleven' >"+itemname+"</td>");
						
						
						sql = " select count(*) from  inv_t_customersalesorderitemserial  ";
						sql = sql +" WHERE CHR_SALESORDERNO = '"+Saleno+"'  AND  CHR_ITEMID = '"+saledata[u][1]+"' ";
						int Ordqty = com.my.org.erp.common.CommonFunction.intRecordCount(sql);
						

						out.println("<td  class='boldEleven' >"+Ordqty+"</td>");
						out.println("<td  class='boldEleven' >"+saledata[0][2]+"</td>");
						
						 
					}	
					out.println("</table>");
					
						%>
							</td>
						</tr>
						<tr bgcolor="#FFFFFF">
							<td colspan="5"   class="bolddeeplogin">
							<div align="center" id="error" class="bolddeepred"></div>
							</td>
						</tr>
						<tr bgcolor="#FFFFFF">
							<td colspan="5"   class="bolddeeplogin">
							<%
						sql = " select CHR_TYPE,CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY ,INT_ID from  inv_t_customersalesorderitemserial  WHERE CHR_SALESORDERNO = '"+Saleno+"'  AND CHR_DELIVERYNO ='"+dcnumber+"' order by CHR_ITEMID ";
						String serialdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						String serial ="serial";
						String warranty="warranty";
						String rowid="rowid";
						out.print("<table border=0 cellspacing=3 cellpadding=3 width='100%'>");
						out.println("<tr><td   class='boldEleven'><b>Type</b></td>");
						out.println("<td   class='boldEleven'><b>Item / Product</b></td>");
						out.println("<td   class='boldEleven'><b>Serial Number</b></td>");
						out.println("<td   class='boldEleven'><b>Warranty</b></td>");
						String h="";
						String h1="";
						String h0="";
						for(int u=0; u<serialdata.length;u++)
						{
							h="";h1="";
							if(u%2 == 0)
								out.println("<tr class='MRow1'>");
							else
								out.println("<tr class='MRow2'>");
									
							if(serialdata[u][0].equals("I"))
							{
								iname="Item";
								sql = "SELECT CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID='"+serialdata[u][1]+"'";
								itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
							}	
							if(serialdata[u][0].equals("P"))
							{
							  iname="Product";
							  sql= "SELECT CHR_PRODUCTCODE FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+serialdata[u][1]+"'";
							  itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
							}	
							out.println("<td   class='boldEleven' >"+iname+"</td>");
							out.println("<td class='boldEleven' >"+itemname);
							out.println("<input name='"+rowid+(u+1)+"'  type='hidden'  value='"+serialdata[u][4]+"'>");
							
							

h1="onBlur =\"LoadUniqueCheckSale('serial"+(u+1)+"','Valid"+(u+1)+"' , 'inv_t_vendorgoodsreceived','CHR_SERIALNO','Submit'),getValues('serial','"+serialdata.length+"' ,'error' , 'Submit')\" ";
					
							out.println("<td class='boldEleven' ><input name='"+serial+(u+1)+"'  type='text' class='formText135'  size=10 "+h1+" " +" value='"+serialdata[u][2]+"'/><div id='Valid"+(u+1)+"'> </div></td>");
							out.println("<td class='boldEleven' ><input name='"+warranty+(u+1)+"' type='text' class='formText135'  size=10  value='"+serialdata[u][3]+"'/></td>");
							
						}
						out.print("</table>");
						out.print("<input name='serialparam' type='hidden' value='"+serialdata.length+"'>");
						

					  %>
							</td>
						</tr>

						<tr>
							<td>&nbsp;</td>
							<td></td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td colspan="5">
							<table border="0" align="center">
								<tr>
									<td width="56"><input name="Submit" id="Submit"
										type="submit" class="tMLAscreenHead" value="Submit"   accesskey="s"   ></td>
									<td width="56"><input name="button" type="button"
										class="tMLAscreenHead"  value="Close"   accesskey="c" 
										onClick="redirect('DCView.jsp?Saleno=<%=Saleno%>')"></td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="7"><spacer height="1" width="1"
						type="block" /></td>
					<td width="1" class="BorderLine"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" />
					<div align="center"><input name="filename" type="hidden"
						value="DelivaryChallan" /> <input name="actionS" type="hidden"
						value="INVDelivaryChallanSerialChange" /> <input name="saleno"
						type="hidden" id="saleno" value=<%=Saleno%>> <input
						name="dcnumber" type="hidden" id="dcnumber" value=<%=Dcno%>>
					</div>
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
		<td></td>
	</tr>
</table>
<script language="javascript">
	function CompareValidate(v1,v2 )
	{
		var oqty = parseInt(document.getElementById(v2).value);
		var dcqty = parseInt(document.getElementById(v1).value);
		if(oqty <dcqty || dcqty<=0)
		{
			alert("kindly check Delivery Quantity...");
			document.getElementById(v1).focus();
		}	
	}

function valid()
	{
   		 	
   		//var s="<%//vname%>";
   		var v = s.split(",");
   		var flag =false;
		for( i=0; i<v.length-1; i++)
		{
			var chk =document.getElementById(v[i]).value;
			var ck = "Enter Data..."+v[i];
			if(checkNull(v[i],ck))
			{
				d=1;
			}
			else
			{
				return false;				
			}	
		}
	}
</script></div>
</form>
<%@ include file="../footer.jsp"%>
</body>
</html>

