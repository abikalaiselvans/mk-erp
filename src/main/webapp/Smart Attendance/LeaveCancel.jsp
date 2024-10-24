<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>

<title> :: ATTENDANCE ::</title>


 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<body  onpaste="return false;" class="MRow3">
<form  AUTOCOMPLETE = "off"   action="LeaveCancelresponse.jsp" method="post">
<%
try
{

%>

<table width="399" height="125" border="0" align="center"
	cellpadding="3" cellspacing="3">
	<tr>
		<td width="32" class="boldEleven">&nbsp;</td>
		<td colspan="2" class="boldEleven">
		<%
			String empid = request.getParameter("empid");
			String column = request.getParameter("column");
			String month = request.getParameter("month");
			String year = request.getParameter("year");
			String date = request.getParameter("date");
			String name = request.getParameter("name");
			String s = request.getParameter("s");
			String c="";
			String field="";
			if("M".equals(s))
			{
				field=" CHR_MORNING"+date;
				c="Morning";
			}	
			if("E".equals(s))
			{
				field=" CHR_EVENING"+date;	
				c="Evening";
			}
			String umonth=DateUtil.getMonth(Integer.parseInt(month));
			String sql = "SELECT COUNT(*) FROM att_t_register WHERE "+field+"='LEA' AND ";
			sql = sql + "  CHR_EMPID='"+empid+"' AND CHR_MONTH='"+umonth+"' AND INT_YEAR="+year;
			if(!com.my.org.erp.common.CommonFunction.RecordExist(sql))
			{
				%>
				
				<script language="javascript">
					window.close();
				</script> 
				<%
			}
			
	%>
		</td>
		<td width="35" class="boldEleven">&nbsp;</td>
	</tr>
	<tr>
		<td class="boldEleven">&nbsp;</td>
		<td width="87" class="copyright">Emp I d</td>
		<td width="119" class="boldEleven"><%=empid%> <input name="empid"
			type="hidden" id="empid" value="<%=empid%>"></td>
		<td class="boldEleven">&nbsp;</td>
	</tr>
	<tr>
		<td class="boldEleven">&nbsp;</td>
		<td class="copyright">Name</td>
		<td class="boldEleven"><%=name%></td>
		<td class="boldEleven">&nbsp;</td>
	</tr>
	<tr>
		<td class="boldEleven">&nbsp;</td>
		<td class="copyright">Date</td>
		<td class="boldEleven"><%=date+" / " +umonth+" / "+year%>
		 <input	name="date" type="hidden" id="date" value="<%=date%>"> 
		 <input	name="month" type="hidden" id="month" value="<%=umonth%>"> 
		 <input	name="year" type="hidden" id="year" value="<%=year%>">
		 <input	name="field" type="hidden" id="field" value="<%=field%>">
		 
		 </td>
		<td class="boldEleven">&nbsp;</td>
	</tr>
	<tr>
		<td class="boldEleven">&nbsp;</td>
		<td class="copyright">Session</td>
		<td class="boldEleven"><%=c%></td>
		<td class="boldEleven">&nbsp;</td>
	</tr>
	<tr>
		<td class="boldEleven">&nbsp;</td>
	  <td colspan="2" class="boldEleven">&nbsp;</td>
		<td class="boldEleven">&nbsp;</td>
	</tr>
	<tr>
		<td class="boldEleven">&nbsp;</td>
	  <td colspan="2" class="boldEleven">&nbsp;</td>
		<td class="boldEleven">&nbsp;</td>
	</tr>
	<tr>
		<td class="boldEleven">&nbsp;</td>
		<td colspan="2" class="boldEleven">
		<table width="100" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<td><input name="Submit" type="submit" class="buttonbold"
					value="Leave Cancel"></td>
			</tr>
		</table>
		</td>
		<td class="boldEleven">&nbsp;</td>
	</tr>
	<tr>
		<td class="boldEleven">&nbsp;</td>
		<td class="boldEleven">&nbsp;</td>
		<td class="boldEleven">&nbsp;</td>
		<td class="boldEleven">&nbsp;</td>
	</tr>
</table>
<%
	}
	catch(	Exception e)
	{
	}
%>	
</form>
</body>
