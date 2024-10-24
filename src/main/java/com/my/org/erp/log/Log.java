package com.my.org.erp.log;
import java.io.IOException;
import java.util.logging.FileHandler;
import java.util.logging.Level;
import java.util.logging.LogRecord;
import java.util.logging.Logger;

public class Log   
{	
	public static void logger(String message)
	{
		try 
		{
			
			boolean append = true;
			FileHandler handler = new FileHandler("../webapps/SmartCampus/log/my.log", append);
			Logger logger = Logger.getLogger(message);
			LogRecord rec1 = new LogRecord(Level.WARNING,"Do something here!");
	        handler.publish(rec1);
	        logger.addHandler(handler);
		} 
		catch (IOException e) 
		{
		}
	}
}