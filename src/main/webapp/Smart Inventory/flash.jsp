<html>
  <head>
    <meta charset=utf-8 />
    <title>ColorBox demo</title>
    <link rel="stylesheet" href="http://www.jacklmoore.com/colorbox/example1/colorbox.css" />
	 <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script src="http://www.jacklmoore.com/colorbox/jquery.colorbox.js"></script>
    <script>
      function openColorBox()
	  {
     	alert("");
	    $.colorbox({iframe:true, width:"25%", height:"25%"});
        
     }
      
      setTimeout(openColorBox, 5000);
     
    </script>
	
  </head>
  <body onload="openColorBox()">
   
  </body>
</html>