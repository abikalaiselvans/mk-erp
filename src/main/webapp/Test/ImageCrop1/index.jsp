<%-- 
    Document   : index
    Created on : Oct 24, 2012, 10:59:10 AM
    Author     : Nalaka
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Simple Image Uploading / cropping - KNS </h1>
        <p> this is just a application of Jcrop, which is available in the Internet. </p>
        <div align="center">
            <form id="formImageupload" name="formImageupload" method="post" action="ImageUploading.jsp" enctype="multipart/form-data">
                <table width="293" border="0" id="tableImageupload">
                <tr>
                    <td width="304" height="34"><div align="center">
                   </div></td>
                </tr>
                <tr>
                    <td height="40">
                    <input type="file" name="PicUpdatefile" id="PicUpdatefile" /></td>
                </tr>

                <tr>
                    <td height="37"><div align="center">
                    <input type="submit"  name="PicUpdatebutton" id="PicUpdatebutton" value="UPLOAD" />

                    </div></td>
                </tr>
                </table>
            </form>
        </div>


        
        
    </body>
</html>
