<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 
 <%
	
	String grade=request.getParameter("grade");
	String year=request.getParameter("Year");
	String office=request.getParameter("office");
	String sql=" ";
	sql = " SELECT a.INT_JOBDEMANDID,a.CHR_JOBGRADE,b.CHR_JOBCODE,b.CHR_JOBTITLE,c.CHR_OFFICENAME, ";
	sql = sql + " DATE_FORMAT(a.DAT_REGISTERDATE,'%d-%m-%Y'), "; 
 	sql = sql + " MONTHNAME(a.DAT_REGISTERDATE),YEAR(a.DAT_REGISTERDATE), ";
 	sql = sql + " a.INT_DEMAND  FROM hrm_m_jobdemand a,hrm_m_jobdesign b,com_m_office c  "; 
	sql = sql + "  WHERE a.INT_JOBID=b.INT_JOBID AND a.INT_OFFICEID= c.INT_OFFICEID "; 
	sql = sql + " AND YEAR(a.DAT_REGISTERDATE) = "+year;
	if(!"0".equals(grade))
	 	sql = sql + " AND a.CHR_JOBGRADE='"+grade+"'";
	if(!"0".equals(office))
	 	sql = sql + " AND a.INT_OFFICEID = "+office ;
	
	String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	if(data.length>0)
	{
		out.println("<center><br><br><br><br><br>");
		out.println("<table width='80%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
		out.println("<tr class='MRow1'> <td class='boldEleven' colspan='12' align='center'><b> DEMAND REPORTS FOR THE YEAR - "+year+"</b></td>");
		out.println("<tr class='MRow1'>");
		out.println("<td class='boldEleven'><b>S.No</b></td>");
		out.println("<td class='boldEleven'><b>GRADE</b></td>");
		out.println("<td class='boldEleven'><b>CODE</b></td>");
		out.println("<td class='boldEleven'><b>TITLE</b></td>");
		out.println("<td class='boldEleven'><b>OFFICE</b></td>");
		out.println("<td class='boldEleven'><b>DATE</b></td>");
		out.println("<td class='boldEleven'><b>MONTH</b></td>");
		out.println("<td class='boldEleven'><b>YEAR</b></td>");
		out.println("<td class='boldEleven'><b>DEMAND</b></td>");
		out.println("</tr>");
		for(int u=0;u<data.length;u++)
		{
			if(u%2==0)
				out.println("<tr class='MRow1'>");	
			else
				out.println("<tr class='MRow2'>");	
			out.println("<td class='boldEleven'>"+(u+1)+"</b>");
			out.println("<td class='boldEleven'>"+data[u][1]+"</td>");
			out.println("<td class='boldEleven'>"+data[u][2]+"</td>");
			out.println("<td class='boldEleven'>"+data[u][3]+"</td>");
			out.println("<td class='boldEleven'>"+data[u][4]+"</td>");
			out.println("<td class='boldEleven'>"+data[u][5]+"</td>");
			out.println("<td class='boldEleven'>"+data[u][6]+"</td>");
			out.println("<td class='boldEleven'>"+data[u][7]+"</td>");
			out.println("<td class='boldEleven'>"+data[u][8]+"</td>");
			out.println("</tr>");
		}
		
		out.println("</table>");
		out.println("</center>");
		
	}	
	
	%>