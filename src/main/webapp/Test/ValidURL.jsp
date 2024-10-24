<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import ="org.apache.commons.validator.UrlValidator" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Untitled Document</title>
</head>

<body>

<%

		UrlValidator urlValidator = new UrlValidator();
 
	    //valid URL
	    if (urlValidator.isValid("http://www.mythra.com"))  
	       out.println("url is valid");
	     else  
	       out.println("url is invalid");
	    
 
	     

%>
</body>
</html>
