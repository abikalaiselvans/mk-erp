
 <%@ page import="java.util.List" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.io.File" %>
   <%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
   <%@ page import="org.apache.commons.fileupload.*"%>
   <%@ page contentType="text/html;charset=UTF-8" language="java" %>
  

<title> ::UPLOAD /  DOWNLOAD</title>


   <%!
     String category="";	 
	 
	  
 %>
 <%
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
   		e.printStackTrace();
   }	
   Iterator itr = items.iterator();
   while (itr.hasNext()) 
	   {
   			FileItem item = (FileItem) itr.next();
   			if (item.isFormField())
	   		{
	      		String name = item.getFieldName();
			  	String value = item.getString();
		   
		  		if(name.equals("category"))
	           	 	category=value;
            		 
			    
   			} 
			else
	   		{
    			try 
				{
	
  					String itemName = item.getName(); 
					File file = new File(itemName);  
    				String fileName= file.getName();
   					File savedFile = new File(config.getServletContext().getRealPath("/")+"Smart UploadDownload\\Upload\\"+category+"\\"+fileName );
   					item.write(savedFile);
     %> 
	 
    <%				 
					  
   				} 
				catch (Exception e) 
				{
   					e.printStackTrace();
   				}
   			}
   		}
   }
   
    
   %>
      
	<SCRIPT language="javascript">
 						alert("You have successfully uploaded  ");
						location = "uploadMain.jsp" ;
						
					</SCRIPT>

 