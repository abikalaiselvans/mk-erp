package com.my.org.erp.export;
import java.io.File;
import java.io.FileInputStream;

import java.io.InputStream;

import java.io.PrintStream;

import java.util.Properties;


public class Export
{
	
	public static void exportDatabase() 
	 {
		try 
	 	{
			Runtime rt = Runtime.getRuntime();
			PrintStream ps;
			String profilename = "JDBC.properties";
			InputStream input = new FileInputStream(profilename);
			Properties dbfile = new Properties();
			dbfile.load(input);
			String host=dbfile.getProperty("host");
			String user=dbfile.getProperty("user");
			String pw=dbfile.getProperty("password");
			String databasedumb=dbfile.getProperty("databaseexport");
			String mysqlpath = dbfile.getProperty("mysql");
			mysqlpath = mysqlpath+"/bin/mysqldump -h"+host+" -u"+user+" -p"+pw+" smartcampus";
			File test=new File(databasedumb); 
			Process child = rt.exec(mysqlpath);
			ps=new PrintStream(test);
			InputStream in = child.getInputStream();
			int ch;
			while ((ch = in.read()) != -1) 
					ps.write(ch);
		}
		
	 	catch (Exception e) 
	 	{
	 		//String s=""+e.getMessage();
	 		//System.out.println(s);
	 	}
	 	 
	 }
	
	
	public static void exportTabletoXML(String database, String table, String path) 
	 {
		try 
	 	{
			Runtime rt = Runtime.getRuntime();
			String mysql = "D:/Program Files/mmi/MySQL/MySQL Server 5.0/bin";
			String mysqlpath=mysql+"/mysqldump --xml "+database+" "+table+"";
			System.out.println(mysqlpath);
			@SuppressWarnings({ "unused", "unused" })
			Process child = rt.exec(mysqlpath);
			//mysqldump --xml databasename [tables]
			
	 	}
		catch (Exception e) 
		{
			
	 	}
	 }
		
	public static void importDatabase() 
	 {
		try 
	 	{
			@SuppressWarnings("unused")
			Runtime rt = Runtime.getRuntime();
			@SuppressWarnings("unused")
			PrintStream ps;
			String profilename = "JDBC.properties";
			InputStream input = new FileInputStream(profilename);
			Properties dbfile = new Properties();
			dbfile.load(input);
			String host=dbfile.getProperty("host");
			String user=dbfile.getProperty("user");
			String pw=dbfile.getProperty("password");
			String databasedumb=dbfile.getProperty("databaseexport");
			String mysqlpath = dbfile.getProperty("mysql");
			//System.out.println(databasedumb);
			//mysql -p -h DBSERVER dbname < dbname.sql
			mysqlpath = mysqlpath+"/bin/mysql -p -h"+host+" -u"+user+" -p"+pw+" portal < "+databasedumb;
			//mysqlpath = mysqlpath+"/bin/mysql -p -h "+host+" < "+databasedumb;
			//System.out.println(mysqlpath);
			//Process child = rt.exec(mysqlpath);
			Runtime.getRuntime().exec("rundll32 SHELL32.DLL,ShellExec_RunDLL "+mysqlpath);
		}
	 	catch (Exception e) 
	 	{
	 		
	 	}
	 	 
	 }
}