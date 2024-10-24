package com.my.org.erp.SmartDebug;

import java.io.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
@SuppressWarnings("serial")
@WebServlet("/DownloadlogdeleteFile")
public class Downloaddelete extends HttpServlet 
{
	@SuppressWarnings("deprecation")
	public void doGet(HttpServletRequest request, HttpServletResponse response)	throws ServletException, IOException 
	{
		try 
		{
			String[] downfile = request.getParameterValues("downfile");
			for (int i = 0; i < downfile.length; i++) 
			{
				 String path = request.getRealPath("/")+"log\\"+downfile[i];
				 File file = new File(path);
				 if(file.exists())
				 {
					 file.delete();
				 
				 }
			 }
			
			response.sendRedirect("Smart Debug/ErrorList.jsp");
			 
		}
		catch (RuntimeException e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response); 
			  
		}
		catch (Exception e1) 
		{
			System.out.println(e1.getMessage());
			request.setAttribute("error", e1.getMessage() );
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response); 
			  
		}
	}
 
}
