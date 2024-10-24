 
<%@ page import="javax.imageio.ImageIO"%>
<%@ page import="java.awt.image.BufferedImage"%>
<%@ page import="java.io.File"%>
<%@ page import="org.apache.tomcat.util.http.fileupload.FileItem"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="org.apache.tomcat.util.http.fileupload.FileUploadException"%>
<%@ page import="java.util.List"%>
<%@ page import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.tomcat.util.http.fileupload.FileItemFactory"%>
<%@ page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Image Uploading</h1>
        
        
        
        
        
                                            
                                            
                                            <%
               
                                             //to stroe the image name
                                             String itemName="";
                             
            // This is where we uploading the Image-----------------------------------------------------------KNS
                                            
            //checking whether we recieved the file from the index.jsp
            boolean isMultipart = ServletFileUpload.isMultipartContent(request);
            
            
            if (!isMultipart) {
                System.out.println("------no path recieved-------");

            } else {
                //creating new file FileItemFactory to the ServletFileUpload
                FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                List items = null;


                try {
                    //storing files to the lists
                    items = upload.parseRequest(request);
                }
                catch (FileUploadException e) {
                    e.printStackTrace();
                }


                Iterator itr = items.iterator();
                
                while (itr.hasNext()) {
                    //storing the file into a FILEITEM
                    FileItem item = (FileItem) itr.next();
                    
                    if (item.isFormField()) {
                    }
                    
                    else {

                        try {
                            //filename
                            itemName = item.getName();
                            
                            
                            //getting the absolute path
                            String path = getServletContext().getRealPath("/");

                            
                            //assigning the path to the image folder
                            int newLetCount = path.length()-10;
                            String newPath=  path.substring(0, newLetCount);
                            String newPathLAST = newPath+"web/pic/uploaded/";
                            
                            
                            
                            //assingng full path to the file
                            File savedFile = new File(newPathLAST + itemName);

                            
                            System.out.println("path to web------------------------------------=" + newPathLAST + itemName);

                            
                            //saving the file to the hard disk(web folder)
                            item.write(savedFile);
                            
                            
                            
                            
                            
                            
                            //writing files to the build folder
                            String pathBuild=getServletContext().getRealPath("/pic/uploaded/");
                            
                            
                            File savedFileBuild = new File(pathBuild+itemName);
                            item.write(savedFileBuild);
                            System.out.println("path to built------------------="+pathBuild+itemName );
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            

                        } catch (Exception e) {
                            e.printStackTrace();
                            System.out.println(e);
                        }
                    }
                }
            }
        %>
        
        
        
              <!-- going to the cropping page -->
                <div align="center">
                    <form id="formImageUploading" method="post" name="formImageUploading" action="ImageCropping.jsp?itemName=<%=itemName%>" >

                        <table>
                            <tr>
                                <td>
                                    <p > You have successfully Uploaded the Picture. Uploaded Picture is saved on 'uploaded' folder.</p>
                                    <p > Click 'NEXT' button to Crop the Image. </p>
                                </td>
                            </tr>
                            <tr>
                                <td height="20">

                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <!-- this is to pass the image file name to the next page -->
                                    <input type="text" name="itemName" id="itemName" value="<%=itemName%> " style='visibility: hidden' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div align="center" >
                                    <input type="submit" class="button" name="PicUpdating1btn" id="PicUpdating1btn" value="NEXT" />
                                    </div>
                                </td>
                            </tr>
                        </table>
                        </form>
                </div>

        
        
        
    </body>
</html>
