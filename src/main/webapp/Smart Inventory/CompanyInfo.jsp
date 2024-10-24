

<html>
<head>
<title>:: INVENTORY ::</title></head>
 
<body    leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	 
	background="../Image/Smart%20Attendance/background1.jpg">

<table width="1000" height="158" border="0" cellpadding="0"
	cellspacing="0">
	<!--DWLayoutTable-->
	<tr>
		<td height="110" colspan="3" valign="top"><embed
			src="../Image/General/college.swf" width="1000" height="110"></td>
	</tr>
	<tr>
		<td width="838" height="14"></td>
		<td width="153"></td>
		<td width="9"></td>
	</tr>
	<tr>
		<td height="23"></td>
		<td valign="top">
		<table width="100%" border="1" cellpadding="0" cellspacing="0"
			frame="lhs" bordercolor="#202B78">
			<!--DWLayoutTable-->
			<tr>
				<td width="41" height="19" align="center" valign="middle"><a
					href="mailto:">Mail</a></td>
				<td width="44" align="center" valign="middle"><a href="../Home.jsp" target="_parent">Home</a></td>
				<td width="56" align="center" valign="middle"><a
					href="../Logout.jsp" target="_parent">Logout</a></td>
				<td></td>
			</tr>
		</table>
		</td>
		<td></td>
	</tr>
	<tr>
		<td height="11"></td>
		<td></td>
		<td></td>
	</tr>
</table>
<%@ include file="Inventory_menu.jsp"%>
<center>
<% response.sendRedirect("../Common/CompanyMaster.jsp?path=INV"); %>
</center>
<%@ include file="../footer.jsp"%>
</html>
