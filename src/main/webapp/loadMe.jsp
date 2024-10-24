<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
	 		  	 
              
if(!"F".equals(session.getAttribute("USRTYPE")))
{
	String datad[][] =CommonFunctions.getReportingEmployeeIdNames(""+session.getAttribute("EMPID"));
	for(int u=0;u<datad.length;u++)
		out.println("<option value='"+datad[u][0]+"'>"+datad[u][1]+" / " +datad[u][0]+"</option>");
}
else
{
  	String datad[][]=CommonFunctions.QueryExecute("SELECT CHR_EMPID,CHR_STAFFNAME FROM com_m_staff WHERE CHR_TYPE != 'T' ORDER BY CHR_STAFFNAME");
	for(int u=0;u<datad.length;u++)
		out.println("<option value='"+datad[u][0]+"'>"+datad[u][1]+" / " +datad[u][0]+"</option>");
}
  

    
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>