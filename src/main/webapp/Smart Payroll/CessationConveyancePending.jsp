<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.common.*"%>
<%
try
{
%>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 <style type="text/css">
 @import url("../JavaScript/SmartStyles.css");
 </style>
 <body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td valign="bottom">&nbsp;</td>
	</tr>
	<tr>
		<td valign="bottom">&nbsp;</td>
	</tr>
	 
	<tr>
	  <td align="center"><h1>
	  <%
	  out.println(request.getParameter("er"));
	  String empid = ""+request.getParameter("staffid");
	  
	  %>
      </h1></td>
  </tr>
	 
	<tr>
		<td align="center">  
		 
         <%
		 	String sql ="SELECT FIND_A_EMPLOYEE_ID_NAME(CHR_EMPID),FIND_A_EMPLOYEE_REPORTING_TO(CHR_EMPID),";
			sql = sql+"	DATE_FORMAT(DAT_CONDATE,'%d-%m-%Y'),CHR_FROM,CHR_TO,DOU_KM,DOU_TRAVEL,DOU_TRAIN,";
			sql = sql+"	DOU_AUTO,DOU_LUNCH,DOU_TELEPHONE,CHR_OTHERDESC, DOU_OTHERAMT,DOU_TOTAL, IF(CHR_ACCSTATUS='N','Pending',CHR_ACCSTATUS)";
			sql = sql+"	FROM conveyance_t_conveyance ";
			sql = sql+" WHERE  CHR_ACCEPT='N'  AND CHR_EMPID='"+empid+"'  ORDER BY DAT_CONDATE";
			//out.println(sql);
			String data[][]= CommonFunctions.QueryExecute(sql);
			if(data.length>0)
			{
					out.println("<center>");
					out.println("<table  id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC'>");
					out.println("<tr  class='MRow1'>");
					out.println("<td class='boldEleven' align='center'><b>S.No</b></td>");
					out.println("<td class='boldEleven' align='center'><b>Employee</b></td>");
					out.println("<td class='boldEleven' align='center'><b>Reporting To</b></td>");
					out.println("<td class='boldEleven' align='center'><b>Date</b></td>");
					out.println("<td class='boldEleven' align='center'><b>From</b></td>");
					out.println("<td class='boldEleven' align='center'><b>To</b></td>");
					out.println("<td class='boldEleven' align='center'><b>Kilometer</b></td>");
					out.println("<td class='boldEleven' align='center'><b>Travel</b></td>");
					out.println("<td class='boldEleven' align='center'><b>Train</b></td>");
					out.println("<td class='boldEleven' align='center'><b>Auto</b></td>");
					out.println("<td class='boldEleven' align='center'><b>Lunch</b></td>");
					out.println("<td class='boldEleven' align='center'><b>Telephone</b></td>");
					out.println("<td class='boldEleven' align='center'><b>Other Description</b></td>");
					out.println("<td class='boldEleven' align='center'><b>Other Amount</b></td>");
					out.println("<td class='boldEleven' align='center'><b>Total</b></td>");
					out.println("<td class='boldEleven' align='center'><b>Accept</b></td>");
					out.println("</tr>");
					for(int u=0;u<data.length;u++)
					{
						if(u%2==0)
							out.println("<tr class='MRow3'>");
						else
							out.println("<tr class='MRow4'>");
						out.println("<td class='boldEleven'>"+(u+1)+".</td>");
						out.println("<td class='boldEleven'>"+data[u][0]+"</td>");
						out.println("<td class='boldEleven'>"+data[u][1]+"</td>");
						out.println("<td class='boldEleven'>"+data[u][2]+"</td>");
						out.println("<td class='boldEleven'>"+data[u][3]+"</td>");
						out.println("<td class='boldEleven'>"+data[u][4]+"</td>");
						out.println("<td class='boldEleven'>"+data[u][5]+"</td>");
						out.println("<td class='boldEleven'>"+data[u][6]+"</td>");
						out.println("<td class='boldEleven'>"+data[u][7]+"</td>");
						out.println("<td class='boldEleven'>"+data[u][8]+"</td>");
						out.println("<td class='boldEleven'>"+data[u][9]+"</td>");
						out.println("<td class='boldEleven'>"+data[u][10]+"</td>");
						out.println("<td class='boldEleven'>"+data[u][11]+"</td>");
						out.println("<td class='boldEleven'>"+data[u][12]+"</td>");
						out.println("<td class='boldEleven'>"+data[u][13]+"</td>");
						out.println("<td class='boldEleven'>"+data[u][14]+"</td>");	
						out.println("</tr>");
						
					}
					out.println("</table>");
					out.println("</center>");
			}
		 %>
         
		 		</td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
	  <td><table width="56" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td width="56"><input class="ButtonHead" type="Button"	name="Button"  	id="Button"  value="Close"   accesskey="c" 
					onClick="redirect('EmployeeCessation.jsp')"></td>
        </tr>
      </table></td>
  </tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>

<%@ include file="../footer.jsp"%>
</body>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>