<%@ page import="java.sql.*,java.util.*,java.io.*"%>

<%!
	Connection con ;
	PreparedStatement pstm;
	ResultSet rst;
	
	String userid;
	String name,grno,dat,phno,description,quant,itcode;
	int quantity,Count;
	String Sql;

String sql_Insert_Query ="INSERT INTO t_grn(chr_GRNNO,dt_DATE,chr_PONO,chr_ITEMCODE,int_QTY,int_SUPPLIERID,chr_DESC,chr_USRNAME,dt_UPDATEDATE,chr_UPDATESTATUS)VALUES(?,?,?,?,?,?,?,?,?,?)";

public void insertUserInformation() 
	{
	
		
		try
		{
		Sql=" Select * from t_purchaseorder where chr_PONO=?";
		pstm = con.prepareStatement(Sql);
		pstm.setString(1,phno);
		
		rst=pstm.executeQuery();

		if (rst.next())
		{
			
			Count=rst.getInt("int_SUPPLIERID"); 
				
		}
		
		//System.out.println(Count);		
				
			pstm = con.prepareStatement(sql_Insert_Query);

			pstm.setString(1,grno);
			pstm.setString(2,dat);
			pstm.setString(3,phno);
			pstm.setString(4,itcode);
			pstm.setInt(5,quantity);
			pstm.setInt(6,Count);
			pstm.setString(7,description);
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




	grno = request.getParameter("grn");
	dat=request.getParameter("date");	
	phno = request.getParameter("pono");
	
	description = request.getParameter("des");
	


	
	quant=request.getParameter("qty");

	quantity=Integer.parseInt(quant);
	//System.out.println(quantity);	
	

	itcode = request.getParameter("icode");






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
