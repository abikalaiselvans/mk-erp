<%@ page language="java" import="java.sql.*" errorPage="" %>
<html>
<head>
  <title>GET VALUE FROM TABLE</title>
  <script src="jquery-1.4.2.js" type="text/javascript"></script>
  <script src="insert.js" type="text/javascript"></script>
</head>
<body  onpaste='return false;'>
<form id="form" method="post">
<h3>Send message to Administrator(Plz Type below)</h3>
<textarea cols="30" rows="2" type="text" id="content" maxlength="145" >
</textarea><br />
<input id="submit" type="submit" value="Send Message"/>
<input id="reset" type="reset" value="Reset"/>
</form>
<p id="result"></p>
<body  onpaste='return false;'>
</html>