 <%
 try
 {
 %>
<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%
	Connection con ;
	PreparedStatement pstm;
 	String sql=null;
	 
%>
<html>
<head>

<title> :: UTILITY :: </title>
<%@include file="Redirect.jsp" %>

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<body  onpaste="return false;" >
<form name="frm" method="post">
<%
		   
		   
		   
		   String reportingfrom=request.getParameter("reportingfrom");
		   String reportingto=request.getParameter("reportingto");
		   String office[]=request.getParameterValues("office");
		   String officeid="";
		   for(int u=0;u<office.length;u++)
		   		officeid = officeid+office[u]+",";
				
		 	sql = " UPDATE  com_m_staff a ,com_m_office b SET a.CHR_REPTO=? WHERE a.INT_OFFICEID= b.INT_OFFICEID  AND a.CHR_TYPE !='T'  AND a.CHR_REPTO = ? ";
			if(!"0,".equals(officeid))
				sql = sql +" AND a.INT_OFFICEID IN ("+officeid+"0)";
		   //out.println(sql);
		   con =conbean.getConnection();
		   pstm=con.prepareStatement(sql);	
		   pstm.setString(1, reportingto);
		   pstm.setString(2, reportingfrom);
		   pstm.execute(); 
		   pstm.close();
 		   
		   
		   
		  
		 %>
<table  height="55%" align="center">
	<tr>
		<td    align="center" valign="middle">
		<p align="right" class="bolddeepred">Reporting head successfully changed....</p>
		<br>
		<h3>
		<p align="center"><a href="Userframe.jsp"> Close </a></p>
		</h3>

	  </td>
	</tr>
</table>
</form>
 
</body>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>

