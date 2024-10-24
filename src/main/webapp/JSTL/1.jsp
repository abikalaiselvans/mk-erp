<%@ page isELIgnored="false"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h1> WELCOME TO :::
<c:out value="${param.uname}" default="MYJAVAHUB "></c:out>
</h1>