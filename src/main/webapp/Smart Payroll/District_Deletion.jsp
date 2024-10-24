<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!
	Connection con ;
	PreparedStatement pstm;
	ResultSet rst;
	int i=0,TxtStateId;
	String pwd;
	String user;
	String description;	

	
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
			//System.out.println("HAI" +ex);
		}
	}		
	%>
<%	
	TxtStateId=Integer.parseInt(request.getParameter("TxtStateId"));
	//Loading JDBC Connection Information
	String sql_Delete_Query ="delete from  com_m_district  where CHR_DISTRICTNAME=?";
	try
	{
		String []OptDistrictName= request.getParameterValues("OptDistrictName");
		
		
		con = conbean.getConnection();	

		for(int i=0;i<OptDistrictName.length;i++){			
			////System.out.println(statename[i]);
			pstm = con.prepareStatement(sql_Delete_Query);
			pstm.setString(1,OptDistrictName[i]);
			pstm.execute();			
		}

		releaseJDBCResource();		
		response.sendRedirect("District_View.jsp?TxtStateId="+TxtStateId);

	}catch(Exception ex)
	{
		//System.out.println(ex);
	}
%>
