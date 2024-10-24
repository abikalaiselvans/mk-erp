
 
 <%@ page language="java" import="java.sql.*" %>
<% response.setContentType("text/html");%>
<%
String str=request.getParameter("queryString");
 try 
{

String qsql="SELECT CHR_SERIALNO FROM  inv_t_vendorgoodsreceived WHERE CHR_SERIALNO is not null    ";//AND CHR_QUALITY !='N'
 	
qsql = qsql+" AND CHR_SERIALNO LIKE '%"+str+"%' LIMIT 10  ";	
//System.out.println(qsql);
String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(qsql);
if(data.length>0)
	for(int u=0; u<data.length;u++)
		out.println("<li  style='list-style:none' onclick=\"fill('"+data[u][0]+"')\">"+data[u][0]+"</li>");

}
catch(Exception e)
{
	out.println("Exception is ;"+e);
}
%>
 