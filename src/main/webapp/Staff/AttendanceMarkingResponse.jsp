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
	int tot = DateUtil.totalDays(Integer.parseInt(month), Integer.parseInt(year));
	String mon = DateUtil.getMonth(Integer.parseInt(month));
	sql =" SELECT * FROM att_t_registerselfmarking WHERE CHR_EMPID='"+empid+"'  AND INT_YEAR="+year+" AND  CHR_MONTH ='"+mon+"' ";
	String data[][] =CommonFunctions.QueryExecute(sql);
	
	sql = " SELECT MONTHNAME(now()) , YEAR(NOW()), DAY(now()) ";
	String mdata[][] =CommonFunctions.QueryExecute(sql); 
	if(mon.equals( mdata[0][0]) && year.equals( mdata[0][1]) )
		tot = Integer.parseInt(mdata[0][2])	;
		
		
	out.println("<center><br><br><br><table width='60%'   class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC'>");
	if(data.length>0)
	{
		out.println("<tr class='MRow1'><td colspan=5 class='boldEleven' align=center><b>ATTENDACE REPORT FOR THE MONTH - "+mon+" "+year+" </b>");
		out.println("<tr class='MRow1'><td class='boldEleven'  align='center' ><b>S.No");
		out.println("<td class='boldEleven' align='center' ><b>Date");
		out.println("<td class='boldEleven'  align='center' ><b>Morning");
		out.println("<td class='boldEleven' align='center'  ><b>Evening");
		int r = 4;
		int x=0;
		for(int u=1; u<=tot;u++)
		{
			if(u%2 == 0)
				out.println("<tr class='MRow1'><td class='boldEleven' >"+u);
			else
				out.println("<tr class='MRow2'><td class='boldEleven' >"+u);	
			
			out.println("<td class='boldEleven' >"+u+"-"+month+"-"+year);
			//morning
			
			if("SUN".equals(data[0][r].trim()))
				out.println("<td class='boldEleven' ><b>Sunday");
			else if("PRE".equals(data[0][r].trim()))
				out.println("<td class='boldEleven' >Present");
			else if("ABS".equals(data[0][r].trim()))
				out.println("<td class='boldEleven' ><font class='boldred'> Absent</font>");	
			else if("PER".equals(data[0][r].trim()))
				out.println("<td class='boldEleven' ><font class='boldred'> Permission</font>");	
			else if("LEA".equals(data[0][r].trim()))
				out.println("<td class='boldEleven' >Leave");	
			else if("OND".equals(data[0][r].trim()))
				out.println("<td class='boldEleven' >Onduty");	
			else if("LAT".equals(data[0][r].trim()))
				out.println("<td class='boldEleven' ><font class='boldred'>Late</font>");	
			else if("HOL".equals(data[0][r].trim()))
				out.println("<td class='boldEleven' ><b> Holiday");	
			else	
				out.println("<td class='boldEleven' > -");	
				
 			
			//evening
			if("SUN".equals(data[0][r+1].trim()))
				out.println("<td class='boldEleven' ><b>Sunday");
			else if("PRE".equals(data[0][r+1].trim()))
				out.println("<td class='boldEleven' > Present");
			else if("PER".equals(data[0][r+1].trim()))
				out.println("<td class='boldEleven' > Permission");	
			else if("ABS".equals(data[0][r+1].trim()))
				out.println("<td class='boldEleven' ><font class='boldred'> Absent</font>");	
			else if("LEA".equals(data[0][r+1].trim()))
				out.println("<td class='boldEleven' > Leave");	
			else if("OND".equals(data[0][r+1].trim()))
				out.println("<td class='boldEleven' > Onduty");	
			else if("LAT".equals(data[0][r+1].trim()))
				out.println("<td class='boldEleven' > Late");	
			else if("HOL".equals(data[0][r+1].trim()))
				out.println("<td class='boldEleven' ><b> Holiday");	
			else	
				out.println("<td class='boldEleven' > -");	
			
			r = r+2;
		
			
		}
	}
	else
	{
		out.println("<tr class='MRow1'><td colspan=3> <br><br><center><font class='boldred'>Data not found...</font></center>");
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