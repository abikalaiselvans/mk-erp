 
<%
	String txtMobileNo =request.getParameter("txtMobileNo");
	String txtMessage =request.getParameter("txtMessage");
	String btnSendSMS =request.getParameter("btnSendSMS");
	response.sendRedirect("http://9to9.in/send-successfully.php?txtMobileNo="+txtMobileNo+"&txtMessage="+txtMessage+"&btnSendSMS="+btnSendSMS);
%>
					
 