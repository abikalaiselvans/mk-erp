<%@ page
	import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.* "%>
<jsp:useBean id="conBean" class="DBConnection.DBCon" />

<title> :: ATTENDANCE ::</title>


 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<body  onpaste="return false;" class="MRow3">
<form  AUTOCOMPLETE = "off"   action="AttendanceRegisterUpdateresponse.jsp" method="post">
<span class="boldEleven"> 
<%
		try
		{
			String empid = request.getParameter("empid");
			String month = request.getParameter("month");
			String year = request.getParameter("year");
			String date = request.getParameter("date");
			String ComboDay = request.getParameter("ComboDay");
			String field = request.getParameter("field");
			double previousleave = 0;
			String ssql="";
			ssql=" SELECT CHR_LEAVETYPE,CHR_DAYTYPE,INT_LEAVEID FROM att_t_leave WHERE  CHR_EMPID='"+empid+"'";
			ssql=ssql+" AND DT_LDATE='"+year+"-"+com.my.org.erp.ServiceLogin.DateUtil.getMonthNumber(month)+"-"+date+"'";
			String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(ssql);
			
			ssql=" SELECT INT_LEAVEID FROM att_m_leavetype WHERE CHR_SYMBOL='"+data[0][0]+"'";
			String ldata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(ssql);
			
			ssql = "SElECT INT_NOD"+ldata[0][0]+"BALANCE FROM att_m_leave WHERE CHR_EMPID='"+empid+"' AND INT_YEAR="+year;		
			String leavedata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(ssql);
			
			previousleave = Double.parseDouble(leavedata[0][0]);
			
			Connection con=conBean.getConnection();
			Statement st=con.createStatement();
			if("Full Day".equals(data[0][1].trim()))
			{
				
				ssql= "UPDATE att_m_leave SET INT_NOD"+ldata[0][0]+"BALANCE ="+(previousleave-1);
				ssql=ssql+" WHERE CHR_EMPID='"+empid+"' AND INT_YEAR="+year;
				st.execute(ssql);
				
				String sql =" UPDATE att_t_register SET ";
				sql = sql+"CHR_MORNING"+date+ "='0' ,";
				sql = sql+"CHR_EVENING"+date+ "='0' ,";
				sql = sql.trim();
				sql = sql.substring(0,sql.length()-1);	
				sql = sql + " WHERE CHR_EMPID='"+empid+"' AND CHR_MONTH='"+month+"' AND INT_YEAR="+year;			
				st.execute(sql);
				
				sql = "DELETE FROM att_t_leave WHERE DT_LDATE='"+year+"-"+com.my.org.erp.ServiceLogin.DateUtil.getMonthNumber(month)+"-"+date+"'";
				st.execute(sql);
				
				
			}
			else if("Forenoon".equals(data[0][1].trim()))
			{
				
				ssql= "UPDATE att_m_leave SET INT_NOD"+ldata[0][0]+"BALANCE ="+(previousleave-0.5);
				ssql=ssql+" WHERE CHR_EMPID='"+empid+"' AND INT_YEAR="+year;
				st.execute(ssql);
				
				String sql =" UPDATE att_t_register SET ";
				sql = sql+"CHR_MORNING"+date+ "='0' ,";
				sql = sql.trim();
				sql = sql.substring(0,sql.length()-1);	
				sql = sql + " WHERE CHR_EMPID='"+empid+"' AND CHR_MONTH='"+month+"' AND INT_YEAR="+year;			
				st.execute(sql);
				
				sql = "DELETE FROM att_t_leave WHERE  CHR_EMPID='"+empid+"'";
				ssql=ssql+" AND DT_LDATE='"+year+"-"+com.my.org.erp.ServiceLogin.DateUtil.getMonthNumber(month)+"-"+date+"'";
				st.execute(sql);
			}
			else if("Afternoon".equals(data[0][1].trim()))
			{
				
				ssql= "UPDATE att_m_leave SET INT_NOD"+ldata[0][0]+"BALANCE ="+(previousleave-0.5);
				ssql=ssql+" WHERE CHR_EMPID='"+empid+"' AND INT_YEAR="+year;
				st.execute(ssql);
				
				String sql =" UPDATE att_t_register SET ";
				sql = sql+"CHR_EVENING"+date+ "='0' ,";
				sql = sql.trim();
				sql = sql.substring(0,sql.length()-1);	
				sql = sql + " WHERE CHR_EMPID='"+empid+"' AND CHR_MONTH='"+month+"' AND INT_YEAR="+year;			
				st.execute(sql);
				
				sql = "DELETE FROM att_t_leave WHERE  CHR_EMPID='"+empid+"'";
				ssql=ssql+" AND DT_LDATE='"+year+"-"+com.my.org.erp.ServiceLogin.DateUtil.getMonthNumber(month)+"-"+date+"'";
				st.execute(sql);
			}	
				
			st.close();
			 
			%> <script language="javascript">
				window.close();
			</script> <%
				
			
		}
		catch(	Exception e)
		{
			 
		}
	%> </span></form>

</body>
