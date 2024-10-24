<%@ page language="java" import="java.sql.*" %>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<% response.setContentType("text/html");%>
<%
String str=request.getParameter("queryString");
String bank=request.getParameter("bank");

try 
{
	String sql = "SELECT CHR_IFSC ,CHR_BRANCHNAME ,CHR_ADDRESS FROM com_m_bankbranchname ";
	sql = sql + " WHERE INT_BANKGROUPID = "+bank+" AND ( CHR_IFSC LIKE '"+str.trim()+"%'  OR CHR_BRANCHNAME LIKE '"+str.trim()+"%' )  ORDER BY CHR_IFSC  LIMIT 10  "; 
	 
	String ifscdata[][] = CommonFunctions.QueryExecute(sql);
	
	
	if(ifscdata.length>0)
	{
		for(int u=0;u<ifscdata.length;u++)
		{
			out.println("<li onclick=\"ifsccodefill('"+ifscdata[u][0]+"')\">"+ifscdata[u][0] +"&nbsp;&nbsp;/&nbsp;&nbsp;"+ ifscdata[u][1]  +"</li>");
		}
	}
	else
		out.println("<li onclick=\"ifsccodefill('"+str+"')\">IFSC CODE [&nbsp;&nbsp;"+str+"&nbsp;&nbsp;] &nbsp;&nbsp;not found </li>");
	
}
catch(Exception e)
{
	out.println("Exception is ;"+e);
}
%>
 