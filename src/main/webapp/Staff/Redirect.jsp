<%
	String sesUserName=""+session.getAttribute("USRID"); 
	if(sesUserName.equals("null") ) 
		response.sendRedirect("FrameMessage.jsp?msg=Your Login Session has Expired");
		

%>
