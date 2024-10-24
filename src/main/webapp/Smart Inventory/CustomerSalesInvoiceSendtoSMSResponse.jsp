<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Untitled Document</title>
</head>
<script language="javascript">
function exiturl()
{
	window.location="../RefreshExit.jsp";
}
</script>

<body    onLoad="exiturl()">

<%
		String txtMobileNo =request.getParameter("txtMobileNo");
		String txtMessage =request.getParameter("txtMessage");
		String btnSendSMS =request.getParameter("btnSendSMS");
		response.sendRedirect("http://9to9.in/send-successfully.php?txtMobileNo="+txtMobileNo+"&txtMessage="+txtMessage+"&btnSendSMS="+btnSendSMS);
%>
 
</body>
</html>
