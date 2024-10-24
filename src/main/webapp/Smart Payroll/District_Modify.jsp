<%@ page import="java.sql.*,java.util.*,java.io.*,java.lang.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />

<%!
	Connection con ;
	PreparedStatement pstm;
	ResultSet rst;
	String userid;
	String pwd;
	String description,district;
	String sql_Update_Query ="UPDATE  com_m_district  SET chr_DISTRICTNAME =?, chr_DISTRICTDES = ? WHERE INT_DISTRICTID=?";
	int TxtStateId,TxtDistrictId,user;
	
	public void updateUserInformation() 
	{
		try
		{
			pstm = con.prepareStatement(sql_Update_Query);	
			pstm.setString(1,district);
			pstm.setString(2,description);
			pstm.setInt(3,TxtDistrictId);
			pstm.execute();
		}catch(NullPointerException ex)
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
	district = request.getParameter("district");
	//System.out.println(pwd);
	description = request.getParameter("descript").trim();
	//System.out.println(description);
	TxtDistrictId=Integer.parseInt(request.getParameter("TxtDistrictId"));
	TxtStateId=Integer.parseInt(request.getParameter("TxtStateId"));
	//user=Integer.parseInt(userid);
	////System.out.println(userid);
	//Loading JDBC Connection Information
	try
	{
		con =conbean.getConnection();
		updateUserInformation() ;
		releaseJDBCResource();
		response.sendRedirect("District_View.jsp?TxtStateId="+TxtStateId);
	}catch(Exception ex)
	{
		//System.out.println(ex);
	}
		releaseJDBCResource();
%>
<td width="214" valign="top" background="../if"><a
	href="StudentCourse.htm"><img src="../Images/General/Back.gif"
	width="70" height="22" border="0"></a>
</div>
</td>

