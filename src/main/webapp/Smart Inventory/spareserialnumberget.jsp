  <%@ page language="java" import="java.sql.*" %>
  <%@ page import="com.my.org.erp.common.CommonFunctions"%>

<% response.setContentType("text/html");%>
<%
String str=request.getParameter("queryString");
try 
{
	
String ksql ="";
sql = " SELECT  a.CHR_SERIALNO, d.CHR_CUSTOMERNAME,if(CHR_CATEGORY='A','AMC','WARRANTY'), ";
sql = sql + " if(DATEDIFF(NOW(),DT_ENDDATE) <1 ,'Live','Expired'), ";
sql = sql + " CONCAT(c.CHR_SPAREUNITNAME,'-',e.CHR_MODEL ),c.CHR_SPAREUNITNAME, e.CHR_MODEL ";
sql = sql + " FROM inv_m_sparemaster a ,com_m_state b, inv_m_spareunit c , inv_m_sparecustomer d, inv_m_spareunitmodel e  ";
sql = sql + " WHERE a.INT_ROWID > 0  AND a.INT_STATEID = b.INT_STATEID  ";
sql = sql + " AND a.INT_SPAREUNITID  = c.INT_SPAREUNITID  ";
sql = sql + " AND a.INT_CUSTOMERID =d.INT_CUSTOMERID  ";
sql = sql + " AND a.INT_MODELID = e.INT_MODELID  ";
sql = sql + " AND e.INT_SPAREUNITID = c.INT_SPAREUNITID  ";
sql = sql + " AND CHR_SERIALNO LIKE '"+str+"%'  "
String data[][] =  CommonFunctions.QueryExecute(sql);
 if(data.length>0)
 {
	for(int u=0; u<data.length;u++)
		out.println("<li  style='list-style:none' onclick=\"fill('"+data[u][0]+"~"+data[u][1]+"~"+data[u][4]+"')\">"+data[u][0] +" /"+data[u][3] +"</li>");
		%>
    <script language="javascript">
	var _targ=document.getElementsByName('calltype')[0];       
		_targ.options.length=0;
	 	_targ.options[0]=new Option('Qualified','Q');
	 
	 
	</script>
    <%
 }
 else
 {
 	out.println("<li  style='list-style:none' onclick=\"fill0('"+str+"~ ')\"   >Serial number not found</li>");
	%>
    <script language="javascript">
		var _targ=document.getElementsByName('calltype')[0];       
		_targ.options.length=0;
	 	_targ.options[0]=new Option('Not Qualified','N');
	 
	 
    </script>
    <%
 }
}
catch(Exception e)
{
	out.println("Exception is ;"+e);
}
%>
 