<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false" %>
<%
try
{
%>
 <body>
<form action="../formq" method="post">
<table width="228" align="center">
<tr>
<td>Month:</td>
<td><select name="month">
<c:forTokens var="m" items="January,February,March,April,May,June,July,August,September,October,November,December" delims=",">
<option>${m}</option>
</c:forTokens>
</select>
</td>
</tr>
<tr>
<td>Year:
  <input type="hidden" name="file" value="Rept_JESIFormQ1.jrxml"/></td>
<td><select name="year">
<c:forEach begin="2000" end="2018" step="1" var="y">
<option >${y}</option>
</c:forEach>
</select>
</td></tr>
 <tr><td colspan="2" align="center"><input type="submit" value="Submit"/></td></tr>
</table>
</form>
</body>
<%
}
catch(Exception e)
{
		out.println(e.getMessage());
}
%>