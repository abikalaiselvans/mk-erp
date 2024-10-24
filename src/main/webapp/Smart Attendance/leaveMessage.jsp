<%
try
{
	String message = request.getParameter("message");
%>
<style type="text/css">
@import url("../JavaScript/SmartStyles.css");
</style>

<br><br>
<center>
<font class="bolddeepred"><%=message%></font>
<br>
<table>
<tr><td width='56'>
<input name="close" type="button" class="buttonbold"  value="Close"   accesskey="c"  onClick="javascript:window.close()">
</td>
</tr>
</table>
</center>
<%

}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>