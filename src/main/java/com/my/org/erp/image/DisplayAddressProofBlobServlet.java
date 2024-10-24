package com.my.org.erp.image;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.Connection;
 
import java.sql.ResultSet;
 
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DBConnection.DBCon;
@WebServlet("/AddressProofImages")
public class DisplayAddressProofBlobServlet extends HttpServlet 
{
  /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException,  ServletException 
  {
	  try 
	    {
		  String adressproof= request.getParameter("adressproof");
		  String staffid= request.getParameter("staffid");
		  DBCon con = new DBCon();
		  Connection conn = con.getConnection();
		  Blob photo = null;
		  Statement stmt = null;
		  ResultSet rs = null;
		  String query =null;
		   
		  if(!com.my.org.erp.common.CommonFunction.RecordExist( "select "+adressproof+"  is null  from com_m_staffaddressproof  where  CHR_EMPID = '"+staffid+"'"))
		  {
			  query = "select "+adressproof+" from com_m_staffaddressproof  where  CHR_EMPID = '"+staffid+"'";
			  ServletOutputStream out = response.getOutputStream();
			  
			  stmt = conn.createStatement();
			  rs = stmt.executeQuery(query);
			  if (rs.next()) 
				 photo = rs.getBlob(1);
	        	 
	          
		      response.setContentType("image/gif");
		      InputStream in = photo.getBinaryStream();
		      int length = (int) photo.length();
		
		      int bufferSize = 1024;
		      byte[] buffer = new byte[bufferSize];
		
		      while ((length = in.read(buffer)) != -1) 
		      {
		        out.write(buffer, 0, length);
		      }
		
		      in.close();
		      out.flush();
		      rs.close();
		      stmt.close();
		      conn.close();
		 }
		  else
		  {
			  	
			   	query = "SELECT a.CHR_EMPID,a.CHR_STAFFNAME,c.CHR_PROOFNAME    FROM 	com_m_staff a ,com_m_staffaddressproof b,com_m_addressproof c WHERE a.CHR_EMPID=b.CHR_EMPID  AND a.CHR_EMPID = '"+staffid+"' AND c.CHR_PROOFCODE='"+adressproof+"' ";
			   	String Data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(query);
			    response.setContentType("text/html");
		        PrintWriter out = response.getWriter();
		        out.println("<html>");
		        out.println("<head>");
		        out.println("</head>");
		        out.println("<body  onpaste='return false;'>");
		        out.println(" <br><br><br> ");
		        out.println(" <br><br><br> ");
		        out.println("<br><br><br><center><h3><font color='red'>"+Data[0][2]+" Image Not Found for "+staffid+" / "+Data[0][1]+"</font></h3>");
		        
		        out.println(" <br><br><br> ");
		        out.println(" <a href='javascript:window.history.back()'>Back</a> &nbsp;&nbsp;&nbsp;&nbsp; <a href='javascript:window.close()'>Close</a> ");
		        out.println(" <br><br><br> ");
		        out.println("</center> ");
		        out.println("</body>");
		        out.println("</html>");

		  }
	      
    } 
	
	  catch (Exception e) 
	  {
		  response.sendRedirect("error/index.jsp?error=Image Not Found..."+e.getMessage());				
			 System.out.println(e.getMessage());
	  } 
	
  }
}
