<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />

<%!
	Connection con ;
	PreparedStatement pstm;
	ResultSet rst;
	String Sql,staff,TxtProgramName,TxtTime,TxtVenu,TxtTrainer,TxtSubject,TxtDate,TxtProgDate;
	int TxtMonth,TxtYear,Count;
	String sql_Insert ="INSERT INTO PAY_M_EMP_TRAINING(INT_PROGRAMID,CHR_PROGNAME,DT_PDATE,DT_PTIME,CHR_VENUE,CHR_TRAINER,CHR_SUBJECT,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS)values(?,?,?,?,?,?,?,?,?,?)";
	String sql_Insert_Query="INSERT INTO PAY_T_EMP_TRAINING(INT_PROGRAMID,CHR_EMPID)VALUES(?,?)";
	String staffname[];
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
			Sql="Select max(INT_PROGRAMID) as maxid from PAY_M_EMP_TRAINING where CHR_UPDATESTATUS='y'";
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
			
			pstm = con.prepareStatement(sql_Insert);
			pstm.setInt(1,Count);
			pstm.setString(2,TxtProgramName);
			pstm.setString(3,TxtProgDate);
			pstm.setString(4,TxtTime);			
			pstm.setString(5,TxtVenu);
			pstm.setString(6,TxtTrainer);
			pstm.setString(7,TxtSubject);
			pstm.setString(8,"ADMIN");
			pstm.setString(9,"2003-06-20 00:00:00");
			pstm.setString(10,"Y");
			pstm.execute();
						
		}catch(NullPointerException ex)
		{
		    //System.out.println(ex);
		}catch(SQLException ex)
		{
			//System.out.println(ex);
		}
	}
	public void trainingList(String staffname){
		try
		{	
		pstm = con.prepareStatement(sql_Insert_Query);
		pstm.setInt(1,Count);
		pstm.setString(2,staffname);
		pstm.execute();
		}
		catch(Exception e){
System.out.println(e);}
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
	String staffname[]=request.getParameterValues("ename");
	TxtProgramName=request.getParameter("TxtProgramName"); 
	//System.out.println(TxtProgramName);
	TxtDate= request.getParameter("TxtProgDate");
	TxtProgDate=FormateDateSQL(TxtDate);
	TxtTime= request.getParameter("TxtTime");
	TxtVenu = request.getParameter("TxtVenu");
	TxtTrainer= request.getParameter("TxtTrainer");
	TxtSubject = request.getParameter("TxtSubject");
	//Loading JDBC Connection Information
	try
	{
		con=conbean.getConnection();
		insertUserInformation();
		for(int i=0;i<staffname.length;i++){
			trainingList(staffname[i]);}
		releaseJDBCResource();
		response.sendRedirect("Training Program.jsp?message=Employee Training Added Sucessfully");
		

	}catch(FileNotFoundException ex)
	{
		//System.out.println(ex);
	}
		
%>
