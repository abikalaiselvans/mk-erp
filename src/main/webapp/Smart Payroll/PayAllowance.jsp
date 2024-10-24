<%@ page import="java.sql.*,java.util.*,java.io.*"%>

<%!
	Connection con ;
	PreparedStatement pstm;
	ResultSet rst;
	String userid;
	String allname;
	String allcode;
	String Sql;
String sql_Insert_Query ="INSERT INTO m_allowance(chr_ACODE,chr_ANAME)VALUES(?,?)";
	

	public void insertUserInformation() 
	{
		
			/*
			try
			{
			Sql="Select max(chr_rcode) as maxid from m_allownace ";
			pstm = con.prepareStatement(Sql);
			rst=pstm.executeQuery();

			if (rst.next())
			{
				
				Count=rst.getString("maxid") +1 ; 
				
		
			}
			else
			{
		

				Count=1;
			}
			*/
		try{
			pstm = con.prepareStatement(sql_Insert_Query);

			pstm.setString(1,allcode);
				
			pstm.setString(2,allname);
			
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

	String sql_Select_Query = "SELECT CHR_USRNAME FROM m_user";

	//Form Information
	allname = request.getParameter("aname");
	
    allcode = request.getParameter("acode");
	
	//Loading JDBC Connection Information
	try
	{
		String profilename="c:/Tomcat 5.0/bin/JDBC.properties";
		InputStream input  = new FileInputStream(profilename);	
		Properties jdbc = new Properties();
		jdbc.load(input);
		String driver = jdbc.getProperty("Driver");
		String url =jdbc.getProperty("UrlCol");
		String struser =jdbc.getProperty("User");
		String Passw =jdbc.getProperty("Passw");
		
		//Database Connectivity
		Class.forName(driver);
		con = DriverManager.getConnection(url,struser,Passw);
		pstm = con.prepareStatement(sql_Select_Query);
		rst = pstm.executeQuery();
		boolean exist = false;
		while(rst.next())
		{
		
		if(rst.getString("chr_USRNAME").equalsIgnoreCase(userid))
			{
				exist = true;
				releaseJDBCResource();
				break;				
			}
		}

		if(exist == true)
		{
			session.putValue("Username",userid);
			
			
			releaseJDBCResource();
			response.sendRedirect("ExsistUtility.htm");
		}
		else
		{
			insertUserInformation();
			releaseJDBCResource();
			response.sendRedirect("AllowanceRegistered.jsp");
		}

	}catch(FileNotFoundException ex)
	{
		//System.out.println(ex);
	}
	catch(SQLException ex)
	{
		//System.out.println(ex);
	}
		releaseJDBCResource();	
%>
