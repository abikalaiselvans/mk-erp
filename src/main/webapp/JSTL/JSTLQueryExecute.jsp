<%-- <%@ taglib uri="/WEB-INF/smarterp.tld" prefix="java2s" %>
 --%><%
try
{

String sql = " SELECT  INT_BANKGROUPID, CHR_BANKGROUPNAME, CHR_SHORTNAME FROM  com_m_bankgroup ORDER BY CHR_BANKGROUPNAME " ;
%>
<java2s:JSTLQueryExec sqlQuery="<%=sql%>"></java2s:JSTLQueryExec>
<%
String data[][] = (String[][])pageContext.getAttribute("result");;
if(data.length>0)
	for(int u=0;u<data.length;u++)
	{
		out.println(data[u][1]+"<br>");
	}	
 
 
}
catch(Exception e)
{
	System.out.println(e.getMessage());
	request.setAttribute("error", e.getMessage() );
	RequestDispatcher dispatchers = request.getRequestDispatcher("../error/index.jsp");
	dispatchers.forward(request, response); 

}
%>
</body>
</html>
