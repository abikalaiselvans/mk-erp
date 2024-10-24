<%@ page language="java" import="java.sql.*,java.util.*,java.io.*,java.text.*" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>JDBC CALLABLE CHECKING</title>
</head>

<body>
<%
String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
String DB_URL = "jdbc:mysql://localhost:3306/smartcampus";

//  Database credentials
String USER = "root";
String PASS = "mythra";

Connection conn = null;
Statement stmt = null;
try
{
      //STEP 2: Register JDBC driver
      Class.forName("com.mysql.jdbc.Driver");
	  out.println("<br>Register JDBC driver");

      //STEP 3: Open a connection
      conn = DriverManager.getConnection(DB_URL,USER,PASS);
	  out.println("<br>Open a connection");
      
	  
	  CallableStatement acs = conn.prepareCall("{call  COM_PRO_COUNTRY(?,?,?,?,?)}");
	  out.println("<br>Open a CallableStatement");
	  acs.setString(1, "INSERT");
	  acs.setString(2, "0");
	  acs.setString(3, ""+Math.random());
	  acs.setString(4, "");
	  acs.setString(5, "ADMIN");
	  out.println(  "<br>"+acs);
	  acs.execute();
	  acs.close();
			
			
			
      //STEP 4: Execute a query
      stmt = conn.createStatement();
	  out.println("<br>Creating statement...");
      
      String sql;
      sql = "SELECT CHR_COUNTRYNAME, CHR_COUNTRYDESC FROM com_m_country   ORDER BY CHR_COUNTRYNAME";
      ResultSet rs = stmt.executeQuery(sql);
	  out.println("<br>Creating Resultset...");

      //STEP 5: Extract data from result set
	  out.println("<center>");
	  out.println("<table width='60%'  class='boldEleven'  id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
	  out.println("<tr bgcolor='#ffffff'>");
	  out.println("<td align='center'><b>S.No</b></td>");
	  out.println("<td align='center'><b>NAME</b></td>");
	  out.println("<td align='center'><b>DESCRIPTION </b></td>");
	 out.println("</tr>");
	  int i=1;
      while(rs.next())
	  {
        
         //Display values
		 out.println("<tr bgcolor='#ffffff'>");
	  	 out.println("<td align='left'>"+i+"</td>");
	     out.println("<td align='left'>"+rs.getString("CHR_COUNTRYNAME")+"</td>");
	     out.println("<td align='left'>"+rs.getString("CHR_COUNTRYDESC")+"</td>");
	     out.println("</tr>");
	   	 i = i+1;
      }
	  out.println("</center>");
	  out.println("</table>");
	  
      //STEP 6: Clean-up environment
      rs.close();
      stmt.close();
      conn.close();
   }
   catch(SQLException se)
   {
       out.println(se.getMessage());
	   
   }catch(Exception e)
   {
      //Handle errors for Class.forName
     out.println(e.getMessage());
   }
   finally
   {
      //finally block used to close resources
      try
	  {
         if(stmt!=null)
            stmt.close();
      }
	  catch(SQLException se2)
	  {
		  
      }// nothing we can do
      try
	  {
         if(conn!=null)
            conn.close();
      }
	  catch(SQLException se)
	  {
         se.printStackTrace();
      }//end finally try
   }//end try
%>
</body>
</html>