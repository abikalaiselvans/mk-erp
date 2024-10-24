package com.my.org.erp.common;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import com.my.org.erp.General.General;
public class PropertiesFunctions 
{
	public static String getModuleTitle(String shortname) 
	{
		String Title = "";
		try 
		{
			Properties properties = new Properties();
			properties.load(Thread.currentThread().getContextClassLoader().getResourceAsStream("ERP_TITLE.properties"));
			Title= properties.getProperty("shortname");
		    return Title;
		} 
		catch (Exception e) 
		{
			 System.out.println(e.getMessage());
			
		}
		return Title;
		 
	}
	
	public static boolean getLicence() 
	{
		boolean flag  = false;
		try 
		{
			
			Properties properties = new Properties();
        	properties.load(Thread.currentThread().getContextClassLoader().getResourceAsStream("lock.properties"));
        	String cd_key = properties.getProperty("cd_key");
        	flag =General.LockCheck(cd_key); 
        	return flag;
		} 
		catch (Exception e) 
		{
			 System.out.println(e.getMessage());
			
		}
		return flag;
		 
	}
	
	public static void overwriteLicence(HttpServletRequest request) 
	{
		try 
		{
			String sline1="cd_key=hfe-jdc";
			String filename = request.getSession().getServletContext().getRealPath("/WEB-INF/classes/lock.properties");
			FileWriter fw1 = new FileWriter(filename);
			BufferedWriter bw1 = new BufferedWriter(fw1);
			bw1.write(sline1);
			bw1.close();
			fw1.close();
		} 
		catch (Exception e) 
		{
			 System.out.println(e.getMessage());
			
		}
		 
		 
	}
}
