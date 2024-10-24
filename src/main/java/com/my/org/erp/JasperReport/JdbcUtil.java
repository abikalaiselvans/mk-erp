package com.my.org.erp.JasperReport;

import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

public class JdbcUtil 
{

	private static Connection con;
	
	static
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, struser, Passw);
		    if(con == null || con.isClosed())
				System.out.println("JDBC.Properties Connection null"); 
			
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	private  JdbcUtil(){}
	
	public static Connection getJdbcConnection()
	{
		return con;
	}
	
	public static void closeJdbcConnection()
	{
		try
		{
			if(con!=null)
				con.close();
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
}
