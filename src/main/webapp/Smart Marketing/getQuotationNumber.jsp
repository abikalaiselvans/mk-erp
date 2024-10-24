<%@ page language="java" import="java.sql.*" %>
<% response.setContentType("text/html");%>
<%
String str=request.getParameter("queryString");
String customer=request.getParameter("customer");
try 
{



	String qsql="";
	qsql = " SELECT a.INT_QUOTATIONID, a.CHR_QUOTATIONNO, SUM(b.INT_QUANTITY * b.DOU_UNITPRICE) from mkt_t_quotation a, mkt_t_quotationitem b "; 
 	qsql = qsql + " WHERE a.CHR_QUOTATIONNO = b.CHR_QUOTATIONNO AND  DATEDIFF(NOW(), a.DAT_CREATIONTIME)<=60     ";
 	qsql = qsql + " AND a.CHR_ASSIGNED = 'N' ";
	qsql = qsql+"  AND a.INT_CUSTOMERID = "+customer+" AND ( a.CHR_QUOTATIONNO LIKE '%"+str+"%'  OR a.CHR_QUOTATIONNO LIKE '%"+str+"%'  )   ";	
 	qsql = qsql + " GROUP BY a.CHR_QUOTATIONNO ";
  	
	//System.out.println(qsql);
	String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(qsql);
	if(data.length>0)
	{
		for(int u=0; u<data.length;u++)
			out.println("<li  style='list-style:none' onclick=\"fill('"+data[u][1]+","+data[u][2]+"')\">"+data[u][1] +"</li>");
	}
	else
		out.println("<li  style='list-style:none' onclick=\"fill('')\">Quotation not found</li>");

}
catch(Exception e)
{
	out.println("Exception is ;"+e);
}
%>
 