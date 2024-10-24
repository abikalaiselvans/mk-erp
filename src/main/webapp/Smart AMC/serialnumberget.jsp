 <%@ page language="java" import="java.sql.*" %>
 <%@ page import="com.my.org.erp.common.CommonFunctions"%>

<% response.setContentType("text/html");%>
<%
String str=request.getParameter("queryString");
try 
{
	
String data[][] =  CommonFunctions.QueryExecute("SELECT CHR_SERIALNO FROM  inv_m_serviceamc WHERE CHR_SERIALNO LIKE '"+str+"%' LIMIT 10 ");
if(data.length>0)
	for(int u=0; u<data.length;u++)
		out.println("<li  style='list-style:none' onclick=\"fill('"+data[u][0]+"')\">"+data[u][0]+"</li>");

}
catch(Exception e)
{
	out.println("Exception is ;"+e);
}
%>
 