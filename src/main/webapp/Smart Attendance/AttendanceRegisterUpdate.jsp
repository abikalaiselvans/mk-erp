<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>

<title> :: ATTENDANCE ::</title>


 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<body  onpaste="return false;" class="MRow3">
<form  AUTOCOMPLETE = "off"   action="AttendanceRegisterUpdateresponse.jsp" method="post">
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
		if("M".equals(s))
			c=" Morning";
		if("E".equals(s))
			c=" Evening";	
		
		String f1="";
		String f2="";
		if("M".equals(s))
			f1="Checked = checked";
		if("E".equals(s))
			f2="Checked = checked";
		
		String umonth=DateUtil.getMonth(Integer.parseInt(month));
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
		<td class="boldEleven"><%=date+" / " +umonth+" / "+year%> <input
			name="date" type="hidden" id="date" value="<%=date%>"> <input
			name="month" type="hidden" id="month" value="<%=umonth%>"> <input
			name="year" type="hidden" id="year" value="<%=year%>"></td>
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
		<td colspan="2" class="boldEleven">
		<table width="261" border="0" cellspacing="1" cellpadding="1">
			<tr>
				<td width="20" class="boldEleven"><span class="bolddeepblue">
				<input name="ComboDay" id="TxtDay" type="radio" value="P">
				</span></td>
				<td width="50" class="boldEleven">Full Day</td>
				<td width="20" class="boldEleven"><span class="bolddeepblue">
				<input name="ComboDay" type="radio" id="TxtDay1" value="F" <%=f1%>>
				</span></td>
				<td width="52" class="boldEleven">Forenoon</td>
				<td width="20" class="boldEleven"><span class="bolddeepblue">
				<input name="ComboDay" type="radio" id="TxtDay2" value="A" <%=f2%>>
				</span></td>
				<td width="80" class="boldEleven">Afternoon</td>
			</tr>
		</table>
		</td>
		<td class="boldEleven">&nbsp;</td>
	</tr>
	<tr>
		<td class="boldEleven">&nbsp;</td>
		<td colspan="2" class="boldEleven">
		<table width="261" border="0" cellspacing="1" cellpadding="1">
			<tr>
				<td width="20" class="boldEleven"><span class="bolddeepblue">
				<input name="Type" id="radio" type="radio" value="PRE"> </span></td>
				<td width="50" class="boldEleven">Present</td>
				<td width="20" class="boldEleven"><span class="bolddeepblue">
				<input name="Type" type="radio" id="radio2" value="PER" checked>
				</span></td>
				<td width="52" class="boldEleven">Permission</td>
				<td width="20" class="boldEleven"><span class="bolddeepblue">
				<input name="Type" type="radio" id="radio3" value="ABS"> </span></td>
				<td width="80" class="boldEleven">Absent</td>
			</tr>
		</table>
		</td>
		<td class="boldEleven">&nbsp;</td>
	</tr>
	<tr>
		<td class="boldEleven">&nbsp;</td>
		<td colspan="2" class="boldEleven">
		<table width="100" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<td><input name="Submit" type="submit" class="buttonbold"
					value="Submit"></td>
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
</form>
</body>
