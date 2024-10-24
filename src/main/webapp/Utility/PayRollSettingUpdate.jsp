<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>

<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%
try
{
	Connection con ;
	PreparedStatement pstm;
 	String sql=null;
	 
%>
<html>
<head>

<title> :: UTILITY :: </title>
<%@include file="Redirect.jsp" %>

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<body  onpaste="return false;"  >
<form name="frm" method="post">
<%
		   	String salaryprocess=request.getParameter("salaryprocess");
		    String mailalert =""+request.getParameter("mailalert");
	 		String mailtime =""+request.getParameter("mailtime");
	 		String mailids =""+request.getParameter("mailids");
			String dorlock =""+request.getParameter("dorlock");
			String mailenable =""+request.getParameter("mailenable");
			String ndcremainder =""+request.getParameter("ndcremainder");
			String ndcfinal =""+request.getParameter("ndcfinal");
			
			if(!"Y".equals(mailenable))
				mailenable = "N";
			//out.println(mailenable);
	 	   	sql ="UPDATE  pay_m_basicsettings  SET CHR_SALAYCALCULATION=?, CHR_DAILY_PENDING_MAIL=?, CHR_DAILY_PENDING_MAIL_IDS=? , INT_DAILY_PENDING_MAIL_TIME =? ,INT_CESSATIONDATELOCK=?, CHR_MAILENABLE=?,CHR_NDC_REMAINDER_MAIL_IDS=?,CHR_NDC_FINAL_MAIL_IDS=?  WHERE INT_ID=?";
			
			

		   	con =conbean.getConnection();
		   	pstm=con.prepareStatement(sql);	
		   	pstm.setString(1,salaryprocess);
			pstm.setString(2,mailalert);
			pstm.setString(3,mailids);
			pstm.setString(4,mailtime);
			pstm.setString(5,dorlock);
			pstm.setString(6,mailenable);
			pstm.setString(7,ndcremainder);
			pstm.setString(8,ndcfinal);
			pstm.setString(9,"1");
			//out.println(""+pstm);
		   	pstm.execute();
			pstm.close();
			
		    //response.sendRedirect("PayRollSetting.jsp"); 
		   
		   
		  
		 %>
<table width="253" height="55%" align="center">
	<tr>
		<td width="245"  align="center" valign="middle">
		<p align="right" class="bolddeepred">Payroll Settings
		updated Sucessfully</p>
		<br>
		<h3>
		<p align="center"><a href="Userframe.jsp"> Setting </a></p>
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
	out.println(e.getMessage());
}
%>
