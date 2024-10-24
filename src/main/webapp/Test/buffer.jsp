<%@ page session="true" %>
<%
application.setAttribute("SITE", "MYJAVAHUB.COM");
%>
<table border= 2>
<%
out.println("<tr><td>Buffer Size : </td><td>" + out.getBufferSize()+"</td></tr>");
out.println("<tr><td>Is AutoFlush Enable</td><td> " + out.isAutoFlush()+"</td></tr>");
out.println("<tr><td>Remaining Buffer Size </td><td>" + out.getRemaining()+"</td></tr>");
out.println("<tr><td>SITE </td><td>" + application.getAttribute("SITE")+"</td></tr>");
%>
</table>