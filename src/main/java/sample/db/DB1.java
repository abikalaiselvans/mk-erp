package sample.db;

import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;



public  final class DB1 
{
	static Connection con = null;
	public DB1() throws Exception 
	{
	}


	
	public static Connection getConnection() 
	{
		try 
		{
			String profilename = "JDBC.properties";
			InputStream input = new FileInputStream(profilename);
			Properties jdbc = new Properties();
			jdbc.load(input);
			String driver =jdbc.getProperty("DB_DRIVER");
			String url = jdbc.getProperty("DB_URL");
			String struser =jdbc.getProperty("DB_USERNAME");
			String Passw =  jdbc.getProperty("DB_PASSWORD");
			/*Class.forName(driver);
			con = DriverManager.getConnection(url, struser, Passw);
			if(con == null)
				System.out.println("Connection null");
			*/
			
			
			 
	        try 
	        {
	        	Class.forName(driver).newInstance();
	        }
	        catch (Exception ex)
	        {
	        	log("Check classpath. Cannot load db driver: " + driver);
	        }

	        try 
	        {
	        	con = DriverManager.getConnection(url, struser, Passw);
	        }
	        catch (SQLException e)
	        {
	        	log( "Driver loaded, but cannot connect to db: " + url);
	        }
	        return con;
	        
	        
			 
		} 
		catch (Exception e) 
		{
			return null;
		}
	}

	public static void closeConnection() 
	{
		
		try 
		{
			 
		} 
		catch (Exception e) 
		{
			 System.out.println(e.getMessage());
		}
	}
	
	
	 private static void log(Object aObject)
	  {
	    System.out.println(aObject);
	  }
}
