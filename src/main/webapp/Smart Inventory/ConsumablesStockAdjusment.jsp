<%@ page import="java.io.*,java.util.*"%>
<%
try
{
%>
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
<script language="JavaScript" src="../JavaScript/calendar1.js" 	type="text/javascript"></script>

<body >
<%@ include file="indexinv.jsp"%><!--ConsumablesStockAdjusmentResponse.jsp-->
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="return Validate()">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
	  <td>
		<%
			
String sql=" SELECT a.CHR_PRODUCTID,a.CHR_PRODUCTCODE,a.CHR_PRODUCTDESC,b.INT_STOCKINHAND ,c.DOU_AVGPRICE  FROM inv_m_produtlist a,inv_t_stock b,inv_t_averageprice c ";
	sql = sql + "	WHERE a.CHR_PRODUCTID=b.CHR_ITEMID AND a.CHR_PRODUCTID = c.CHR_ITEMID AND b.CHR_ITEMID=c.CHR_ITEMID ";
	sql = sql + "	AND  b.INT_BRANCHID="+session.getAttribute("INVBRANCH");
	sql = sql + "	AND  c.INT_BRANCHID="+session.getAttribute("INVBRANCH");
	sql = sql + "	AND a.CHR_PTYPE='S' GROUP BY a.CHR_PRODUCTCODE ORDER BY a.CHR_PRODUCTCODE "; 
	
	
	 
 
	String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	out.println("<center><table><table  id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
	out.println("<tr class='MRow1'><td colspan='6' class='boldEleven'><center> <b>Consumables Stock Adjustments");
	out.println("<tr class='MRow2'><td class='boldEleven' ><b>S.No");
	out.println("<td class='boldEleven'><b>Product Code");
	out.println("<td class='boldEleven'><b>Product Description");
	out.println("<td class='boldEleven'><b>Smart Stock");
	out.println("<td class='boldEleven'><b>Stock In Hand");
	out.println("<td class='boldEleven'><b>Average Price");
	
	if(data.length>0)
	{
		String name="stockinhand";
		String price="price";
		for(int u=0;u<data.length;u++)
		{
			if(u%2==0)
				out.println("<tr class='MRow1'>");
			else
				out.println("<tr class='MRow2'>");	
			
			out.println("<td>"+(u+1));
			out.println("<td class='boldEleven'>"+data[u][1]);
			out.println("<td class='boldEleven'>"+data[u][2]);
			out.println("<td class='boldEleven'>"+data[u][3]);
			out.println("<td class='boldEleven'><input name='pid"+(u+1)+"' id='pid"+(u+1)+"' type='hidden' value='"+data[u][0]+"' >");
			out.println("<input name='"+(name+(u+1))+"' type='text' value="+data[u][3]+" onKeyPress=\"numericValue('"+(name+(u+1))+"','6')\" size=10 class='formText135' style='text-align:right'>");
			
			if("-".equals(data[u][4].trim()) || "null".equals(data[u][4].trim()))
				out.println("<td class='boldEleven'><input name='"+(price+(u+1))+"' type='text' value='0' onKeyPress=\"numericValue('"+(price+(u+1))+"','6')\" size=10 class='formText135' style='text-align:right'>");
			else
				out.println("<td class='boldEleven'><input name='"+(price+(u+1))+"' type='text' value="+data[u][4]+" onKeyPress=\"numericValue('"+(price+(u+1))+"','6')\" size=10 class='formText135' style='text-align:right'>");
			
		}	
	}	
	out.println("</table></center>");	
			
		%>
		<input name="length" type="hidden" value="<%=data.length%>">
		<input name="bid" type="hidden" value="<%=""+session.getAttribute("INVBRANCH")%>">
		<input name="filename" type="hidden" id="filename"
										value="StockAdjument">
        <input name="actionS"
										type="hidden" id="actionS" value="INVStockAdjument"></td>
	</tr>
	<tr>
	  <td> </td>
	</tr>
	<tr>
		<td><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input name="Submit" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   ></td>
                    <td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect( 'InventoryMains.jsp')"></td>
                  </tr>
                </table></td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<script language="JavaScript">

function Validate()
  {
	
	var s="<%=data.length%>";
	var name="";
	var price="";
	for(u=0;u<s;u++)
	{
		name = name+"stockinhand"+(u+1)+",";
		price = price+"price"+(u+1)+",";
	}	
	var textname= name.split(",");
	var pricelist= price.split(",");
	for( i=0; i<textname.length-1; i++)
	{
		window.status="Checking Data ..."+textname[i];
		var ck = "Enter Data...in  "+(i+1)+"  Row";
		if(checkNull(textname[i],ck) && checkNull(pricelist[i],ck))
			d=1;
		else
			return false;				
	}
			 	
 } 	
</script> <%@ include file="../footer.jsp"%></form>
</body>
</html>

<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
