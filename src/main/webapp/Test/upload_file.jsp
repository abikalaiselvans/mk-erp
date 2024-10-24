 <%@page import="zhornyak.survey"%> 
  <%@ page import="java.util.*" %> 
  <%@ page import="java.util.List" %> 
  <%@ page import="java.util.Iterator" %> 
  <%@ page import="java.io.*" %> 
  <%@ page import="java.io.File" %> 
  <%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%> 
  <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%> 
  <%@ page import="org.apache.commons.fileupload.*"%> 
  <%@ page contentType="text/html;charset=UTF-8" language="java"%> 
   
  <center> 
   
  <form action="" method="post" enctype="multipart/form-data" name="form1" id="form1">
            <% 
             
try
{
			  String pic1="", pic2="", pic3=""; 
              boolean isMultipart = ServletFileUpload.isMultipartContent(request); 
              if (!isMultipart)  
			  { 
              } 
			  else 
			  { 
              	FileItemFactory factory = new DiskFileItemFactory(); 
              	ServletFileUpload upload = new ServletFileUpload(factory) ;
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
              	int j=0 ; 
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
              				String path =(String) new File(config.getServletContext().getRealPath("/")).getParent() ; 
              				path = (String)path.replace(File.separatorChar, '/'); 
            
            				//Local 
              				// File savedFile = new File(path +"/project/zhornyak/uploadedFiles/"+itemName); 
   
             				 //Server  
              				File savedFile = new File(path +"/uploadedFiles/"+itemName) ; 
              				item.write(savedFile) ;  
   
              				j=j+1; 
							if (j==1) pic1=itemName ; 
							if (j==2) pic2=itemName ; 
							if (j==3) pic3=itemName ; 
				   
						  }  
						  catch (Exception e)  
						  { 
						  e.printStackTrace(); 
						  out.println( e.getMessage().toString()); 
			   
						  } 
              		} 
             	 } 
              } 
				  survey zhornyak = new survey(); 
				  int id= zhornyak.readMaxIDbiblio(); 
				  if (zhornyak.updateBiblio(pic1,pic2,pic3, id) )  
				  { 
   
              %> 
  <table border="2"> 
  <tr> 
  <td width="579" align="center"><h1> Your files uploaded Successfully</h1></td> 
  </tr> 
  </table> 
  <%  
              } 
              else 
              { 
              %> 
  <table border="2"> 
  <tr> 
  <td width="579" align="center"><h1> Your files not Uploaded</h1></td> 
  </tr> 
  </table> 
  <%  
              } 
}
catch(Exception e)
{
	System.out.println(e.getMessage());
}
              %> 
   
  </form> 
  </center>