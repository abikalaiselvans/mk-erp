<%@ page import="java.sql.*,java.lang.*,java.io.*,java.util.*"%>
<%
       Connection con1=null;
       ResultSet rs1=null;
       Statement st1=null; 
       try
       {
      String profilename1="c:/Tomcat 5.0/bin/JDBC.properties";
	  InputStream input1  =  new FileInputStream(profilename1);	
	  Properties jdbc = new Properties();
	  jdbc.load(input1);
	  String driver1 = jdbc.getProperty("Driver");
	  String url1 =jdbc.getProperty("UrlCol");
	  String struser1 =jdbc.getProperty("User");
	  String Passw1 =jdbc.getProperty("Passw");
	
	  //Database Connectivity
	  //Class.forName(driver);
	  con1 = DriverManager.getConnection(url1,struser1,Passw1);
      //st1=con.createStatement(); 

      } 
      catch(Exception e)
      {}
         
%>
