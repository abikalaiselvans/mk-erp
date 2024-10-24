<%@ page import="java.io.*,java.util.*"%>
<%-- <%@ page import="sun.net.smtp.SmtpClient"%> --%>
<%@ page import="com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.common.*"%> 
<html>
<head>
 
<title>:: ASSET ::</title>


<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../JavaScript/InventoryStyles.css" rel="stylesheet"
	type="text/css">
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 <body>
<%@ include file="index.jsp"%>

<table width="100%" border="0" cellspacing="1" cellpadding="1">
  <tr>
	  <td>&nbsp;</td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
  </tr>
  <tr>
	  <td>
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="300"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
				  <td width="412"><table width="100%" border="0" align="center" cellpadding="5" cellspacing="0">
                    <tr>
                      <td width="11%" class="boldEleven"><div align="left">1</div></td>
                      <td width="89%" class="boldEleven"><a href="Asset_Stock_Report.jsp" target="_self">Stock</a> </td>
                    </tr>
                    <tr>
                      <td class="boldEleven"><div align="left">2</div></td>
                      <td class="boldEleven"><a href="Asset_StockwithSerial_Report.jsp">Stock with Serial number</a> </td>
                    </tr>
                    <tr>
                      <td class="boldEleven"><div align="left">3</div></td>
                      <td class="boldEleven"><a href="Asset_ReturnableStock_Report.jsp">Returnable Stock </a></td>
                    </tr>
                    <tr>
                      <td class="boldEleven"><div align="left">4</div></td>
                      <td class="boldEleven"><a href="Asset_ReturnableStockwithSerial_Report.jsp">Returnable Stock with Serial number</a></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">5</td>
                      <td class="boldEleven"><a href="AssetDateWiseTotalStock.jsp">Date Wise </a></td>
                    </tr>
                    <tr>
                      <td class="boldEleven"><div align="left">6</div></td>
                      <td class="boldEleven"><a href="AssetTotalStock.jsp">Total</a></td>
                    </tr>
					
					<%
						if("F".equals(session.getAttribute("USRTYPE").toString()))
						{
					%>
					<%
					}
					%>
					
                  </table></td>
					<td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
			</tbody>
		</table>	  </td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
  </tr>
</table>
<%@ include file="../footer.jsp"%>
</body>
</html>
