package com.my.org.erp.listener.db;

import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBConnectionManager {
 
    private  String dbURL;
    private  String user;
    private  String password;
    private  Connection con;
     
    public DBConnectionManager(String url, String u, String p)
    {
        this.dbURL=url;
        this.user=u;
        this.password=p;
        //create db connection now
       
         
    }
     
    public Connection getConnection()
    {
       
    	try 
		{
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(dbURL, user, password);
		    if(con == null || con.isClosed())
				System.out.println("JDBC.Properties Connection null"); 
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
     
    
    public void closeConnection()
    {
        try 
        {
			//close DB connection here
			con.close();
		} 
        catch (SQLException e) 
        {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    
    public Connection getCon()
	{
		try 
		{
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(dbURL, user, password);
		    if(con == null || con.isClosed())
				System.out.println("JDBC.Properties Connection null"); 
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

}
