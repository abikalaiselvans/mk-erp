 <%@ page import="java.util.List" %>
   <%@ page import="java.util.Iterator" %>
      <%@ page import="java.util.*" %>
	     <%@ page import="java.io" %>
   <%@ page import="java.io.File" %>
   <%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
   <%@ page import="org.apache.commons.fileupload.*"%>
   <%@ page contentType="text/html;charset=UTF-8" language="java" %>
  
   <%
   
   
   
   
   try
	  {
	  	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		out.println("<br>"+isMultipart); 
	   	if (!isMultipart) 
	  	{
	   	} 
	  	else 
	  	{	   
	  	         out.println("<br>"+isMultipart); 
	             FileItemFactory factory = new DiskFileItemFactory();
				 /*out.println("<br>"+factory);
	             ServletFileUpload upload = new ServletFileUpload(factory);
				 out.println("<br>"+upload);
				 out.println("<br>"+upload.parseRequest(request));
	             List items = null;
				 
				 try 
				 {
                   items = upload.parseRequest(request);
           		 } 
				 catch (FileUploadException e) 
				 {
                   out.println("<br>"+e.getMessage());
           		 }
				catch (Exception e) 
				 {
                   out.println("<br>"+e.getMessage());
           		 }

	              items = upload.parseRequest(request);
				 out.println("<br>"+items);
	             
	             out.println("<br>"+items.size());
	  		    
	  		    Iterator itr = items.iterator();
	             while (itr.hasNext()) 
	  		     {
	             		FileItem item = (FileItem) itr.next();
	             		if (item.isFormField()) 
	  				    {
	             		} 
		  				else 
		  				{
		                       try 
		  				     	{
		                             String itemName = item.getName();
		                             java.io.File savedFile = new java.io.File(config.getServletContext().getRealPath("/")+"Test/"+itemName);
		                             item.write(savedFile);  
		                             out.println(" Your file has been saved at the loaction: "+config.getServletContext().getRealPath("/")+"Test"+"/"+itemName+" ");
		  				     	} 
			  				     catch (Exception e) 
			  				    {
			                              
			                      }
		             	}
	  		     }*/
	     }
	  }
	  catch (Exception e) 
	 {
		  out.println("<br>"+e.getMessage());    
	 }
   
   
   
   %>