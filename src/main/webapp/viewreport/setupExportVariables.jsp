<%@ page contentType="text/html; charset=utf-8"%>

<html>
<head>
<!-- #include file=../utilities.jsp -->
</head>
<body  onpaste='return false;'>
<%  
            session.setAttribute("exportFormat", request.getParameter("exportFormat"));

            response.sendRedirect("jrcSetup.jsp");
        %>
</body>
</html>
