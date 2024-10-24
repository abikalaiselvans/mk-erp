<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false" %>
<html>
<body>
<form action="../reports">
<%-- ${param.file }<br> --%>


<center><table>
<tr><td><input type="hidden" name="file" value="${param.file }"/></td></tr> 
<tr><td><input type="hidden" name="query" value="${param.query }"/></td></tr> 
<tr><td>Export Type:</td><td><select name="export">
<option>pdf</option>
<option>rtf</option>
<option>html</option>
<option>xls</option>
<option>csv</option>
</select></td></tr>
<tr><td colspan="2"><input type="submit" value="Submit" /></td></tr>
<tr><td>

<c:if test="${download != null }">

 <a href="${download}">Download File</a> 
</c:if>

</td></tr>
</table></center>

</form>
</body>
</html>