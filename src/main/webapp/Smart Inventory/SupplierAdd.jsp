<%@ page import="java.sql.*,java.util.*,java.io.*"%>

<%!
	Connection con ;
	PreparedStatement pstm;
	ResultSet rst;
	String coursename;
	String userid;
	String supname,contact,phno1,cellno1,faxno1,web1,email,address1,address2,city1,state,pincode;
	int phno2,cellno2,faxno2,pin1;
	String Sql;

String sql_Insert_Query ="INSERT INTO m_supplier(int_SUPPLIERID,chr_SUPPLIERNAME,chr_CONTPERSON,int_PHONENO,int_CEILNO,int_FAXNO,chr_WEBSITE,chr_EMAIL,chr_ADD1,chr_ADD2,chr_CITY,chr_STATE,int_PIN,chr_USRNAME,dt_UPDATEDATE,chr_UPDATESTATUS)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";


	

	public void insertUserInformation() 
	{
	int Count;
		
		try
		{
		Sql=" Select max(int_SUPPLIERID) as maxid from m_supplier where chr_USRNAME='ADMIN'";
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
			//System.out.println(Count);	
			pstm.setString(2,supname);
			pstm.setString(3,contact);
			pstm.setInt(4,phno2);
			pstm.setInt(5,cellno2);
			pstm.setInt(6,faxno2);
			pstm.setString(7,web1);
			pstm.setString(8,email);
			pstm.setString(9,address1);
			pstm.setString(10,address2);
			pstm.setString(11,city1);
			pstm.setString(12,state);
			pstm.setInt(13,pin1);
			pstm.setString(14,"ADMIN");
			pstm.setString(15,"2003-06-20 00:00:00");
			pstm.setString(16,"Y");
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




	supname = request.getParameter("sname");
	contact=request.getParameter("cont");	
	phno1 = request.getParameter("phno");
	phno2=Integer.parseInt(phno1);
	cellno1 = request.getParameter("cellno");
	cellno2=Integer.parseInt(cellno1);
	faxno1=request.getParameter("faxno");
	faxno2=Integer.parseInt(faxno1);	
	web1 = request.getParameter("web");
	email = request.getParameter("mail");
	address1=request.getParameter("add1");	
	address2= request.getParameter("add2");
	city1 = request.getParameter("city");
	state=request.getParameter("st");	
	pincode = request.getParameter("pin");
	pin1=Integer.parseInt(pincode);





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
