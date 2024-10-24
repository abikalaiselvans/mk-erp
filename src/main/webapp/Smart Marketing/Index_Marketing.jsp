
<%
	String sesUserName=""+session.getAttribute("USRID"); 
%>
<style type="text/css">
<!--
.style3 {color: #000033; font-weight: bold; }
-->
</style>



 
<style type="text/css">
<!--
.style4 {font-size:45px; font-weight:bold; text-decoration:outerline; font-family: "Times New Roman", "Trebuche MS", Verdana;}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<table width="100%" height="147" border="0" cellpadding="0"
	cellspacing="0">
	<!--DWLayoutTable-->
	<tr>
		<td height="110" colspan="7" valign="top">
		<table width="1002" height="102" border="1" cellpadding="0"
			cellspacing="0" bordercolor="#D65D31" bgcolor="#D65D31">
			<tr>
				<td width="998" height="100" align="center" bgcolor="D65D31"
					 ><span class="tableTITLE1"><font
					color="#FFFFFF">MARKETING </font></span><span class="style4"><font
					color="#FFFFFF"></font></span><span class="tableTITLE1"><font
					color="#FFFFFF"> </font></span></td>
			</tr>
		</table>
		</td>
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
		<td valign="top" class="logindata"  ><span
			class="tablehead1">Welcome :: <%= sesUserName %> </span></td>
		<td>&nbsp;</td>
		<td valign="top" class="logindata"  ><span
			class="tablehead1">Smart Marketing </span></td>
		<td>&nbsp;</td>
		<td valign="top">
		<table width="100%" border="1" cellpadding="0" cellspacing="0"
			frame="lhs" bordercolor="#202B78">
			<!--DWLayoutTable-->
			<tr>
				<td width="41" height="19" align="center" valign="middle"><a
					href="mailto:software@yahoo.co.in">Mail</a></td>
				<td width="44" align="center" valign="middle"><a href="../Home.jsp" target="_parent">Home</a></td>
				<td width="56" align="center" valign="middle"><a
					href="../Logout.jsp" target="_parent">Logout</a></td>
				<td></td>
			</tr>
		</table>
		</td>
		<td></td>
	</tr>
</table>
<%@ include file="Marketing_menu.jsp"%>
