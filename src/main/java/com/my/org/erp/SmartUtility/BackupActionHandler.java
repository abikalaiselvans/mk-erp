package com.my.org.erp.SmartUtility;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintStream;

import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;


public class BackupActionHandler extends AbstractActionHandler
{
		public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
		{
			try
			{
					String action=request.getParameter("actionS");
					 
					if(action.equals("UTIBackup"))
					{					
						Runtime rt = Runtime.getRuntime();
						PrintStream ps;
						String profilename = "JDBC.properties";
						InputStream input = new FileInputStream(profilename);
						Properties dbfile = new Properties();
						dbfile.load(input);
						String host=dbfile.getProperty("host");
						String user=dbfile.getProperty("user");
						String pw=dbfile.getProperty("pass");
						String databasedumb=dbfile.getProperty("exportpath");
						
						String mysqlpath = dbfile.getProperty("mysql");
						mysqlpath = mysqlpath+"/bin/mysqldump -h "+host+" -u "+user+" -p "+pw+" smartcampus";
						 
						File test=new File(databasedumb); 
						Process child = rt.exec(mysqlpath);
						ps=new PrintStream(test);
						InputStream in = child.getInputStream();
						int ch;
						while ((ch = in.read()) != -1) 
								ps.write(ch);
						response.sendRedirect("Utility/Userframe.jsp");
					}
					
			}
			catch (Exception e) 
			{
				System.out.println(e.getMessage());
				request.setAttribute("error", e.getMessage() );
		        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
		    	dispatchers.forward(request, response); 

			}
		}
	
	
		 

}