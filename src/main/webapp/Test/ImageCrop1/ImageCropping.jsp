<%-- 
    Document   : ImageUploaded
    Created on : Oct 24, 2012, 11:03:57 AM
    Author     : Nalaka
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
        
        
        <!-- css and js for image cropping............................. KNS -->
        
        <script src="js/jquery-1.4.2.js"></script>
        <script src="js/jquery.Jcrop.js"></script>
        <link rel="stylesheet" href="css/jquery.Jcrop.css" type="text/css" />
        <link rel="stylesheet" href="css/knscropLOOK.css" type="text/css" />

        <script language="Javascript">

                $(function(){
                    
                    //creating the jcropboxIMAGETAG and setting the ration as 1 to 1
                    $('#cropbox').Jcrop({
                    aspectRatio: 1,
                    onSelect: updateCoords
                    });

                });
                
                //getting the cordinats of the box
                function updateCoords(c){
                    $('#x').val(c.x);
                    $('#y').val(c.y);
                    $('#w').val(c.w);
                    $('#h').val(c.h);
                };
                
                //checking whether there is a jcrop box
                function checkCoords(){
                    if (parseInt($('#w').val())) return true;
                    alert('Please select a crop region then press CROP Image Button.');
                    return false;
                };

        </script>
        
        
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Image Cropping </h1>
        <p> To change the aspect ratio, change the aspect ratio in line 27 of the ImageCropping.jsp </p>
        
        
        
        
                                    
                                                                                
     <!-- IMAGE CROPPING.......................................KNS -->
                                            
                                            
            <!-- div tags for css purposes -->
            <div id="outer">
                <div class="jcExample">
                    <div class="article">

                        
                        <!-- Starting to Getting the image to Crop -->
                        <%
                            //getting the image name from the url
                            String itemName = request.getParameter("itemName");
                        %>
                        
                        
                        
                        <img src="pic/uploaded/<%=itemName%>" id="cropbox" />

                        <!-- This is the form that our event handler fills -->
                        <form action="ImageCrop" method="get" onsubmit="return checkCoords();">

                        <input type="hidden" id="x" name="l" />
                        <input type="hidden" id="y" name="t" />
                        <input type="hidden" id="w" name="w" />
                        <input type="hidden" id="h" name="h" />
                        <input type="hidden" size="4" id="f" name="f" value="jpg" />
                        <input type="hidden" size="4" id="i" name="i" value="pic/uploaded/<%=itemName%>"/>
                        <input type="submit" class="button" value="Crop Image" />
                        
                        <input type="hidden" id="itemName" name="itemName" value="<%=itemName%>" />
                        </form>
                    </div>
                </div>
            </div>
        
        
        
    </body>
</html>
