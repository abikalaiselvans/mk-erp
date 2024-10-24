<%@ page import="java.io.*,java.util.*,com.my.org.erp.common.*"%>

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
<style type="text/css">
<!--
body {
	margin-left: .5cm;
	margin-top: 1px;
	margin-right: .5px;
	margin-bottom: 1px;
}
-->
</style>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<body >


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
		<%
	String branchid=""+session.getAttribute("BRANCHID");
	String sql ="SELECT CHR_TYPE,CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY,DOU_UNITPRICE FROM inv_t_vendorgoodsreceived WHERE CHR_QUALITY='N' AND INT_BRANCHID="+branchid;
	String data[][] = CommonFunction.RecordSetArray( sql);
	if(data.length>0)
	{
		out.println("<table  id='myTable' border=1  cellspacing=0 cellpadding=5>");
		out.println("<tr><td colspan=7 align= center class='boldEleven'><b>Fault Material in Stock");
		
		%> <script language="JavaScript" type="text/javascript">
		var d=new Date()
		var weekday=new Array("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday")
		var monthname=new Array("January","February","March","April","May","June","July","August","September","October","November","December")
		document.write('( ' +weekday[d.getDay()]+", "+d.getDate()+" - "+monthname[d.getMonth()]+"' " +d.getFullYear()  +' )');
</script> <%
		out.println("<tr><td class='boldEleven'><b>S.No<td class='boldEleven'><b>type");
		out.println("<td class='boldEleven'><b>Product Code");
		out.println("<td class='boldEleven'><b>Description");
		out.println("<td class='boldEleven'><b>Serial Number");
		out.println("<td class='boldEleven'><b>Warranty (yrs)");
		out.println("<td class='boldEleven'><b>Unit Price");
		String type="";
		String iname="";
		String itemname="";
		String desc="";
		double sum=0.0;
		for(int u=0; u<data.length; u++)
		{
			if(u%2 == 0)
				out.println("<tr class='MRow1'>");
			else
				out.println("<tr class='MRow1'>");
			
			if(data[u][0].equals("I"))
			{
				iname="Item";
				sql = "SELECT CHR_ITEMNAME ,CHR_DES  FROM inv_m_item WHERE CHR_ITEMID='"+data[u][1]+"'";
				itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
				desc=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_DES");
			}	
			if(data[u][0].equals("P"))
			{
			  	iname="Product";
			  	sql= "SELECT CHR_PRODUCTCODE  FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+data[u][1]+"'";
			  	itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
			    desc=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTDESC");
			  
			}				
			out.println("<td class='boldEleven'>"+(u+1));
			out.println("<td class='boldEleven'>"+iname);
			out.println("<td class='boldEleven'>"+itemname);
			out.println("<td class='boldEleven'>"+desc);
			out.println("<td class='boldEleven'>"+data[u][2]);
			out.println("<td class='boldEleven' align=right>"+data[u][3]);
			out.println("<td class='boldEleven' align=right>"+data[u][4]);
			sum= sum+Double.parseDouble(data[u][4]);
		}
		out.println("<tr><td colspan=6 align=right class='boldEleven'><b>Total value ");
		out.println("<td class='boldEleven' align=right >"+com.my.org.erp.common.CommonFunctions.Round(sum));
		out.println("<tr><td colspan=7 align= center class='boldEleven'>");
		%>
		<div id="Rupees"><script language="javascript">
			  	numberWord("<%=sum%>","Rupees") 
			  </script></div>
		<%
		 
		out.println("</table>");
	}
	%>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><input name="filename" type="hidden" value="Ticket" /> <input
			name="actionS" type="hidden" value="INVTicketDelete" /></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>


</body>
</html>
