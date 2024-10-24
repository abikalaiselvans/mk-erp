<%@ page language="java" import="java.sql.*" %>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>

<% response.setContentType("text/html");%>
<%
String str=request.getParameter("queryString");
String itype=request.getParameter("itype");
String icode=request.getParameter("icode");
System.out.println("SELECT CHR_SERIALNO FROM inv_t_vendorgoodsreceived  WHERE CHR_FLAG ='N'  AND  CHR_TYPE ='"+itype+"' AND CHR_ITEMID ='"+icode+"' AND CHR_SERIALNO LIKE '"+str+"%'  LIMIT 10 ");
 
try 
{
	
String data[][] =  CommonFunctions.QueryExecute("SELECT CHR_SERIALNO FROM inv_t_vendorgoodsreceived  WHERE CHR_FLAG ='N'  AND  CHR_TYPE ='"+itype+"' AND CHR_ITEMID ='"+icode+"' AND CHR_SERIALNO LIKE '"+str+"%'  LIMIT 10 ");
 if(data.length>0)
 {
	for(int u=0; u<data.length;u++)
		out.println("<li  style='list-style:none' onclick=\"fill('"+data[u][0]+"')\">"+data[u][0]   +"</li>");
 }
 else
 {
 	out.println("<li  style='list-style:none' onclick=\"fill('')\">Serial number not found</li>");
 }
}
catch(Exception e)
{
	out.println("Exception is ;"+e);
}
%>
 