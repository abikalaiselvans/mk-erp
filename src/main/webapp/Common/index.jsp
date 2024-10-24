


<body onpaste="return false;" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0">
<%
	String sesUserName=""+session.getAttribute("USRID"); 
%>
<table width="1000" height="147" border="0" cellpadding="0"
	cellspacing="0">
	<!--DWLayoutTable-->
	<tr>
		<td height="110" colspan="7" valign="top"><embed
			src="../Image/General/college.swf" width="1000" height="110"></td>
	</tr>
	<tr>
		<td width="35" height="14"></td>
		<td width="291"></td>
		<td width="131"></td>
		<td width="160"></td>
		<td width="221"></td>
		<td width="153"></td>
		<td width="9"></td>
	</tr>
	<tr>
		<td height="23">&nbsp;</td>
		<td valign="top" class="logindata" style="filter: shadow()"><font
			color="#FFFF00">Welcome,<%= sesUserName %></font></td>
		<td>&nbsp;</td>
		<td valign="top" class="logindata" style="filter: shadow()"><font
			color="#FFFF00">Smart Attendance</font></td>
		<td>&nbsp;</td>
		<td valign="top">
		<table width="100%" border="1" cellpadding="0" cellspacing="0"
			frame="lhs" bordercolor="#202B78">
			<!--DWLayoutTable-->
			<tr>
				<td width="41" height="19" align="center" valign="middle"><a
					href="mailto:software@yahoo.co.in">Mail</a></td>
				<td width="44" align="center" valign="middle"><a
					href="../Home.jsp" target="_parent">Home</a></td>
				<td width="56" align="center" valign="middle"><a
					href="../Logout.jsp" target="_parent">Logout</a></td>
				<td></td>
			</tr>
		</table>
		</td>
		<td></td>
	</tr>
</table>