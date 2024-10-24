package com.my.org.erp.SmartDownload;

import java.io.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
 
@SuppressWarnings("serial")
@WebServlet("/DownloadFile")
public class DownloadServlet extends HttpServlet 
{
 
	@SuppressWarnings("deprecation")
	public void doGet(HttpServletRequest request, HttpServletResponse response)	throws ServletException, IOException 
	{
		try 
		{
			String downfile = request.getParameter("downfile");
			System.out.println(downfile);
			String path = request.getRealPath("/")+"Smart UploadDownload/Upload/"+downfile;
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			response.setContentType("APPLICATION/OCTET-STREAM"); 
			response.setHeader("Content-Disposition","attachment; filename=\"" + downfile + "\""); 
			FileInputStream fileInputStream = new FileInputStream(path);
			int i; 
			while ((i=fileInputStream.read()) != -1) 
			{
				out.write(i); 
			} 
			fileInputStream.close(); 
			out.close();
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
