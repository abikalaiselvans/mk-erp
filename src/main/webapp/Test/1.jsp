<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page errorPage="errorpg.jsp" %>
  <html>
  <head>

    <sql:query var="employees" dataSource="jdbc/testdb">
       select * from com_m_staff
    </sql:query>

  </head>
  <body>
    <h1>JDBC JNDI Resource Test</h1>
    <table width='600' border='1'>
      <tr>
        <th align='left'>Employee ID</th>
        <th align='left'>Name</th>
        <th align='left'>Department</th>
      </tr>
      <c:forEach var="employee" items="${employees.rows}">
        <tr>
           <td>${"1"} <br>${employee.CHR_EMPID}</td>
           <td> ${employee.CHR_STAFFNAME} </td>
           <td> ${employee.INT_COMPANYID} </td>
       </tr>
      </c:forEach>
    </table>
  </body>
  </html>