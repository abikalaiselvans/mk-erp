<%@ page language="java" contentType="text/html; 
    charset=US-ASCII" pageEncoding="US-ASCII"%>

<%@page import="java.util.*"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Insert title here</title>
</head>
<body  onpaste='return false;'>

<h2>display examples with c:set, c:out, escapeXml</h2>
<c:set var="str" value="<b>bold</b>" />
str: ${str}<br />
escaped(str): ${fn:escapeXml(str)}<br />
c:out escaped: <c:out value="${str}" /><br />
c:out unescaped: <c:out value="${str}" escapeXml="false" />

</body>
</html>
