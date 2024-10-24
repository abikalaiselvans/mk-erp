package com.my.org.erp.SmartDebug;

import java.io.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
@SuppressWarnings("serial")
@WebServlet("/DownloadlogFile")
public class Downloadlog extends HttpServlet 
{
 
	@SuppressWarnings("deprecation")
	public void doGet(HttpServletRequest request, HttpServletResponse response)	throws ServletException, IOException 
	{
		try 
		{
			String downfile = request.getParameter("downfile");
			System.out.println(downfile);
			String path = request.getRealPath("/")+"log/"+downfile;
			System.out.println(path);
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
		catch (RuntimeException e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
		} 
	}
 
}
