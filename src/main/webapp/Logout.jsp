 <script type = "text/javascript" >
       function preventBack(){window.history.forward();
       var URL;
       var i ;
       var QryStrValue;
       URL=window.location.href ;
       i=URL.indexOf("?");
       QryStrValue=URL.substring(i+1);
       if (QryStrValue!='X')
       {
    	 
           window.location.href="login.jsp";
       }

       }
        setTimeout("preventBack()", 10);
        window.onunload=function(){null};
    </script>
	
<body>	
<% 
String userid = ""+session.getAttribute("USRID");
response.sendRedirect("SmartLoginAuth?filename=Login&actionS=COM_Logout&id="+userid); 
%>
</body>
