<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.File" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
 <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*,java.util.*,java.io.*"%>
 <% 
try
{
		
 String filename="",allowance="",month="",year="";
 boolean flag = false;
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
	      		String iname = item.getFieldName();
				String value = item.getString();
		   
 				if(iname.equals("allowance"))
				{
					allowance=value;
					flag=true;
				}
				
				if(iname.equals("month"))
				{
					month=value;
					flag=true;
				}
				
				if(iname.equals("year"))
				{
					year=value;
					flag=true;
				}
				
   			} 
			else
	   		{
    			try 
				{
	
  					String itemName = item.getName(); 
   					File savedFile = new File(config.getServletContext().getRealPath("/")+"UploadExcelFile/"+allowance+"_"+month+"_"+year+".xls");
					item.write(savedFile);
     				
					  
   				} 
				catch (Exception e) 
				{
   					e.printStackTrace();
					System.out.println(e.getMessage());
   				}
   			}
   		}
   }
   
 response.sendRedirect("../SmartLoginAuth?filename=UploadUpdate&actionS=PAYUploadUpdateAllowance&allowance="+allowance+"&month="+month+"&year="+year);
} 
				catch (Exception e) 
				{
   					e.printStackTrace();
					System.out.println(e.getMessage());
   				}	 
    
   %>
 