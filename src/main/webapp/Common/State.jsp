
<%
	String path = request.getParameter("path");
	response.sendRedirect("../SmartLoginAuth?filename=State&actionS=COM_ATTstateList&path="+path);
%>
