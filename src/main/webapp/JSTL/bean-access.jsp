<%@ page language="java" contentType="text/html; 
    charset=US-ASCII" pageEncoding="US-ASCII"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="mb" scope="session" class="bean.MyBean" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>bean access example</title>
</head>
<body  onpaste='return false;'>

<h2>bean access example: bean.MyBean mb</h2>
<p>Refresh to observe changes</p>
<p>mb.count: ${mb.count}</p>
<c:set target="${mb}" property="count" value="${mb.count + 1}" />
<p>after incrementing, mb.count: ${mb.count}</p>
<c:choose>
  <c:when test="${mb.count > 6}">
    became bigger than 6, re-initialize mb
    <c:remove var="mb" />
  </c:when>
  <c:when test="${mb.count > 3}">
    became bigger than 3
  </c:when>
  <c:otherwise>
    no more than 3
  </c:otherwise>
</c:choose>

</body>
</html>
