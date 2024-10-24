<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<
<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>

<%!
	Connection con ;
	PreparedStatement pstm,pstm1,pstm2,pstm3;
	ResultSet rst1,rst2,rst3,rst;
	String userid,y1,y2,y3,month;
	String OptEmpName,TxtType,TxtDoc,TxtReason,TxtDate;
	String Sql;	
	int TxtMonth,TxtYear;
String sql_Insert_Query ="INSERT INTO PAY_M_EMP_TERMINATION(CHR_EMPID,DT_TERM_DATE,CHR_REASON,CHR_TER_TYPE)values(?,?,?,?)";

	private String FormateDateSQL(String indate)
	{
		String date= indate.substring(0,2);
		String month= indate.substring(3,5);
		String year= indate.substring(6);
		return(""+year +"-"+month+"-"+date);
	}

	public void insertUserInformation() 
	{
		
		try
		{   
			pstm = con.prepareStatement(sql_Insert_Query);
			pstm.setString(1,OptEmpName);
			pstm.setString(2,TxtDate);
			pstm.setString(3,TxtReason);
			pstm.setString(4,TxtType);
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
	OptEmpName=request.getParameter("ename"); 
	TxtType= request.getParameter("TxtType");
	TxtDoc = request.getParameter("TxtDoc");
	TxtDate=FormateDateSQL(TxtDoc);
	TxtReason = request.getParameter("TxtReason");
	//Loading JDBC Connection Information
	try
	{		
		con = conbean.getConnection();
		insertUserInformation();
		releaseJDBCResource();
		response.sendRedirect("Employee Cessation.jsp?message=Employee Cessated Sucessfully");
	
	}catch(FileNotFoundException ex)
	{
		//System.out.println(ex);
	}
	
%>
