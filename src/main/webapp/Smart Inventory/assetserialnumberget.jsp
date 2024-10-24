  <%@ page language="java" import="java.sql.*" %>
<% response.setContentType("text/html");%>
<%
String str=request.getParameter("queryString");
try 
{
	
String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_SERIALNO FROM  inv_t_vendorgoodsreceived WHERE CHR_FLAG='N' AND CHR_SERIALNO LIKE '"+str+"%' LIMIT 10 ");
if(data.length>0)
	for(int u=0; u<data.length;u++)
		out.println("<li  style='list-style:none' onclick=\"fill('"+data[u][0]+"')\">"+data[u][0]+"</li>");

}
catch(Exception e)
{
	out.println("Exception is ;"+e);
}
%>
 