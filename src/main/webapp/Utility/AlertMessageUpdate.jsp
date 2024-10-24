 
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
<body  onpaste="return false;" bgcolor="#4F84C8">
<form name="frm" method="post">
<%
		   
		   
		   
		   String message=request.getParameter("message");
		  
		   
		   sql ="UPDATE  m_alertmessage  SET CHR_MESSAGE=?  WHERE INT_ROWID = 1";
		   con =conbean.getConnection();
		   pstm=con.prepareStatement(sql);	
		   pstm.setString(1, message);
		   //out.println(sql);
		   pstm.execute(); 
		   
		   sql = " UPDATE m_user SET CHR_ALERT_REQUIRED ='Y'  WHERE CHR_USRNAME='ADMIN'"; 
		   
		   sql = " UPDATE m_user SET CHR_ALERT_REQUIRED =? "; 
		   pstm=con.prepareStatement(sql);	
		   pstm.setString(1,"Y");
		   //out.println(sql);
		   pstm.execute(); 
		   
		   //response.sendRedirect("Userframe.jsp");
		   
		   
		  
		 %>
<table width="253" height="55%" align="center">
	<tr>
		<td width="245"  align="center" valign="middle">
		<p align="right" class="bolddeepred">Updated Sucessfully</p>
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

