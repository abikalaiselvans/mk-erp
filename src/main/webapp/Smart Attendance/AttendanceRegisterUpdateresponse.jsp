<%@ page
	import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.* "%>
<jsp:useBean id="conBean" class="DBConnection.DBCon" />

<title> :: ATTENDANCE ::</title>


 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<body  onpaste="return false;" class="MRow3">
<form  AUTOCOMPLETE = "off"   action="AttendanceRegisterUpdateresponse.jsp" method="post">
<span class="boldEleven"> <%
		try
		{
			String empid = request.getParameter("empid");
			String month = request.getParameter("month");
			String year = request.getParameter("year");
			String date = request.getParameter("date");
			String ComboDay = request.getParameter("ComboDay");
			String Type = request.getParameter("Type");
			 
			String sql =" UPDATE att_t_register SET ";
			
			if("P".equals(ComboDay))
			{
				sql = sql+"CHR_MORNING"+date+"='"+Type+"' ,";
				sql = sql+"CHR_EVENING"+date+"='"+Type+"' ,";
			}	
			else if("F".equals(ComboDay))
			{
				sql = sql+"CHR_MORNING"+date+"='"+Type+"' , ";
			}
			 else if ("A".equals(ComboDay))
			{
				sql = sql+"CHR_EVENING"+date+"='"+Type+"' ,";
			} 
			sql = sql.trim();
			sql = sql.substring(0,sql.length()-1);	
			sql = sql + " WHERE CHR_EMPID='"+empid+"' AND CHR_MONTH='"+month+"' AND INT_YEAR="+year;			
			Connection con=conBean.getConnection();
			Statement st=con.createStatement();
			st.execute(sql);
			st.close();
			 
			response.sendRedirect("../RefreshExit.jsp");
			%>   <%
				
			
		}
		catch(	Exception e)
		{
			 
		}
	%> </span></form>

</body>
