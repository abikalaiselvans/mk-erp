<%@ page import="java.io.*,java.util.*"%>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<body >

<%@ include file="indexinv.jsp"%>

<%
	java.text.NumberFormat formatter = java.text.NumberFormat.getInstance();
	formatter.setMaximumFractionDigits(2);
   	formatter.setMinimumFractionDigits(2); 
	String sql = ""+request.getParameter("sql");
	String dt = ""+request.getParameter("dt");
	String data[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
	out.print("<br><br><br>");
	out.println("<table id='myTable' align=center width='70%' border='1' cellspacing='0' cellpadding='5'  style='border-width: 2px; border-color: #F48442; border-style: solid;'>");
	out.println("<tr>");
	out.println("<td colspan=8 class='boldEleven' align=center><b>INWARD ON  :: "+dt+"</b></td>");
	
	out.println("<tr>");
	out.println("<td class='boldEleven'><b>Purchase No </td>");
	out.println("<td class='boldEleven'><b>Type</td>");
	out.println("<td class='boldEleven'><b>Item / Product Code</td>");
	out.println("<td class='boldEleven'><b>Serial No </td>");
	out.println("<td class='boldEleven'><b>Warranty (yrs)</td>");
	out.println("<td class='boldEleven'><b>Received Date </td>");
	out.println("<td class='boldEleven'><b>Mode of Inward </td>");
	out.println("<td class='boldEleven'><b>Purchase Price </td>");
	out.println("</tr>");
	double  rsum=0.0;
	double  csum=0.0;
	if(data.length >0)
	{
		
		String iname="";
		String itemname="";
		String ptype="";
		double sum=0.0;
		for(int u=0;u<data.length;u++)
		{
			
			if(u%2 == 0)
				out.println("<tr class='MRow1'>");
			else
				out.println("<tr class='MRow2'>");
			out.println("<td class='boldEleven'>"+data[u][0]+"</td>");
			if(data[u][2].equals("I"))
			{
				iname="Item";
				sql = "SELECT CHR_ITEMNAME ,CHR_WARRANTY FROM inv_m_item WHERE CHR_ITEMID='"+data[u][1]+"'";
				itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
			}	
			if(data[u][2].equals("P"))
			{
		  		iname="Product";
		  		sql= "SELECT CHR_PRODUCTCODE,CHR_WARRANTY,CHR_PTYPE FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+data[u][1]+"'";
		  		itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
				ptype=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PTYPE");
			}	
			out.println("<td class='boldEleven'>"+iname+"</td>");
			if("S".equals(ptype))
				out.println("<td class='boldEleven'>"+itemname+"(Consumable)</td>");
			else
				out.println("<td class='boldEleven'>"+itemname+"</td>");
				
			out.println("<td class='boldEleven'>"+data[u][3]+"</td>");
			out.println("<td class='boldEleven'>"+data[u][4]+"</td>");
			out.println("<td class='boldEleven'>"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(data[u][6])+"</td>");
			out.println("<td class='boldEleven'>"+data[u][7]+"</td>");
			out.println("<td class='boldEleven' align='right'>"+com.my.org.erp.common.CommonFunctions.Round(Double.parseDouble(data[u][8]))+"</td>");
			if(!"-".equals(data[u][8]))
				sum = sum +Double.parseDouble(data[u][8]);
			out.println("</tr>");
			out.println();
		}
		rsum= sum;
		out.println("<tr>");
		out.println("<td colspan=7 class='boldEleven' align=right><b>Total Value  </td>");
		out.println("<td align=right class='boldEleven'>"+com.my.org.erp.common.CommonFunctions.Round(sum));
		out.println("<tr><td colspan=8 class='boldEleven' align=center>");
		 
	 }	
	else
	{
		out.println("<tr>");
		out.println("<td height=200 colspan=8 class='errorMessage' align=center ><center>Data not found ....</center></td>");
		
	}
	 
	out.println("<tr><td colspan=8 class='boldEleven' align=center><b>Consumables </td>");
	out.print("<tr><td class='boldEleven' ><b>Purchase Number");
	out.print("<td class='boldEleven' ><b>Type");
	out.print("<td class='boldEleven' ><b>Item/Product");
	out.print("<td class='boldEleven' ><b>Quantity");
	out.print("<td class='boldEleven' ><b>&nbsp;");
	out.print("<td class='boldEleven' ><b>Purchase Date");
	out.print("<td class='boldEleven' ><b>UnitPrice");
	out.print("<td class='boldEleven' ><b>Total");
	
	sql = " SELECT CHR_TYPE,CHR_ITEMID,INT_PQTY,DAT_RECIVEDDATE,CHR_PURCHASEORDERNO,DOU_UNITPRICE  FROM inv_t_vendorgoodsreceivedconsumable WHERE DAT_RECIVEDDATE='"+dt+"' AND INT_BRANCHID="+session.getAttribute("BRANCHID");
	String datas[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
	double ssum=0.0;
	if(datas.length>0)
	{
		for(int u=0;u<datas.length;u++)
		{
			String itemname="";
			if(u%2 ==0)
				out.print("<tr class='MRow1'>");
			else
				out.print("<tr class='MRow1'>");
				
			out.print("<td class='boldEleven' >"+datas[u][4]);
			out.print("<td class='boldEleven' >Product");
			if(datas[u][0].equals("P"))
			{
				 
				sql= "SELECT CHR_PRODUCTCODE,CHR_WARRANTY,CHR_PTYPE FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+datas[u][1]+"'";
				itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
				 
			}	
			out.print("<td class='boldEleven' >"+itemname);
			out.print("<td class='boldEleven' align=right>"+datas[u][2]);
			out.print("<td class='boldEleven' >&nbsp;");
			out.print("<td class='boldEleven' >"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(datas[u][3]));
			out.print("<td class='boldEleven' align=right>"+com.my.org.erp.common.CommonFunctions.Round(Double.parseDouble(datas[u][5])));
			
			out.print("<td class='boldEleven' align=right>"+com.my.org.erp.common.CommonFunctions.Round((Double.parseDouble(datas[u][2])*Double.parseDouble(datas[u][5]))));
			ssum= ssum+	com.my.org.erp.common.CommonFunctions.Round((Double.parseDouble(datas[u][2])*Double.parseDouble(datas[u][5])));
		}
		out.println("<tr><td colspan=7 class='boldEleven' align=right><b> Total Value  </td>");
		out.println("<td  class='boldEleven' align=right>"+ssum);
	}
	else
	{
		out.println("<tr><td colspan=8 class='errorMessage'  ><center>Data not found...</center>");
	}
	
	out.println("<tr><td colspan=7 class='boldEleven' align=right><b> "+rsum+" + "+ssum+" </td>");
	ssum = ssum+rsum;
	out.println("<td  class='boldEleven' align=right>"+ssum);
	
	out.println("<tr><td colspan=8 class='boldEleven' align=center>");
	%>
<div id="Rupees"><script language="javascript">
					  	numberWord("<%=ssum%>","Rupees") 
					  </script></div>
<%
	out.println("</table>");
	out.print("<br> ");
  %>


<table width="184" align="center" cellpadding="15" cellspacing="0">
	<tr>
		<td width="100" height="44" class="boldEleven"><strong>Export
		</strong></td>
		<td class="boldEleven">
		<div align="center"><a title="Excel" href=javascript:;
			onClick=" CreateExcelSheet()"><img
			src="../Image/report/Excel.png" width="15" height="14" border="0"></a>
		</div>
		</td>

		<td class="boldEleven">
		<div align="center"><a title="Text" href=javascript:;
			onClick="windowSave('sample.txt')"><img
			src="../Image/report/text.gif" width="15" height="14" border="0"></a></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="Document" href=javascript:;
			onClick="windowSave('sample.doc')"><img
			src="../Image/report/MS.GIF" width="15" height="14" border="0"></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="HTML" href=javascript:;
			onClick="windowSave('sample.html')"><img
			src="../Image/report/IE.GIF" width="15" height="14" border="0"></a></div>
		</td>
	</tr>
</table>


<%@ include file="../footer.jsp"%>
</div>
</body>
</html>
