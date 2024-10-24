package DBConnection;
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;
import java.sql.DriverManager;
import javax.naming.*;
import javax.sql.*;

import com.my.org.erp.General.General;
 
public class DBCon 
{
	public  static Connection con = null;
	
	public DBCon() throws Exception 
	{
		
	}

	public Connection getInstance()    
	{
		try 
		{
			if(con == null)
			 con = getConnection()  ;
			return con;
		}  
		 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			return null;
		}
	}
			
	 


	@SuppressWarnings("unused")
	public Connection getConnection()
	{
		try 
		{
			
			Properties properties = new Properties();
        	properties.load(Thread.currentThread().getContextClassLoader().getResourceAsStream("JDBC.properties"));
        	String cd_key = properties.getProperty("DB_DRIVER");
        	 
        	
			String profilename = "JDBC.properties";
			InputStream input = new FileInputStream(profilename);
			Properties jdbc = new Properties();
			jdbc.load(input);
			String driver =jdbc.getProperty("DB_DRIVER");
			String url = jdbc.getProperty("DB_URL");
			String struser =jdbc.getProperty("DB_USERNAME");
			String Passw =  jdbc.getProperty("DB_PASSWORD");
			String type =  jdbc.getProperty("DB_TYPE");
			 
			//System.out.println(url);
			if("JNDID".equals(type))
			{
				//String DATASOURCE_CONTEXT = "java:comp/env/jdbc/test";
				//Context initialContext = new InitialContext();
				//DataSource datasource = (DataSource)initialContext.lookup(DATASOURCE_CONTEXT);
				
				Context initContext = new InitialContext();
				Context envContext  = (Context)initContext.lookup("java:/comp/env");
				DataSource datasource = (DataSource)envContext.lookup("jdbc/TestDB");
				con = datasource.getConnection();
				if (datasource == null) 
			    	System.out.println("JNDI Connection null");
			}
			else
			{ 
				Class.forName(driver);
				con = DriverManager.getConnection(url, struser, Passw);
			    if(con == null || con.isClosed())
					System.out.println("JDBC.Properties Connection null"); 
			}
			return con;
		    
		}  
		catch (SQLException e) 
		{
			 System.out.println(e.getMessage());
			 return null;
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			return null;
		}
		finally
		{
			
		}
	}

	 
		  
		  
	public  void closeConnection() 
	{
		try 
		{
			 con.close();
		} 
		catch (SQLException e) 
		{
			 System.out.println(e.getMessage());
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			
		}
		finally
		{
			
		}
	}

	 
}
 