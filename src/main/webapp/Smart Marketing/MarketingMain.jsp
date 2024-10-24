   <%@ page import="java.sql.*,java.util.*,java.io.*"%>
 <%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
	CommonFunctions.autoUpdate(request,""+application.getInitParameter("Auto"));
%>
<html>
<head>

<title> :: MARKETING ::</title>

 
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style></head>
<body onselectstart="return false" onpaste="return false;" onCopy="return false"   onpaste='return false;'>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><%@ include file="index.jsp"%></td>
  </tr>
  <tr>
    <td height="350">
    <%
	String sql ="SELECT COUNT(*) FROM mkt_m_customerinfo WHERE CHR_VERIFY='N'";
	String data[][]=CommonFunctions.QueryExecute(sql);
	int rcount = Integer.parseInt(data[0][0]) ;
	if(rcount>=1)
	{
	%>
    <script language="javascript">alert("<%=rcount%>-nos,  Customer address verification pending")</script>
    <%
	}
	%>
    
    </td>
  </tr>
  <tr>
    <td><%@ include file="../footer.jsp"%></td>
  </tr>
</table>
 
</body>
</html>
 <%	
 
}
catch(Exception e)
{
	System.out.println(e.getMessage());
}
%>
