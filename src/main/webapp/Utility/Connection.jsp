<%@ page import="java.sql.*,java.lang.*,java.io.*,java.util.*"%>
<%@include file="Redirect.jsp" %>
<%
       Connection con=null;
       ResultSet rs=null;
       Statement st=null; 
       try
       {
          String profilename="c:/Tomcat 5.0/bin/JDBC.properties";
	  InputStream input  = new FileInputStream(profilename);	
	  Properties jdbc = new Properties();
	  jdbc.load(input);
	  String driver = jdbc.getProperty("Driver");
	  String url =jdbc.getProperty("UrlCol");
	  String struser =jdbc.getProperty("User");
	  String Passw =jdbc.getProperty("Passw");
	
	  //Database Connectivity
	  Class.forName(driver);
	  con = DriverManager.getConnection(url,struser,Passw);
          st=con.createStatement(); 
	  //System.out.println(con);

      } 
      catch(Exception e)
      {}
         
%>
