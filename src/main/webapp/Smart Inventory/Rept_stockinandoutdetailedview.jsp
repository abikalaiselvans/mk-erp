 <%@ page import="java.io.*,java.util.*" errorPage="../error/index.jsp"%>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<body >
<script language="javascript">
 function Print(query)
	{
		var width="600", height="400";
  		var left = (screen.width/2) - width/2;
		var top = (screen.height/2) - height/2;
  		var styleStr = 'menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
		newWindow = window.open(query,"subWind",styleStr);
		newWindow.focus( );
	}
	
</script>
<%@ include file="indexinv.jsp"%>
<div>
<%
try
{
	 
		String type = request.getParameter("type");
		String sql = request.getParameter("sql");
		String inout = request.getParameter("inout");
		//out.println(sql);
		String repdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		out.println("<br><br><br>");
		out.println("<table width='80%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' align='center'>");
		out.println("<tr bgcolor='#ffffff'>");
		out.println("<td colspan=10 class='boldEleven' align=center><b>STOCK IN </b></td>");
		out.println("<tr bgcolor='#ffffff'>");
		
		if("IN".equals(inout))
		{
			out.println("<td class='boldEleven'><b>S.NO </td>");
			out.println("<td class='boldEleven'><b>TYPE</td>");
			out.println("<td class='boldEleven'><b>ITEM / PRODUCT CODE</td>");
			out.println("<td class='boldEleven'><b>DESCRIPTION</td>");
			out.println("<td class='boldEleven'><b>INWARD INVOICE</td>");
			out.println("<td class='boldEleven'><b>SERIAL NUMBER</td>");
			
			out.println("</tr>");
			if(repdata.length>0)
			{
				for(int u=0;u<repdata.length;u++)
				{
					if(u%2==0)
						out.println("<tr class='MRow1'>");
					else
						out.println("<tr class='MRow2'>");
					out.println("<td class='boldEleven'>"+(u+1)+"</td>");
					
					if("I".equals(type))
						out.println("<td class='boldEleven'>ITEM</td>");
					else
						out.println("<td class='boldEleven'>PRODUCT</td>");
					out.println("<td class='boldEleven'>"+ repdata[u][0]+"</td>");
					out.println("<td class='boldEleven'>"+repdata[u][1] +"</td>");
					out.println("<td class='boldEleven'><a href='DirectGoodsReceiveViewList.jsp?gdreceiveno="+repdata[u][2] +"'>"+repdata[u][2] +"</a></td>"); 
					out.println("<td class='boldEleven'>"+repdata[u][3] +"</td>"); 
					out.println("</tr>"); 
				}
			}
			
			
			
		}
		
		
		
		if("OUT".equals(inout))
		{
			out.println("<td class='boldEleven'><b>S.NO </td>");
			out.println("<td class='boldEleven'><b>TYPE</td>");
			out.println("<td class='boldEleven'><b>ITEM / PRODUCT CODE</td>");
			out.println("<td class='boldEleven'><b>DESCRIPTION</td>");
			out.println("<td class='boldEleven'><b>SALES INVOICE</td>");
			out.println("<td class='boldEleven'><b>SERIAL NUMBER</td>");
			
			out.println("</tr>");
			if(repdata.length>0)
			{
				for(int u=0;u<repdata.length;u++)
				{
					if(u%2==0)
						out.println("<tr class='MRow1'>");
					else
						out.println("<tr class='MRow2'>");
					out.println("<td class='boldEleven'>"+(u+1)+"</td>");
					
					if("I".equals(type))
						out.println("<td class='boldEleven'>ITEM</td>");
					else
						out.println("<td class='boldEleven'>PRODUCT</td>");
					
					out.println("<td class='boldEleven'>"+ repdata[u][0]+"</td>");
					out.println("<td class='boldEleven'>"+repdata[u][1] +"</td>");
					out.println("<td class='boldEleven'><a href='SwapSaleSerialView.jsp?salno="+repdata[u][2] +"'>"+repdata[u][2] +"</a></td>"); 
					out.println("<td class='boldEleven'>"+repdata[u][3] +"</td>"); 
					out.println("</tr>"); 
				}
			}
			
			
			
		}
		out.println("</table>"); 
		 
 }
 catch(Exception e)
 {
 	out.println(e.getMessage());
 }
	  	
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
			onClick="windowSave('StockInandOut.txt')"><img
			src="../Image/report/text.gif" width="15" height="14" border="0"></a></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="Document" href=javascript:;
			onClick="windowSave('StockInandOut.doc')"><img
			src="../Image/report/MS.GIF" width="15" height="14" border="0"></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="HTML" href=javascript:;
			onClick="windowSave('StockInandOut.html')"><img
			src="../Image/report/IE.GIF" width="15" height="14" border="0"></a></div>
		</td>
		<!--<td class="boldEleven">
		<div align="center"><a
			href="javascript:Print('StockInandOutPrintpage.jsp')"><img
			src="../Image/report/print.gif" width="16" height="16" border="0"></a></div>
		</td>-->
	</tr>
</table>

<p>
  <%@ include file="../footer.jsp"%>
</p>
<p>&nbsp;</p>
 <p>&nbsp;</p>
</body>
</html>
