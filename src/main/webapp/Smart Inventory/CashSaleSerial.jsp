<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" errorPage="../error/index.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript"
	src="../JavaScript/Inventory/InvenCustomerAJAX.js"></script>
<script language="JavaScript" src="../JavaScript/AJAX.js"></script>

</head>
<body >
<%@ include file="indexinv.jsp"%>
<%
		try {
		String sql="";
		String salesno = request.getParameter("salno");
		String perdata[][] = com.my.org.erp.common.CommonInfo
		.RecordSetArray("SELECT * FROM inv_t_cashsales WHERE CHR_SALESNO='"
				+ salesno + "'");
		sql = "Select CHR_CUSTOMERNAME from inv_m_customerinfo where INT_CUSTOMERID="
		+ perdata[0][5];
		String custName = CommonInfo.stringGetAnySelectField(sql,
		"CHR_CUSTOMERNAME");
		//onSubmit="return validateValues()"
%>
<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm">


<div align="center"><br />
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="424" border="0" align="center" cellpadding="0"
			cellspacing="0" class="BackGround1">
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
							<td>
							<div align="center"><strong>Cash Sale Serial
							Number </strong></div>
							</td>
						</tr>
						<tr>
							<td>
							<table width="673" border="0" align="center" cellpadding="5"
								cellspacing="5">
								<tr>
									<td width="119" valign="top" class="boldEleven">
									<div align="left">Cash Sale .No</div>
									</td>
									<td width="143" valign="top" class="boldEleven">
									<div align="left"><%=perdata[0][2]%></div>
									</td>
									<td width="168" valign="top" class="boldEleven">
									<div align="left">Sale Date</div>
									</td>
									<td width="178" valign="top" class="boldEleven">
									<div align="left"><%=perdata[0][3]%></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">CustomerName</div>
									</td>
									<td valign="top" class="boldEleven">
									<div align="left"><%=custName%></div>
									</td>
									<td valign="top" class="boldEleven">
									<div align="left"><%-- Customer Address--%></div>
									</td>
									<td valign="top" class="boldEleven">
									<div align="left" class="bolddeepgreen">&nbsp;</div>
									</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td height="9">&nbsp;</td>
						</tr>
						<tr>
							<td height="9">
							<div align="center" id="error" class="bolddeepred"></div>
							</td>
						</tr>
						<tr>
							<td height="9">
							<div align="center">
							<%
									sql = "SELECT INT_ID,CHR_SALESNO,CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY,CHR_TYPE FROM inv_t_cashserialno WHERE CHR_SALESNO ='"
									+ salesno + "' ORDER By INT_ID";
									String recdData[][] = com.my.org.erp.common.CommonInfo.RecordSetArray(sql);
									out.print("<div align='center' id='divscroll' style='OVERFLOW:auto;width:550px;height:200px' class='boldEleven'>");
									out.print(" <table width=500 border='1' cellpadding='1' cellspacing='1' >");
									out.print("<th   class='boldEleven'><b>Type</b></th>");
									out.print("<th   class='boldEleven'><b>Item / Product Code</b></th>");
									out.print("<th   class='boldEleven'><b>Serial No</b></th>");
									out.print("<th   class='boldEleven'><b></b>&nbsp;</th>");									
									out.print("<th   class='boldEleven'><b>Warranty</b></th>");
									int row = 1;
									String h="";
									String h1="";
									String iname="";
									String itemname="";
									  
									
						
									for (int v = 0; v < recdData.length; v++) {
										h="";h1="";
										
										
										
									if(recdData[v][5].equals("I") || recdData[v][5].equals("1"))
									{
										iname="Item";
										sql = "SELECT CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID='"+recdData[v][2]+"'";
										itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
									}	
									if(recdData[v][5].equals("P") || recdData[v][5].equals("2"))
									{
									  iname="Product";
									  sql= "SELECT CHR_PRODUCTCODE FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+recdData[v][2]+"'";
									  itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
									}	
									out.println("<tr><td   class='boldEleven' >"+iname+"</td>");
									out.println("<td  class='boldEleven' >"+itemname+"</td>");
			
													
h="onBlur =\"LoadUniqueCheckSale('serial"+(v+1)+"','Valid"+(v+1)+"' , 'inv_t_vendorgoodsreceived','CHR_SERIALNO','Submit'),getValues('serial','"+recdData.length+"' ,'error' , 'Submit')\" ";
										
								
//h="onBlur=\"getValues('serial','"+recdData.length+"' ,'error' , 'Submit')\"";
h1=" onkeyup=\"LoadUniqueCheckSales('serial"+(v+1)+"','Valid"+(v+1)+"' , 'inv_t_vendorgoodsreceived','CHR_SERIALNO','Submit')\" ";

									
										
										out.print("<td><input  name='serial"+ row+ "'   class='formText135' maxlength='50' size=20 type='text' value='"+ recdData[v][3] + "' "+h+"  " +h1+"/></td>");
										out.println("<td class='boldEleven' width='20'>&nbsp;<div id='Valid"+(v+1)+"'> </div>");
										out.print("<td><input name='warranty"+ row+ "' class='formText135' maxlength='50' size=20 type='text' value='"+ recdData[v][4] + "'>");
										out.println("<input type='hidden' name='itemid"+row+"' value='"+recdData[v][2]+"'>");
										out.print("</tr>");
										row = row + 1;
									}

									out.print("</table> ");
									out.print("</div> ");
									out
									.println("<input type='hidden' name='length' id='length' value='"
											+ row + "'>");
									out
									.println("<input type='hidden' name='salesno' id='salesno' value='"
											+ salesno + "'>");
							%>
							</div>
							<input name="seriallength" type="hidden" id="seriallength"
								value="<%=recdData.length%>"></td>
						</tr>
						<tr>
							<td><input name="filename" type="hidden" value="CashSale" />
							<input name="actionS" type="hidden" value="INVCashSaleAddserial" /></td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td height="38" valign="top" class="boldEleven">
							<table width="147" border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
									<td width="56"><input name="Submit" id="Submit"
										type="submit" class="buttonbold13" value="Submit"   accesskey="s"   ></td>
									<td width="56"><input name="Submit2" type="button"
										class="buttonbold13"  value="Close"   accesskey="c" 
										onClick="redirect('Cash Sale.jsp')"></td>
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
					<td height="6"><spacer height="1" width="1" type="block" /></td>
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
<%
		} catch (Exception e) {
		out.println(e.getMessage());
	}
%>
</form>
<%@ include file="../footer.jsp"%>

</body>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
</html>
