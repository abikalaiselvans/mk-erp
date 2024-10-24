<%@ page import="java.io.*,java.util.*" errorPage="../error/index.jsp"%>
<%
try
{
%>
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
 <%
 	String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_ACCESSORIEID,CHR_ACCESSORIENAME, CHR_DESC FROM inv_m_accessoriesitem  ORDER BY CHR_ACCESSORIENAME");
	if(data.length>0)
	{
		out.println("<br><br><br><br><br><br><center>");
		out.println("<table width='60%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
		out.println("<tr class='MRow1'><td  class='boldEleven' colspan='3'><center><b>Accessories List</b></center>");
		out.println("<tr class='MRow1'><td  class='boldEleven'><b>S.No");
		out.println("<td  class='boldEleven'><b>Name");
		out.println("<td  class='boldEleven'><b>Description");
		for(int u=0;u<data.length;u++)
		{
			if(u%2==1)
				out.println("<tr class='MRow1'>");
			else	
				out.println("<tr class='MRow2'>");
			out.println("<td  class='boldEleven'>"+(u+1));
			out.println("<td  class='boldEleven'>"+data[u][1]);
			out.println("<td  class='boldEleven'>"+data[u][2]);	

		}
		out.println("</table>");
		out.println("</center>");
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
			onClick="windowSave('sample.txt')"><img
			src="../Image/report/text.gif" width="15" height="14" border="0"></a></a></div>		</td>
		<td class="boldEleven">
		<div align="center"><a title="Document" href=javascript:;
			onClick="windowSave('sample.doc')"><img
			src="../Image/report/MS.GIF" width="15" height="14" border="0"></a></div>		</td>
		<td class="boldEleven">
		<div align="center"><a title="HTML" href=javascript:;
			onClick="windowSave('sample.html')"><img
			src="../Image/report/IE.GIF" width="15" height="14" border="0"></a></div>		</td>
	</tr>
</table>
<%
}
 catch(Exception e)
 {
 	out.println(e.getMessage());
 }
 %>
<%@ include file="../footer.jsp"%>
</body>
</html>
