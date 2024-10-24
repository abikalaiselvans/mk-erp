  <%@ page import="DBConnection.GetConnection"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<br>
<br>
<%
out.println("Connection : "+GetConnection.getJNDIConnection());

%>
<br>
<sql:query var="rs" dataSource="jdbc/test">
  select CHR_EMPID from com_m_staff
</sql:query>


<html>
  <head>
    <title>DB Test</title>
  </head>
  <body>
    <h2>Results</h2>

    <c:forEach var="i" items="${rs.rows}">
      Empid: <c:out value="${i.CHR_EMPID}"/><br>
    </c:forEach>
  </body>
</html>

 
