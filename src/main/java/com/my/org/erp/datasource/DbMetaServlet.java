package com.my.org.erp.datasource;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
@WebServlet("/PDbMetaServlet")
public class DbMetaServlet extends HttpServlet 
{
   
	private static final long serialVersionUID = 1L;
	DataSource pool;
	public void init() throws ServletException 
	{
		 
		Context env = null;
		try 
		{
			env = (Context) new InitialContext().lookup("java:comp/env");
			pool = (DataSource) env.lookup("jdbc/TestDB");
			 System.out.println("datasource--"+pool);
			if (pool == null) throw new ServletException( "'jdbc/TestDB' is an unknown DataSource");
		} 
		catch (NamingException ne) 
		{
		
			 
			throw new ServletException(ne);
		}
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)  throws ServletException, java.io.IOException 
	  {
		 try 
		 {
			 System.out.println("sdd");
		} catch (RuntimeException e) {
			 
			 System.out.println(e.getMessage());
		}
	  }
  public void doGet(HttpServletRequest request, HttpServletResponse response)  throws ServletException, java.io.IOException 
  {

	    String sql = "select * from com_m_state";
	    
	    Connection conn = null;
	    Statement stmt = null;
	    ResultSet rs = null;
	    ResultSetMetaData rsm = null;
	    response.setContentType("text/html");
	    java.io.PrintWriter out = response.getWriter();
	    out.println("<html><head><title>Discover a ResultSet</title></head><body  onpaste='return false;'>");
	    out.println("<h2>Here is Info about the returned ResultSet</h2>");
	    out.println("<table border='1'><tr>");
		 System.out.println(""+conn);
	    try 
	    {
	    		//Get a connection from the pool
	    		conn = pool.getConnection();
	    		 System.out.println(""+conn);
	    		//Create a Statement with which to run some SQL
	    		stmt = conn.createStatement();
	    		//Execute the SQL
	    		rs = stmt.executeQuery(sql);
	    		//Get a ResultSetMetaData object from the ResultSet
	    		rsm = rs.getMetaData();
	    		int colCount = rsm.getColumnCount();
	    		//print column names
	    		printMeta(rsm, "name", out, colCount);
	    		//print column index
	    		printMeta(rsm, "index", out, colCount);
	    		//print column type
	    		printMeta(rsm, "column type", out, colCount);
	    		//print column display size
	    		printMeta(rsm, "column display", out, colCount);
	    } 
	    catch (Exception e) 
	    {
	    	 System.out.println(""+e.getMessage());
	    	throw new ServletException(e.getMessage());
	    } 
	    finally 
	    {
	      try 
	      {
	        stmt.close();
	        conn.close();
	      } 
	      catch (SQLException sqle) 
	      {
	      }
	    }
	    out.println("</table></body></html>");
	    out.close();
  } 
  

  //doGet
  private void printMeta(ResultSetMetaData metaData, String type, java.io.PrintWriter out, int colCount) throws SQLException 
  {
	  if (metaData == null || type == null || out == null)  throw new IllegalArgumentException("Illegal args passed to printMeta()");
	  out.println("<tr>");
	  if (type.equals("table")) 
	  {
		  out.println("<td><strong>Table name</strong></td>");
		  for (int i = 1; i <= colCount; ++i) 
		  {
			  out.println("<td>" + metaData.getTableName(i) + "</td>");
		  }
	  } 
	  else if (type.equals("name")) 
	  {
		  out.println("<td><strong>Column name</strong></td>");
		  for (int i = 1; i <= colCount; ++i) 
		  {
			  out.println("<td>" + metaData.getColumnName(i) + "</td>");
		  }
	  } 
	  else if (type.equals("index")) 
	  {
		  out.println("<td><strong>Column index</strong></td>");
		  for (int i = 1; i <= colCount; ++i) 
		  {
			  out.println("<td>" + i + "</td>");
		  }
	  } 
	  else if (type.equals("column type")) 
	  {
		  out.println("<td><strong>Column type</strong></td>");
		  for (int i = 1; i <= colCount; ++i) 
		  {
			  out.println("<td>" + metaData.getColumnTypeName(i) + "</td>");
		  }

	  } 
	  else if (type.equals("column display")) 
	  {
		  out.println("<td><strong>Column display size</strong></td>");
		  for (int i = 1; i <= colCount; ++i) 
		  {
			  out.println("<td>" + metaData.getColumnDisplaySize(i)+ "</td>");
		  }
	  }
	  out.println("</tr>");
  	}//printMeta

}
