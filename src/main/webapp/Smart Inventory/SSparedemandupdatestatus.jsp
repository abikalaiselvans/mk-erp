<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>

<%!
	Connection con ;
	PreparedStatement pstm;
	ResultSet rst;
	String sparedemanno,issuestatus;
	String Sql;	
String sql_Insert_Query ="UPDATE inv_ss_sparedemand SET CHR_ISSUED = ? WHERE CHR_DEMANDNO=?";
	public void insertUserInformation() 
	{
		
		try
		{   
			pstm = con.prepareStatement(sql_Insert_Query);
			pstm.setString(1,"Y");
			pstm.setString(2,sparedemanno);
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

<%	
	sparedemanno=request.getParameter("demand"); 
	issuestatus=request.getParameter("spareissuestatus");
	//Loading JDBC Connection Information
	try
	{		
		con = conbean.getConnection();
		if(issuestatus.equals("Y")){
		insertUserInformation();
		}
		releaseJDBCResource();
		response.sendRedirect("SSpareissueview.jsp?message=Spare demand status Updated Sucessfully");
	
	}catch(FileNotFoundException ex)
	{
		//System.out.println(ex);
	}
	
%>
