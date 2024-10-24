<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
 
<html>
<head>
<title>SELECT Operation</title>
</head>
<body>
 
<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"  url="jdbc:mysql://localhost/smartcampus" user="root"  password="mythra"/>
 
<sql:query dataSource="${snapshot}" var="result">
SELECT * from com_m_staff;
</sql:query>
 
<table border="1" width="100%">
<tr>
   <th>Emp ID</th>
   <th>First Name</th>
   <th>Last Name</th>
 
</tr>
<c:forEach var="row" items="${result.rows}">
<tr>
   <td><c:out value="${row.CHR_EMPID}"/></td>
   <td><c:out value="${row.CHR_PF}"/></td>
   <td><c:out value="${row.CHR_ESI}"/></td>
   
</tr>
</c:forEach>
</table>
 
</body>
</html>