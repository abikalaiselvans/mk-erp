<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" errorPage="../error/index.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenAJAX.js"></script>
<script language="javascript">
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
	String Saleno=request.getParameter("Saleno");
	String sql=" SELECT a.CHR_QUOTATIONNO,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),a.CHR_CUSTPURCHASENO,a.CHR_SALESORDERNO,a.CHR_SALEBY,a.DAT_SALEDATE,";
	sql = sql +" a.CHR_DELIVERYSTATUS,a.CHR_BILLINGADDRESS,a.CHR_SHIPINGADDRESS,a.INT_ONHOLD,";
	sql = sql +" a.INT_CONDITIONID,a.INT_PAYMENTTERMID,a.CHR_DES,a.CHR_REF,a.INT_TAXID,a.DOU_AMOUNT,a.DOU_DISCOUNT,";
	sql = sql +" a.DOU_TAXAMOUNT,a.DOU_TOTALAMOUNT,a.CHR_PAYMENTSTATUS from  inv_t_customersalesorder   a ,inv_m_customerinfo b ";
	sql = sql +" where a.CHR_SALESORDERNO='"+Saleno+"' AND a.INT_CUSTOMERID =b.INT_CUSTOMERID order by a.DAT_SALEDATE";
	String SalenoInfo[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);	
	String branchId=""+session.getAttribute("BRANCHID");
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
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="800"
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
					<td width="100%">
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
							<td class="bolddeeplogin">S.No</td>
							<td class="bolddeeplogin">Sale Order No</td>
							<td class="bolddeeplogin">DC. No</td>
							<td class="bolddeeplogin">DC. Date</td>
							<td class="bolddeeplogin">&nbsp;</td>
						</tr>
						<%
					sql = "select CHR_SALESORDERNO,CHR_DELIVERYNO,DT_DELIVERYDATE from  inv_t_customersalesorderitemserial   WHERE CHR_SALESORDERNO='"+Saleno+"' AND  CHR_DELIVERYNO is not null GROUP by CHR_DELIVERYNO" ;
					//System.out.println(sql);
					String dcdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					for(int u=0; u<dcdata.length;u++)
					{
						if(u%2 == 1)
							out.println("<tr height=25 class='MRow1'>");
						else
							out.println("<tr height=25 class='MRow2'>");
						
						out.println("<td class='boldEleven'>"+u+"</td>");
						out.println("<td class='boldEleven'>"+dcdata[u][0]+"</td>");
						out.println("<td class='boldEleven'>"+dcdata[u][1]+"</td>");
						out.println("<td class='boldEleven'>"+dcdata[u][2]+"</td>");
						String q = "<a href='DCPrint.jsp?Saleno="+Saleno+"&Dcno="+dcdata[u][1]+"'><font class='boldEleven'> View </a></font>";
						q = q +"&nbsp;&nbsp;  / &nbsp;&nbsp; <a href='DCSerialchange.jsp?Saleno="+Saleno+"&Dcno="+dcdata[u][1]+"'>  <font class='boldEleven'>Serial number Changes </font> </a>";
						out.println("<td class='boldEleven'>"+q+"</td>");
						out.println("</td>");
						out.println("</tr>");
						
					}
				%>

						<tr>
							<td>&nbsp;</td>
							<td></td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td colspan="5">
							<table width="56" border="0" align="center">
								<tr>
									<td><input name="button" type="button"
										class="buttonbold13"  value="Close"   accesskey="c" 
										onClick="redirect('Delivary Challan.jsp')"></td>
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
	</script></div>
</form>
<%@ include file="../footer.jsp"%>
</body>
</html>

