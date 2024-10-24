<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@include file="Redirect.jsp" %>	
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!
	Connection con ;
	PreparedStatement pstm;
	ResultSet rst;
	String userid;
	String TxtNewPasswd;
	String description;
	String sql_Update_Query ="UPDATE  m_user  SET CHR_USRPWD =? WHERE CHR_USRNAME=?";
	public void updateUserInformation() 
	{
		try
		{
			sql_Update_Query ="UPDATE  m_user  SET CHR_USRPWD =(ENCODE('"+TxtNewPasswd+"','9865043008')) , DAT_LASTPASSWORDCHANGE = NOW() WHERE CHR_USRNAME=?";
			pstm = con.prepareStatement(sql_Update_Query);	
			//pstm.setString(1,TxtNewPasswd);
			pstm.setString(1,userid);
			pstm.execute();

		}
		catch(NullPointerException ex)
		{
			//System.out.println(ex);
		}catch(SQLException ex)
		{
			//System.out.println(ex);
		}
	}
	
	public void releaseJDBCResource() 	
	{
		try
		{
			pstm.close();
 
		}catch(NullPointerException ex)
		{
			//System.out.println(ex);
		}catch(SQLException ex)
		{
			//System.out.println(ex);
		}
	}		
%>
<% 
	userid=""+session.getAttribute("USRID");
	TxtNewPasswd= request.getParameter("TxtNewPasswd");	
	//Loading JDBC Connection Information
	try
	{
		con = conbean.getConnection();
		updateUserInformation();
		session.setAttribute("USRPWD",TxtNewPasswd);
		releaseJDBCResource();
		response.sendRedirect("ChangePasswordSucess.jsp");

	}catch(Exception ex)
	{
		releaseJDBCResource();
		//System.out.println(ex);
	}		
%>
