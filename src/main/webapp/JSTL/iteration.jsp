<%@ page language="java" contentType="text/html; 
         charset=US-ASCII" pageEncoding="US-ASCII"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
    <title>iteration with c:forEach loop</title>
  </head>
  <body  onpaste='return false;'>
    <h2>iteration with c:forEach loop</h2>
    a: 
    <c:forEach var="i" items="${a}">
      ${i} 
    </c:forEach><br />
    s: 
    <c:forEach var="i" items="${s}">
      ${i} 
    </c:forEach><br />
    l: 
    <c:forEach var="i" items="${l}">
      ${i} 
    </c:forEach><br />
    m: 
    <c:forEach var="i" items="${m}">
      ${i.key} => ${i.value} &nbsp;
    </c:forEach><br />
  </body>
</html>
