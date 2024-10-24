 <%@ page language="java" import="java.sql.*" %>
<% response.setContentType("text/html");%>
<%
String str=request.getParameter("queryString");
try 
{
	String sql = "SELECT a.INT_COUNTRYID,UPPER(b.CHR_COUNTRYNAME),a.INT_STATEID,UPPER(c.CHR_STATENAME),a.INT_DISTRICTID,UPPER(d.CHR_DISTRICT),a.INT_CITYID,UPPER(a.CHR_CITYNAME),DECODE(a.CHR_PINCODE,'9865043008') ";
	sql = sql + " FROM com_m_city a,com_m_country b,com_m_state c,com_m_district d   ";
	sql = sql + " WHERE a.INT_COUNTRYID=b.INT_COUNTRYID   ";
	sql = sql + " AND a.INT_STATEID = c.INT_STATEID   ";
	sql = sql + " AND a.INT_DISTRICTID = d.INT_DISTRICTID   ";
	sql = sql + " AND DECODE(a.CHR_PINCODE,'9865043008') like '"+str.trim()+"%'  ";
	sql = sql + " ORDER BY a.CHR_CITYNAME LIMIT 20  ";
	String picodedata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	
	
	if(picodedata.length>0)
	{
		for(int u=0;u<picodedata.length;u++)
		{
		out.println("<li onclick=\"fill('"+picodedata[u][0]+"/"+picodedata[u][1]+"/"+picodedata[u][2]+"/"+picodedata[u][3]+"/"+picodedata[u][4]+"/"+picodedata[u][5]+"/"+picodedata[u][6]+"/"+picodedata[u][7]+"/"+picodedata[u][8]+"')\">"+picodedata[u][3] +" / "+picodedata[u][5] +" / " +picodedata[u][7] +"  / " +picodedata[u][8]+"</li>");
		}
	}
	else
		out.println("<li onclick=\"fill('0/0/0/0/0/0/0/0/0')\">Datas are not found...</li>");
		
}
catch(Exception e)
{
	out.println("Exception is ;"+e);
}
%>
 