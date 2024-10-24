package com.my.org.erp.common;

import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.Properties;

public class DatabaseFunctions 
{
	
	public boolean checkDbExists(String dbname)
	{
		boolean flag = false;
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
			Connection con = DriverManager.getConnection(url, struser, Passw);
			ResultSet res=	con.getMetaData().getCatalogs();
			while(res.next())
			{
				String db=res.getString(1);
				if(db.equals( dbname))
					flag= true;
					
			
			}
			res.close();
			return flag;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return flag;
		}
	}
	
	
	public void importDatabase(String dbname)
	{
		 
		String executeCmd="C:/Program Files/MySQL/MySQL Server 5.0/bin/mysqldump  -u root -proot "+dbname+"--add-drop-database -r E:/jar/"+dbname+".sql ";
		try
		{
			Process runtimeProcess;
			runtimeProcess=Runtime.getRuntime().exec(executeCmd);
			int ProcessComplete=runtimeProcess.waitFor();
			if(ProcessComplete == 2)
				System.out.print("Success");
			else
				System.out.print("Check again");
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
	}
	
	
	

}
