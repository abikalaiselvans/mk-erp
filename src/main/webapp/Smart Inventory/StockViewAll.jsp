<%@ page import="java.io.*,java.util.*" isErrorPage="false"
	errorPage="../error/error.jsp"%>
<jsp:directive.page import="com.my.org.erp.SmartInventory.Product" />
<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="javascript"
	src="../JavaScript/Inventory/InvStockAjax.js"></script>

<body >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="get">
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
		<table width="896" height="278" border="1" align="center"
			cellpadding="1" cellspacing="1"  >
			<tr class="BackGround">
				<td height="31" class="BackGround">
				<div align="center">Stock for all Branch</div>
				</td>
			</tr>
			<tr>
				<td height="227" valign="top" class="footermenu">
				<div id="divscroll" style="OVERFLOW:auto;width:100%;height:200"
					class="boldEleven">
				<%
		  	
			//String sql = " SELECT INT_BRANCHID,CHR_BRANCHNAME FROM com_m_branch WHERE INT_COMPANYID=2";
			String sql = " SELECT INT_BRANCHID,CHR_BRANCHNAME FROM com_m_branch WHERE INT_BRANCHID in (29,34,36,40)";
			String branchData[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
			sql = "SELECT CHR_ITEMID,CHR_ITEMNAME FROM inv_m_item";
			String itemData[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
			sql= "SELECT CHR_PRODUCTID,CHR_PRODUCTCODE FROM inv_m_produtlist ";
			String productData[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
			
			int column = 2+branchData.length;
			int row = 1;
		 	String link="";
			out.println("<table width=100% cellpadding='2' cellspacing='2' border='0'>");
			out.print("<tr><td ><font class='boldgreen'>S.No<td ><font class='boldgreen'> Type</font><td ><font class='boldgreen'> Item / Product name</font>");
			for(int u=0;u<branchData.length;u++)
				out.println("<td  class='boldEleven'><b>"+branchData[u][1]+"</b></td>");
			
			
			for(int u=0;u<itemData.length;u++)
			{
				out.print("<tr class='MRow3'><td class='boldEleven'>"+row+"<td class='boldEleven'>"+itemData[u][1]+"<td class='boldEleven'>Item");
				row=row+1;
				for(int x=0;x<branchData.length;x++)
				{
					sql=" SELECT INT_STOCKINHAND FROM inv_t_stock WHERE CHR_ITEMID='"+itemData[u][0]+"' AND CHR_TYPE='I'";
					sql = sql +" AND INT_BRANCHID ="+branchData[x][0];
					link="<a href=\"StockEdit.jsp?branch="+branchData[x][0]+"&type=I&itemId="+itemData[u][0]+"\">";
					link = link+"<font class='boldgreen'>"+com.my.org.erp.common.CommonInfo.intGetAnySelectField(sql, "INT_STOCKINHAND");
					link=link+"</font>";
					out.println("<td  class='boldEleven'>"+link+"</td>");
				}	
			
			}
			
			for(int u=0;u<productData.length;u++)
			{
				out.print("<tr  class='MRow4'><td class='boldEleven'>"+row+"<td class='boldEleven'>"+productData[u][1]+"<td class='boldEleven'>Product");
				row=row+1;
				for(int x=0;x<branchData.length;x++)
				{
					sql=" SELECT INT_STOCKINHAND FROM inv_t_stock WHERE CHR_ITEMID='"+productData[u][0]+"' AND CHR_TYPE='P'";
					sql = sql +" AND INT_BRANCHID ="+branchData[x][0];
					
					link="<a href=\"StockEdit.jsp?branch="+branchData[x][0]+"&type=P&itemId="+productData[u][0]+"\">";
					link = link+"<font class='boldgreen'>"+com.my.org.erp.common.CommonInfo.intGetAnySelectField(sql, "INT_STOCKINHAND");
					link=link+"</font>";
					out.println("<td  class='boldEleven'>"+link+"</td>");
				}	
			
			}
			out.println("</table>");
			%>
				</div>

				</td>
			</tr>

		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><input type="hidden" name="filename" value="Item" /> <input
			type="hidden" name="actionS" value="INVItemDelete" /></td>
	</tr>
	<tr>
		<td>
		<table width="60" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<!--DWLayoutTable-->
			<tr>
				<!-- <td width="56" valign="top"><input type="submit" class="buttonbold13" name="Submit3" id="btnDelete" value="Delete" onclick= "return SDelete()" /></td>-->
				<td width="56"><input type="button" class="buttonbold13"
					name="submit"  value="Close"   accesskey="c"  onClick="redirect('StockView.jsp')" /></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td height="20">&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>
</body>
</html>
