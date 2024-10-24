<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<body>
<form action="../formq" method="post">
<table width="260" align="center" cellpadding="3" cellspacing="2">
<tr>
<td>Month:</td>
<td><select name="month">
<c:forTokens var="m" items="January,February,March,April,May,June,July,August,September,October,November,December" delims=",">
<option>${m}</option>
</c:forTokens>
</select></td>
</tr>
<tr>
<td>Year:
  <input type="hidden" name="file" value="Rept_JESIFormQ1.jrxml"/></td>
<td><select name="year">
<c:forEach begin="2000" end="2014" step="1" var="y">
<option >${y}</option>
</c:forEach>
</select></td></tr>
  
<!-- <tr><td>Export Type:</td><td><select name="export">
<option>pdf</option>
<option>rtf</option>
<option>html</option>
<option>xls</option>
<option>csv</option>
</select></td></tr> -->
<tr><td colspan="2"><input type="submit" value="Submit"   accesskey="s"   /></td></tr>
</table>
</form>
</body>