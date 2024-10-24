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
		   
		    String mailenable =""+request.getParameter("mailenable");
	 		String career =""+request.getParameter("career");
	 		String verification =""+request.getParameter("verification");
			 
			
			if(!"Y".equals(mailenable))
				mailenable = "N";
			 
	 	   	sql ="UPDATE  m_hrm_setting  SET CHR_MAILALERT=?, CHR_MAILIDS_CAREER=?, CHR_MAILIDS_EMPLOYEE_VERIFICATION=?  WHERE INT_ROWID=?";
			
		 	//out.println(sql);

		   	con =conbean.getConnection();
		   	pstm=con.prepareStatement(sql);	
		   	pstm.setString(1,mailenable);
			pstm.setString(2,career);
			pstm.setString(3,verification);
			pstm.setString(4, "1");
			//out.println(""+pstm);
			pstm.execute();
			pstm.close();
			
		  
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
