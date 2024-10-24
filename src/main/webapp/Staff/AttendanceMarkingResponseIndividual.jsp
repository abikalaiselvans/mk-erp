<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<%@include file="Redirect.jsp" %>

<script language="javascript" src="../JavaScript/comfunction.js"></script> 
<%
try
{
	String empid = request.getParameter("empid");
	String month = request.getParameter("month");
	String year = request.getParameter("year");
	String sql="";
	String ssql="";
	int tot = DateUtil.totalDays(Integer.parseInt(month), Integer.parseInt(year));
	String monthnamae = DateUtil.getMonth(Integer.parseInt(month));
	
	
	sql = " SELECT CHR_EMPID,DATE_FORMAT(DT_DATE,'%d-%b-%Y'),CHR_MORNING,CHR_EVENING, ";
	sql = sql + " CHR_STATUS,CHR_DESCRIPTION 	FROM  att_m_selfmarking ";
	sql = sql + " WHERE CHR_EMPID ='"+empid+"' ";
	sql = sql + " AND CHR_MONTH='"+monthnamae+"'";
	sql = sql + " AND  INT_YEAR ="+year;
	sql = sql + " ORDER BY DT_DATE ";
	//out.println(sql);
	String data[][] =CommonFunctions.QueryExecute(sql);
	out.println("<center><br><br><br><table width='60%'   class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC'>");
	if(data.length>0)
	{
		out.println("<tr class='MRow1'><td colspan='8' class='boldEleven' align=center><b>ATTENDACE FOR THE MONTH - "+monthnamae+"&nbsp;"+year+" </b>");
		out.println("<tr class='MRow1'>");
		out.println("<td class='boldEleven' align='center'><b>S.No</b></td>");
		out.println("<td class='boldEleven' align='center'><b>Empid</b></td>");
		out.println("<td class='boldEleven' align='center'><b>Date</b></td>");
		out.println("<td class='boldEleven' align='center'><b>Morning</b></td>");
		out.println("<td class='boldEleven' align='center'><b>Evening</b></td>");
		out.println("<td class='boldEleven' align='center'><b>Status</b></td>");
		out.println("<td class='boldEleven' align='center'><b>Description</b></td>"); 
		out.println("</tr>");
		
		for(int u=0; u<data.length;u++)
		{
			if(u%2 == 0)
				out.println("<tr class='MRow1'>" );
			else
				out.println("<tr class='MRow2'>" );
			
			out.println("<td class='boldEleven' >"+(u+1)+".</td>");
			out.println("<td class='boldEleven' >"+data[u][0]+"</td>");
			out.println("<td class='boldEleven' >"+data[u][1]+"</td>");
			//morning
			if("SUN".equals(data[u][2].trim()))
				out.println("<td class='boldEleven' ><b>Sunday</td>");  
			else if("PRE".equals(data[u][2].trim()))
				out.println("<td class='boldEleven' >Present</td>"); 
			else if("ABS".equals(data[u][2].trim()))
				out.println("<td class='boldEleven' ><font class='boldred'> Absent</font></td>"); 
			else if("PER".equals(data[u][2].trim()))
				out.println("<td class='boldEleven' ><font class='boldred'> Permission</font></td>"); 	
			else if("LEA".equals(data[u][2].trim()))
				out.println("<td class='boldEleven' >Leave</td>"); 
			else if("OND".equals(data[u][2].trim()))
				out.println("<td class='boldEleven' >Onduty</td>"); 	
			else if("LAT".equals(data[u][2].trim()))
				out.println("<td class='boldEleven' ><font class='boldred'>Late</font></td>"); 
			else if("HOL".equals(data[u][2].trim()))
				out.println("<td class='boldEleven' ><b> Holiday</td>"); 
			else	
				out.println("<td class='boldEleven' > -</td>"); 	
				
 			
			//evening
			if("SUN".equals(data[u][3].trim()))
				out.println("<td class='boldEleven' ><b>Sunday</td>"); 
			else if("PRE".equals(data[u][3].trim()))
				out.println("<td class='boldEleven' > Present</td>"); 
			else if("PER".equals(data[u][3].trim()))
				out.println("<td class='boldEleven' > Permission</td>"); 
			else if("ABS".equals(data[u][3].trim()))
				out.println("<td class='boldEleven' ><font class='boldred'> Absent</font></td>"); 
			else if("LEA".equals(data[u][3].trim()))
				out.println("<td class='boldEleven' > Leave</td>"); 	
			else if("OND".equals(data[u][3].trim()))
				out.println("<td class='boldEleven' > Onduty</td>"); 
			else if("LAT".equals(data[u][3].trim()))
				out.println("<td class='boldEleven' > Late</td>"); 
			else if("HOL".equals(data[u][3].trim()))
				out.println("<td class='boldEleven' ><b> Holiday</td>"); 
			else	
				out.println("<td class='boldEleven' > -</td>"); 
			
			//Status
			if("Y".equals(data[u][4].trim()))
				out.println("<td class='boldEleven' align='center'><b>Accept</b></td>");
			else if("R".equals(data[u][4].trim()))
				out.println("<td class='boldEleven' align='center'><b>Reject</b></td>");
			else if("N".equals(data[u][4].trim()))
				out.println("<td class='boldEleven' align='center'><b>Pending</b></td>");
			
			 
			//Description
			out.println("<td class='boldEleven' align='center'><b>"+data[u][5].trim()+"</b></td>"); 
			out.println("</tr>");
		}
	}
	else
	{
		out.println("<tr class='MRow1'><td colspan='7'> <br><br><center><font class='boldred'>Data not found...</font></center>");
	}
	out.println("</table></center>");
	out.println("<br><br>");
	 
}
catch(Exception e)
{
}
%>

<table width="63" border="0" align="center" cellpadding="2"
								cellspacing="2">
            <tr>
              
              <td width="55"><div align="center">
                <input name="Button" type="Button"
										class="buttonbold"  value="Close"   accesskey="c" 
										 onClick="redirect('iframeStaffMain.jsp')">
              </div></td>
            </tr>
</table>