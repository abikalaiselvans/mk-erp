
<%
	String Useridmain=""+session.getAttribute("USRID"); 
	String UserPassmain=""+session.getAttribute("USRPWD"); 
	if(Useridmain.equals("null") || UserPassmain.equalsIgnoreCase("null")) {
		response.sendRedirect("LoginExpire.jsp");
	}
	%>

