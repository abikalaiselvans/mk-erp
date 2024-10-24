 
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
		   
		   
		   
		   String host=request.getParameter("host");
		   String userid=request.getParameter("userid");
		   String password=request.getParameter("password");
		   String mailid=request.getParameter("mailid");
		   String Groupmailid=request.getParameter("Groupmailid");
		   
		   String inventroydelete=request.getParameter("inventroydelete");
		   String prapproval=request.getParameter("prapproval");
		   String perclosed=request.getParameter("perclosed");
		   
		   sql ="UPDATE  m_mailsetting  SET CHR_HOST=?,CHR_USERID=?,CHR_PASSWORD=?,CHR_MAILID=?,CHR_GROUPMAILD=?,CHR_INVOICE_DELETE=?,CHR_PR_APPROVAL=?, CHR_PR_CLOSED=?  WHERE INT_MAILID=?";
		   con =conbean.getConnection();
		   pstm=con.prepareStatement(sql);	
		   pstm.setString(1, host);
		   pstm.setString(2, userid);
		   pstm.setString(3, password);
		   pstm.setString(4,mailid);
		   pstm.setString(5, Groupmailid);
		   pstm.setString(6, inventroydelete);
		   pstm.setString(7, prapproval);
		   pstm.setString(8, perclosed);
		   pstm.setString(9,"1");
		   pstm.executeUpdate(); 
		   //response.sendRedirect("Userframe.jsp");
		   
		   
		  
		 %>
<table width="253" height="55%" align="center">
	<tr>
		<td width="245"  align="center" valign="middle">
		<p align="right" class="bolddeepred">Mail Settings
		updated Sucessfully</p>
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

