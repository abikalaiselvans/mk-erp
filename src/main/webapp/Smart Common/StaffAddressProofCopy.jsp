    <%@ page import="java.util.List" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.io.File" %>
   <%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
   <%@ page import="org.apache.commons.fileupload.*"%>
   <%@ page contentType="text/html;charset=UTF-8" language="java" %>
  
         
   <%!
     String staffid="";	 
	 String adressproof="";	
	 int count1=0,count2=0 ;
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
		   
		  		if(name.equals("staffid"))
	           	{
			   		staffid=value;
            		 count2=1;
			   	}
				if(name.equals("adressproof"))
	           	{
			   		adressproof=value;
            		 count1=1;
			   	}
   			} 
			else
	   		{
    			try 
				{
	
  					String itemName = item.getName(); 
   					File savedFile = new File(config.getServletContext().getRealPath("/")+"/uploadfiles/Addressproof\\"+staffid+"_"+adressproof+".jpg");
   					item.write(savedFile);
					 
					com.my.org.erp.common.ImageFunctions.insertAddressProof(request.getRealPath("/"), staffid,adressproof);
 
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
						window.close();
						
					</SCRIPT>