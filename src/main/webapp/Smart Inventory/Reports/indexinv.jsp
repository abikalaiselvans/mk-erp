
<%
	String sesUserName=""+session.getAttribute("USRID"); 
	if(sesUserName.equals("null") ||  sesUserName.equals("")) 
			response.sendRedirect("../../Login.jsp?loginmsg=Login Expired");
	
%>
<style type="text/css">
<!--
.style1 {color: #000033}
.style3 {color: #000033; font-weight: bold; }
-->
</style>

 
<span class="style1"></span>


<table width="1000" height="147" border="0" cellpadding="0"
	cellspacing="0">
	<!--DWLayoutTable-->
	<tr>
		<td height="110" colspan="7" valign="top"><embed
			src="../../Image/General/college.swf" width="1000" height="110"></td>
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
		<td valign="top" class="logindata" style="filter:shadow()"><span
			class="titleheader">Welcome,<%= sesUserName %> </span></td>
		<td>&nbsp;</td>
		<td valign="top" class="logindata" style="filter:shadow()"><span
			class="titleheader">Smart Inventory </span></td>
		<td>&nbsp;</td>
		<td valign="top">
		<table width="100%" border="1" cellpadding="0" cellspacing="0"
			frame="lhs" bordercolor="#202B78">
			<!--DWLayoutTable-->
			<tr>
				<td width="41" height="19" align="center" valign="middle"><a
					href="mailto:software@yahoo.co.in">Mail</a></td>
				<td width="44" align="center" valign="middle"><a
					href="../../Mainscreen.jsp" target="_parent">Home</a></td>
				<td width="56" align="center" valign="middle"><a
					href="../../Logout.jsp" target="_parent">Logout</a></td>
				<td></td>
			</tr>
		</table>
		</td>
		<td></td>
	</tr>
</table>
<%@ include file="Inventory_menu.jsp"%>
