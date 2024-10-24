<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<html>
<head>
<%@include file="Redirect.jsp" %>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='RES' ")[0][0]%></title>
</head>
<script language="javascript">
function redir()
{
	 
	window.location.href ="http://www.epfindia.com";
}
</script>
<body  onpaste="return false;" onLoad="redir()">


<%

//response.sendRedirect("http://www.epfindia.com/ClaimStatus_New.html");
 %>
</body>
</html>
