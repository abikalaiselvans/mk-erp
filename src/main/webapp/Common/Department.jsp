
<%
    String path = request.getParameter("path");
	response.sendRedirect("../SmartLoginAuth?filename=Department&actionS=COM_ATTdepartList&path="+path);
%>
