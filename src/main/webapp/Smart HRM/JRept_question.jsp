<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false" %>
<%@page import="java.util.*" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<form action="../hrmCon" method="post">
<p>
  <input type="hidden" name="pageAction" value="Question" />
</p>
<table align="center">
  <tr><td>Type</td>
<td><select name="qtype">
<option>All</option>
<%
List data=new com.my.org.erp.JasperReport.HRM.HrmBean().getData("SELECT CHR_TESTNAME FROM hrm_m_testtype");
Iterator itr=data.iterator();
while(itr.hasNext()){
%>
<option><%=(String)itr.next() %></option>
<%} %>
</select></td>
</tr>
<tr><td colspan="2" align="center"><input type="submit" value="Submit"/></td></tr>
</table>
</form>
</body>
</html>