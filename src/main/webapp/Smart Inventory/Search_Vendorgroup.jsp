 <%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<% response.setContentType("text/html");%>
<%
String str=request.getParameter("queryString");
try 
{
	
String data[][] =CommonFunctions.QueryExecute("SELECT CHR_VENDORNAME FROM inv_m_vendorsinformation WHERE CHR_VENDORNAME LIKE '%"+str+"%' LIMIT 10");
if(data.length>0)
	for(int u=0; u<data.length;u++)
		out.println("<li  style='list-style:none' onclick=\"cfill('"+data[u][0]+"')\">"+data[u][0]+"</li>");
else
	out.println("<li  style='list-style:none' onclick=\"cfill('')\">Data not found...</li>");
}
catch(Exception e)
{
	out.println("Exception is ;"+e);
}
%>
 