<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>

<%
try
{
%>

 <html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<form action="../hrmCon" method="post">
<input type="hidden" name="pageAction" value="JobDesign" />
<table align="center">
<tr><th colspan="2">Job Design</th></tr>
<tr><td colspan="2">&nbsp;</td></tr>
<tr><td>Job Grade</td><td><select name="grade">
<option>All</option><option>Group-1</option><option>Group-2</option><option>Group-3</option>
</select></td></tr>

<tr><td colspan="2"><input type="submit" value="Submit"/></td></tr>
</table> 
</form>
</body>
</html>

<%
}
catch(Exception e)
{
		System.out.println(e.getMessage());
}
%>