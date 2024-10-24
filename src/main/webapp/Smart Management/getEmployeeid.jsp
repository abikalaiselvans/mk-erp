
 
 <%@ page language="java" import="java.sql.*" %>
<% response.setContentType("text/html");%>
<%
String str=request.getParameter("queryString");

 try 
{

String qsql="SELECT CHR_EMPID, CHR_STAFFNAME  FROM  com_m_staff WHERE   CHR_TYPE !='T'  ";
qsql = qsql+" AND ( CHR_EMPID LIKE '%"+str+"%'  OR CHR_STAFFNAME LIKE '%"+str+"%'  )   ";	
//System.out.println(qsql);
String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(qsql);
if(data.length>0)
	for(int u=0; u<data.length;u++)
		out.println("<li  style='list-style:none' onclick=\"fill('"+data[u][0]+"')\">"+data[u][0] +"/"+data[u][1]+"</li>");

}
catch(Exception e)
{
	out.println("Exception is ;"+e);
}
%>
 