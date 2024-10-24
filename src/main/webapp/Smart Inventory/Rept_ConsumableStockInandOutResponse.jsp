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
		double sum=0.0;
		String branchid = request.getParameter("Branch");
		String division = request.getParameter("division");
		String item = request.getParameter("itype");
		 
		
		
					
		String sql ="";
		String cpydata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT b.CHR_COMPANYNAME ,a.CHR_BRANCHNAME FROM com_m_branch a,com_m_company b WHERE a.INT_COMPANYID=b.INT_COMPANYID AND a.INT_BRANCHID="+branchid);
		
		 
			sql = "SELECT a.CHR_PRODUCTID, a.CHR_PRODUCTCODE  FROM  inv_m_produtlist a  WHERE  a.CHR_PTYPE='S' ";
			if(!"0".equals(item))
				sql = sql + " AND a.CHR_PRODUCTID='"+item+"'";
			sql = sql + " ORDER BY a.CHR_PRODUCTCODE,a.INT_PRODUCTGROUPID ";
			//out.println(sql);
			String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		
			out.println("<br><br><br>");
			out.println("<table width='80%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' align='center'>");
			out.println("<tr bgcolor='#ffffff'>");
			out.println("<td colspan=10 class='boldEleven' align=center><b>CONSUMABLE STOCK IN AND OUT  FOR "+cpydata[0][0].toUpperCase()+" @ "+cpydata[0][1].toUpperCase()+"</b></td>");
			out.println("<tr bgcolor='#ffffff'>");
			out.println("<td class='boldEleven'><b>S.NO </td>");
			out.println("<td class='boldEleven'><b>TYPE</td>");
			out.println("<td class='boldEleven'><b>ITEM / PRODUCT GROUP</td>");
			out.println("<td class='boldEleven'><b>ITEM / PRODUCT CODE</td>");
			out.println("<td class='boldEleven'><b>DESCRIPTION</td>");
			out.println("<td class='boldEleven'><b>IN </td>");
			out.println("<td class='boldEleven'><b>OUT</td>");
			out.println("<td class='boldEleven'><b>BALANCE</td>");
			out.println("</tr>");
			int row=0;
			if(data.length>0)
			{
				for(int u=0;u<data.length;u++)
				{
					sql = "";
					sql = sql +" SELECT a.CHR_PRODUCTID,b.CHR_NAME,a.CHR_PRODUCTCODE,a.CHR_PRODUCTDESC,SUM(c.INT_PQTY) ,SUM(c.INT_SQTY),(SUM(c.INT_PQTY)-SUM(c.INT_SQTY)) ";
					sql = sql +" FROM  inv_m_produtlist a ,inv_m_productgroup b,inv_t_vendorgoodsreceivedconsumable c  ";
					sql = sql +" WHERE a.INT_PRODUCTGROUPID= b.INT_PRODUCTGROUPID AND a.CHR_PTYPE='S'  ";
					sql = sql +" AND a.CHR_PRODUCTID = c.CHR_ITEMID   ";
					sql = sql +" AND c.CHR_TYPE='P'  ";
					sql = sql +" AND c.INT_BRANCHID= "+branchid;
					sql = sql +" AND c.CHR_ITEMID ='"+data[u][0]+"'";
					sql = sql +" GROUP BY c.CHR_ITEMID   ";
					//out.println(sql);
					String repdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					
					if(repdata.length>0)
					{
						row=row+1;
						if(row%2==0)
							out.println("<tr class='MRow1'>");
						else
							out.println("<tr class='MRow2'>");
						
						out.println("<td class='boldEleven'>"+row+"</td>");
						out.println("<td class='boldEleven'>PRODUCT</td>");
						out.println("<td class='boldEleven'>"+repdata[0][1]+"</td>");
						out.println("<td class='boldEleven'>"+repdata[0][2]+"</td>");
						out.println("<td class='boldEleven'>"+repdata[0][3]+"</td>");
						out.println("<td class='boldEleven'>"+repdata[0][4]+"</td>");
						out.println("<td class='boldEleven'>"+repdata[0][5]+"</td>");
						out.println("<td class='boldEleven'>"+repdata[0][6]+"</td>");
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
			src="../Image/report/Excel.png" width="15" height="14" border="0"></a>		</div>		</td>

		<td class="boldEleven">
		<div align="center"><a title="Text" href=javascript:;
			onClick="windowSave('StockInandOut.txt')"><img
			src="../Image/report/text.gif" width="15" height="14" border="0"></a></a></div>		</td>
		<td class="boldEleven">
		<div align="center"><a title="Document" href=javascript:;
			onClick="windowSave('StockInandOut.doc')"><img
			src="../Image/report/MS.GIF" width="15" height="14" border="0"></a></div>		</td>
		<td class="boldEleven"><div align="center"><a title="HTML" href=javascript:;
			onClick="windowSave('StockInandOut.html')"><img
			src="../Image/report/IE.GIF" width="15" height="14" border="0"></a></div>	 </td>
		<td class="boldEleven"><a href="javascript:window.close()">Close</a></td>
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
