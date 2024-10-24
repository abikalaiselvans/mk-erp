package com.my.org.erp.test;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class JDBCWork  extends HttpServlet
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			
			
			String name = request.getParameter("name");
			String mobile = request.getParameter("mobile");
			String action = request.getParameter("action");
			
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/nandhakumar", "root", "mythra");
			if(con == null)
				System.out.println("Connection null");
			else
			{
				
				if("Delete".equals(action))
				{
					String rowid = request.getParameter("rowid");
					Statement st = con.createStatement();
					String sql = "DELETE FROM contactdetails WHERE id="+rowid;
					
					st.execute(sql);
					st.close();
				}
				else  if("Add".equals(action))
				{
					Statement st = con.createStatement();
					String sql = "INSERT INTO contactdetails (CHR_NAME,INT_MOBILE) VALUES('"+name+"',"+mobile+") ";
					st.execute(sql);
					st.close();
				}
 
			}	
			response.sendRedirect("Test/JDBCTest.jsp");
		}
		catch(Exception e)
		{
			
		}
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			doPost(request,response);
		} 
		catch(Exception e)
		{
			
		}
}
}
