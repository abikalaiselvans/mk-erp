 <%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
String name=request.getParameter("name");
String email=request.getParameter("email");
String url=request.getParameter("url");
String comment=request.getParameter("comment");
%>
<h3><font color=red>YOUR COMMENT IS SUBMITTED SUCCESSFULLY!!</font></h3>
<b><font color=blue>
<%
out.println("NAME : "+name);
%><br><%
out.println("EMAIL :  "+email);
%><br><%
out.println("URL : "+ url);
%><br><%
out.println("COMMENT : "+comment);
%>
</font>