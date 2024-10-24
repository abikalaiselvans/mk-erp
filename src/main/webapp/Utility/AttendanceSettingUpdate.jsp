 <%
 try
 {
 %>
<%@include file="Redirect.jsp" %>	 
<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%
	Connection con ;
	Statement st=null; 
	ResultSet rs; 
	PreparedStatement pstm;
 	String sql=null;
	String userName=null;
	String mnuVal=null;
	String fname;
%>
<html>
<head>

<title> :: UTILITY :: </title>


<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<body  onpaste="return false;" >
<form name="frm" method="post">
<%
		  String ondudy=request.getParameter("RadioDuty");
		 String leave=request.getParameter("RadioLeave");
		 String premission=request.getParameter("RadioPermission");
		 String manual=request.getParameter("RadioManual");
		 String smart=request.getParameter("RadioSmart");
		 String Shifttype=request.getParameter("Shifttype");
		
		 String inTime=request.getParameter("TxtIn");
		 String outTime=request.getParameter("TxtOut");
		 String lunchIn=request.getParameter("TxtLunchIn");
		 String lunchOut=request.getParameter("TxtLunchOut");
		 String graceIn=request.getParameter("TxtGraceIn");
		 String graceOut=request.getParameter("TxtGraceOut");
		 String ot=request.getParameter("TxtOt");			
		 String perLimit=request.getParameter("TxtPermission");			
		 String lateLimit=request.getParameter("TxtLate");			
		 String lossofday1=request.getParameter("lossofday1");			
		 String lossofday2=request.getParameter("lossofday2");	
		 String leaveapply=request.getParameter("leaveapply");	
		 String from=request.getParameter("from");	
		 String to=request.getParameter("to");			
		 
		 String dtpermission=request.getParameter("dtpermission");			
		 String dtleave=request.getParameter("dtleave");	
		 String exceedleave=request.getParameter("exceedleave");			
		  
		 String mailid=request.getParameter("mailid");	
		 String day=request.getParameter("day");	
		 String Category[]=request.getParameterValues("Category");	
  		 String attprocess=request.getParameter("attprocess");	
		 String staffregistrationapproval=request.getParameter("staffregistrationapproval");	
		 String selfmarking=request.getParameter("selfmarking");	
		 
		 
		 String c="";
		 for(int u=0;u<Category.length;u++)
			c = c+Category[u]+",";
			
		  sql ="UPDATE  att_m_basicsettings  SET CHR_OD=?,CHR_PER=?,CHR_MANUAL=?,"+
		   "CHR_LEAVE=?,CHR_SMARTATTENDANCE=?,CHR_SHIFTTYPE=?,TIM_TIMEIN=?,TIM_TIMEOUT=?,"+
		   "TIM_LUNCHIN=?,TIM_LUNCHOUT=?,TIM_GRACEIN=?,TIM_GRACEOUT=?,INT_OT=?"+
		   ",INT_PERLIMIT=?,INT_LATELIMIT=?, DOU_LOSSOFDAY1=?,DOU_LOSSOFDAY2=?,INT_LEAVEAPPLY=? ,   INT_ATTENDANCEMARK = ?, CHR_ATT_SKIP_CATEGORY = ?,INT_ATTENDANCEPROCESS  =?,INT_FROM=?,INT_TO=?,INT_DTLOCKPERMISSION=?,INT_DTLOCKLEAVE=?,CHR_LEAVEEXCEED=?,CHR_ATTENDANCEPENDINGMAIL =? , CHR_STAFFREGISTRATION_APPROVAL_PENDING_MAILIDS=?, CHR_ATTENDANCE_SELFMARKING=? WHERE INT_ID=?";
		   
		   
		   
		  
		   //System.out.println(sql);	
		   con =conbean.getConnection();
		   pstm=con.prepareStatement(sql);	
		   pstm.setString(1,ondudy);
		   pstm.setString(2,leave);
		   pstm.setString(3,premission);
		   pstm.setString(4,manual);
		   pstm.setString(5,smart);
		   pstm.setString(6,Shifttype);
		   pstm.setString(7,inTime);
		   pstm.setString(8,outTime);
		   pstm.setString(9,lunchIn);
		   pstm.setString(10,lunchOut);
		   pstm.setString(11,graceIn);
		   pstm.setString(12,graceOut);
		   pstm.setInt(13,Integer.parseInt(ot));
		   pstm.setInt(14,Integer.parseInt(perLimit));
		   pstm.setInt(15,Integer.parseInt(lateLimit));	
		   pstm.setDouble(16,Double.parseDouble(lossofday1));	
		   pstm.setDouble(17,Double.parseDouble(lossofday2));		   
		   pstm.setInt(18,Integer.parseInt(leaveapply));
		   pstm.setString(19,day);
		   pstm.setString(20,c);
		   pstm.setString(21,attprocess);
		   pstm.setString(22,from);
		   pstm.setString(23,to);
		   pstm.setString(24,dtpermission);
		   pstm.setString(25,dtleave);
		   pstm.setString(26, exceedleave);
		   pstm.setString(27, mailid);
		   pstm.setString(28,staffregistrationapproval);
		   pstm.setString(29,selfmarking);
		   pstm.setInt(30,1);
		   //out.println(sql);	
		  pstm.execute();
		  // response.sendRedirect("AttendanceSetting.jsp");
		   
		  
		 %>
<table height="55%" align="center">
	<tr>
		<td>
		<p align="center" class="DataGridFixedHeader">Attendance Settings
		updated Sucessfully</p>
		<br>
		<h3>
		<p align="center"><a href="AttendanceSetting.jsp"> Setting </a></p>
		</h3>

		</td>
	</tr>
</table>
</form>
</body>
</html>

<%
}
catch(Exception e)
{
	System.out.println(e.getMessage());
	out.println(e.getMessage());
}
%>