<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<% response.setContentType("text/html");%>
<%
String str=request.getParameter("queryString");
 try 
{

String qsql="SELECT CHR_QUOTATIONNO FROM  inv_t_customerquotation WHERE CHR_QUOTATIONNO is not null ";
//System.out.println(qsql); 	
qsql = qsql+" AND CHR_QUOTATIONNO LIKE '%"+str+"%' LIMIT 10  ";	
String data[][] = CommonFunctions.QueryExecute(qsql);
if(data.length>0)
	for(int u=0; u<data.length;u++)
		out.println("<li  style='list-style:none' onclick=\"fill('"+data[u][0]+"')\">"+data[u][0]+"</li>");

}
catch(Exception e)
{
	out.println("Exception is ;"+e);
}
%>
 