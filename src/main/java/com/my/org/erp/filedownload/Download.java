package com.my.org.erp.filedownload;

import java.io.FileInputStream;
import java.io.IOException;  
import java.io.PrintWriter;

import javax.servlet.ServletException;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import java.io.*;  
   
   
public class Download extends HttpServlet 
{  
	/**
	 * 
	 */
	private static final long serialVersionUID = -7437626264096013911L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, FileNotFoundException  
	{  
   
		 try 
		 {
			 	 
			 	response.setContentType("text/html");
				PrintWriter out = response.getWriter();
				response.setContentType("APPLICATION/OCTET-STREAM");
				String f = request.getParameter("file");
				response.setHeader("Content-Disposition","attachment; filename=\"SmartHelp.pdf\""); 
				FileInputStream fileInputStream = new FileInputStream(request.getRealPath("/")+f);
				int i; 
				while ((i=fileInputStream.read()) != -1) 
				{
					out.write(i); 
				} 
				fileInputStream.close(); 
				out.close();
			 
		} 
		 catch (RuntimeException e) 
		 {
			 System.out.println(e.getMessage());
		}  
	}  
	
	
	
	
	 
}  