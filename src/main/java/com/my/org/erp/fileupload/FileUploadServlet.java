package com.my.org.erp.fileupload;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import java.io.IOException;
import java.io.File;
import java.util.List;
import java.util.Iterator;
@WebServlet("/uploadservlets")
public class FileUploadServlet extends HttpServlet 
{
    private static final long serialVersionUID = -3208409086358916855L;
    String redirect="Home.jsp";
    String uploadpath="";
    @SuppressWarnings("deprecation")
	protected void doPost(HttpServletRequest request, HttpServletResponse response)  throws ServletException, IOException 
    { 
    	try 
    	{
			boolean isMultipart = ServletFileUpload.isMultipartContent(request);
			if (!isMultipart) 
			 {
			 } 
			 else 
			 {
			   FileItemFactory factory = new DiskFileItemFactory();
			   ServletFileUpload upload = new ServletFileUpload(factory);
			   List items = null;
			   try 
			   {
			   		items = upload.parseRequest(request);
			   } 
			   catch (FileUploadException e) 
			   {
			   		 System.out.println(e.getMessage());
			   }	
			   Iterator itr = items.iterator();
			   while (itr.hasNext()) 
				   {
			   			FileItem item = (FileItem) itr.next();
			   			if (item.isFormField())
				   		{
				      		String name = item.getFieldName();
						  	String value = item.getString();
					   
						  	if(name.equals("redirect"))
						  		redirect=value;
						  	if(name.equals("uploadpath"))
						  		uploadpath=value;
			           } 
						else
				   		{
			    			try 
							{
								String itemName = item.getName(); 
								File file = new File(itemName);  
								String fileName= file.getName();
								File savedFile = new File(request.getRealPath("/") +uploadpath+fileName );
			   					item.write(savedFile);
			      	 		} 
							catch (Exception e) 
							{
			   					 System.out.println(e.getMessage());
			   				}
			   			}
			   		}
			   }
			 response.sendRedirect(""+redirect);
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
