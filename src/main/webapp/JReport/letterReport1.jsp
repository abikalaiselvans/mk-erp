<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false" %>
<html>
<body>
<form action="../letter">
${param.file }<br>

<center><table>
<%-- <tr><td><input type="hidden" name="file" value="${param.file }"/></td></tr>  --%>
<tr><td><input type="hidden" name="file" value="Letter.jrxml"/></td></tr> 
<tr><td>Employee ID</td><td><input name="empid"/></td></tr>
<tr><td>Export Type:</td><td><select name="export">
<option value="pdf">pdf</option>
<option value="rtf">rtf</option>
<option value="html">html</option>
<option value="xls">xls</option>
<option value="csv">csv</option>
</select></td></tr>
<tr><td colspan="2"><input type="submit" value="Submit"   accesskey="s"    /></td></tr>
<tr><td>

<c:if test="${download != null }">

 <a href="${download}">Download File</a> 
</c:if>

</td></tr>
</table></center>

</form>
</body>
</html>