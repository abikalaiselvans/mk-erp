<%-- <%@ page import="java.sql.*,java.util.*,java.io.*"%>

<%!
	Connection con ;
	PreparedStatement pstm;
	ResultSet rst;
	String coursename;
	
	String description;
	String Sql;
String sql_Insert_Query ="INSERT INTO m_supplier(int_SUPPLIERID,chr_SUPPLIERNAME,chr_CONTPERSON,int_PHONENO,int_CEILNO,int_FAXNO,chr_WEBSITE,chr_EMAIL,chr_ADD1,chr_ADD2,chr_CITY,chr_STATE,int_PIN,chr_USRNAME,dt_UPDATEDATE,chr_UPDATESTATUS)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";


	

	public void insertUserInformation() 
	{
		
		try
		{
				
			pstm = con.prepareStatement(sql_Insert_Query);

			pstm.setString(1,"");
			//System.out.println(Count);	
			pstm.setString(2,coursename);
			pstm.setString(3,description);
			pstm.setString(4,"ADMIN");
			pstm.setString(5,"2003-06-20 00:00:00");
			pstm.setString(6,"Y");
			pstm.execute();
		}catch(NullPointerException ex)
		{
		                     //System.out.println(ex);
		}catch(SQLException ex)
		{
			//System.out.println(ex);
		}
	}
	
	 
		
 
	  sql_Select_Query = "SELECT CHR_USRNAME FROM m_user";

	//Form Information




	coursename = request.getParameter("course");
	String branchname=request.getParameter("branch");	
	description = request.getParameter("des").trim();
	coursename = request.getParameter("course");
	String branchname=request.getParameter("branch");	
	description = request.getParameter("des").trim();
	coursename = request.getParameter("course");
	String branchname=request.getParameter("branch");	
	description = request.getParameter("des").trim();
	coursename = request.getParameter("course");
	String branchname=request.getParameter("branch");	
	description = request.getParameter("des").trim();
	coursename = request.getParameter("course");
	String branchname=request.getParameter("branch");	
	description = request.getParameter("des").trim();
	coursename = request.getParameter("course");
	String branchname=request.getParameter("branch");	
	description = request.getParameter("des").trim();
	coursename = request.getParameter("course");
	String branchname=request.getParameter("branch");	
	description = request.getParameter("des").trim();
	
	

















//Loading JDBC Connection Information
	try
	{
		String profilename="c:/Tomcat 5.0/bin/JDBC.properties";
		InputStream input  = new FileInputStream(profilename);	
		Properties jdbc = new Properties();
		jdbc.load(input);
		String driver = jdbc.getProperty("Driver");
		String url =jdbc.getProperty("Url");
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
			response.sendRedirect("Registered1.htm");
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
 --%>