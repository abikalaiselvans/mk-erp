<%@ page import="java.sql.*,java.util.*,java.io.*,java.lang.String.* "%>

<%!
	Connection con ;
	PreparedStatement pstm;
	ResultSet rst;
	String branchname;
	String userid;
	String description;
	String Sql;
	String itemcode,total1,uoh1,issue1;
	String catid1;
	int total,unit,issued;

String sql_Insert_Query ="INSERT INTO m_itemstock(chr_ITEMCODE,int_TOTQTY,int_UOHQTY,int_ISSUEDQTY,chr_USRNAME,dt_UPDATEDATE,chr_UPDATESTATUS)VALUES(?,?,?,?,?,?,?)";

	

	public void insertUserInformation() 
	{
				
		try
		{
		

		
		
			pstm = con.prepareStatement(sql_Insert_Query);

			pstm.setString(1,itemcode);
			pstm.setInt(2,total);
			pstm.setInt(3,unit);
			pstm.setInt(4,issued);
				
			pstm.setString(5,"ADMIN");
			pstm.setString(6,"2003-06-20 00:00:00");
			pstm.setString(7,"Y");
			pstm.execute();
		}
		
		catch(NullPointerException ex)
		{
		                     //System.out.println(ex);
		}


		catch(SQLException ex)
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
	 
	
	itemcode=request.getParameter("item");
	
	
	total1= request.getParameter("tqty");
	total=Integer.parseInt(total1);
	
	uoh1 = request.getParameter("uoh");
	unit=Integer.parseInt(uoh1);
	
	issue1 = request.getParameter("iqty");
	issued=Integer.parseInt(issue1);


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
			
			session.putValue("Description",description);
			releaseJDBCResource();
			response.sendRedirect("ExsistUtility.htm");
		}
		else
		{
			insertUserInformation();
			releaseJDBCResource();
			response.sendRedirect("Registered.htm");
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