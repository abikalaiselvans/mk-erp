package sample.db;

import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.*;
import java.util.Properties;
public class DBConnect
{	
	//Static instance of connection, only one will ever exist
	private static Connection connection = null;		
	
	
	//Returns single instance of connection
	public static Connection getConnection()
	{
		try
		{
			//If instance has not been created yet, create it
			if(DBConnect.connection == null)
			{
				initConnection();
			}
			return DBConnect.connection;
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return DBConnect.connection;
	}	
	
	
	//Gets JDBC connection instance
	private static void initConnection()
	{			
		try
		{		
			/*Class.forName("com.mysql.jdbc.Driver");		
			String url = "jdbc:mysql://localhost/smartcampus";
			String user = "root";
			String pw = "mythra";
			DBConnect.connection =
            DriverManager.getConnection(url, user, pw);	*/
			
			String profilename = "JDBC.properties";
			InputStream input = new FileInputStream(profilename);
			Properties jdbc = new Properties();
			jdbc.load(input);
			String driver =jdbc.getProperty("DB_DRIVER");
			String url = jdbc.getProperty("DB_URL");
			String struser =jdbc.getProperty("DB_USERNAME");
			String Passw =  jdbc.getProperty("DB_PASSWORD");
			Class.forName(driver);
			DBConnect.connection = DriverManager.getConnection(url, struser, Passw);
		}
		catch (ClassNotFoundException e)
		{		
			System.out.println(e.getMessage());
			System.exit(0);
		}
		catch (SQLException e)
		{			
			System.out.println(e.getMessage());
			System.exit(0);
		}
		catch (Exception e)
		{	
			System.out.println(e.getMessage());
		}		
	}
}