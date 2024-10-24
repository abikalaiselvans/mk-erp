<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!
	Connection con ;
	PreparedStatement pstm;
	ResultSet rst;
	String TxtDistrictName,TxtDistrictDes;
	String Sql;
	int TxtStateId;
	String sql_Insert_Query ="INSERT INTO  com_m_district (INT_DISTRICTID,CHR_DISTRICTNAME,CHR_DISTRICTDES,INT_STATEID,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS)VALUES(?,?,?,?,?,?,?)";

	public void insertBranchInformation() 
	{
		int Count;		
		try
		{
		Sql="Select max(INT_DISTRICTID) as maxid from  com_m_district  where chr_UPDATESTATUS='y'";
		pstm = con.prepareStatement(Sql);
		rst=pstm.executeQuery();
		if (rst.next())
		{			
			Count=rst.getInt("maxid") +1 ;
		}
		else
		{
			Count=1;
		}			
			pstm = con.prepareStatement(sql_Insert_Query);
			pstm.setInt(1,Count);
			pstm.setString(2,TxtDistrictName);
			pstm.setString(3,TxtDistrictDes);
			pstm.setInt(4,TxtStateId);
			pstm.setString(5,"ADMIN");
			pstm.setString(6,"2003-06-20 00:00:00");
			pstm.setString(7,"Y");
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
			rst.close();
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
<form  AUTOCOMPLETE = "off"   method="post">
<%
	//Form Information
	TxtDistrictName= request.getParameter("TxtDistrictName");	
	////System.out.println(TxtBranchName);
	TxtDistrictDes = request.getParameter("TxtDistrictDes").trim();
	TxtStateId=Integer.parseInt(request.getParameter("TxtStateId"));
	%> <%
	String sql_Select_Query = "SELECT CHR_DISTRICTNAME FROM  com_m_district  WHERE INT_STATEID="+TxtStateId;
	//Loading JDBC Connection Information
	try
	{		
		con = conbean.getConnection();
		pstm = con.prepareStatement(sql_Select_Query);
		rst = pstm.executeQuery();
		insertBranchInformation() ;
	}
	catch(NullPointerException ex){}
	response.sendRedirect("DistrictRegistered.jsp?TxtStateId="+TxtStateId);
		
%>
</form>
