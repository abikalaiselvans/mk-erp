<%@ page language="java" import="java.sql.*" %>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<% response.setContentType("text/html");%>
<%
String str=request.getParameter("queryString");
try 
{
	String sql = "SELECT CHR_EMPID,CHR_STAFFNAME FROM com_m_staff  WHERE CHR_TYPE ='T'";
	sql = sql + "  AND ( CHR_STAFFNAME LIKE '"+str.trim()+"%' OR CHR_EMPID LIKE '%"+str.trim()+"%')  "; 
	sql = sql + " ORDER BY CHR_STAFFNAME  LIMIT 10   ";
	String resigndata[][] = CommonFunctions.QueryExecute(sql);
 	if(resigndata.length>0)
	{
		for(int u=0;u<resigndata.length;u++)
		{
			out.println("<li onclick=\"empidfill('"+resigndata[u][0]+"')\">"+resigndata[u][0] +"&nbsp;&nbsp;/&nbsp;&nbsp;"+ resigndata[u][1]  +"</li>");
		}
	}
	 else
		out.println("<li onclick=\"empidfill('')\">EMPLOYEE-ID not found </li>");
}
catch(Exception e)
{
	out.println("Exception is ;"+e);
}
%>
 