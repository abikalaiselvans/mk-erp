<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
 <%
 try
 {
	 
	String selfmarking="R" ;
	String actionS ="AttendanceSelfMarkingView.jsp";
	String rData[][] = CommonFunctions.QueryExecute("SELECT CHR_ATTENDANCE_SELFMARKING FROM att_m_basicsettings WHERE INT_ID=1 ");
	if(rData.length>0)
		selfmarking = rData[0][0];
		
	if("I".equals(selfmarking))	
		actionS ="AttendanceMarkingIndividual.jsp";

	response.sendRedirect(actionS);
 
}
catch(Exception e)
{
	System.out.println(e.getMessage());
	out.println(e.getMessage());
}
%>