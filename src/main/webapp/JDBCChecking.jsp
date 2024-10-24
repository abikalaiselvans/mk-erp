<%@ page language="java" import="java.sql.*,java.util.*,java.io.*,java.text.*" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>JDBC CHECKING</title>
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

      //STEP 3: Open a connection
      System.out.println("Connecting to database...");
      conn = DriverManager.getConnection(DB_URL,USER,PASS);

      //STEP 4: Execute a query
      System.out.println("Creating statement...");
      stmt = conn.createStatement();
      String sql;
      sql = "SELECT CHR_EMPID, CHR_USRNAME, CHR_TYPE, CHR_THEME FROM m_user   ORDER BY CHR_USRNAME";
      ResultSet rs = stmt.executeQuery(sql);

      //STEP 5: Extract data from result set
	  out.println("<center>");
	  out.println("<table width='60%'  class='boldEleven'  id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
	  out.println("<tr bgcolor='#ffffff'>");
	  out.println("<td align='center'><b>S.No</b></td>");
	  out.println("<td align='center'><b>EMPID</b></td>");
	  out.println("<td align='center'><b>USER NAME</b></td>");
	  out.println("<td align='center'><b>TYPE</b></td>");
	  out.println("<td align='center'><b>THEME</b></td>");
	  out.println("</tr>");
	  int i=1;
      while(rs.next())
	  {
        
         //Display values
		 out.println("<tr bgcolor='#ffffff'>");
	  	 out.println("<td align='center'>"+i+"</td>");
	     out.println("<td align='center'>"+rs.getString("CHR_EMPID")+"</td>");
	     out.println("<td align='center'>"+rs.getString("CHR_USRNAME")+"</td>");
	     out.println("<td align='center'>"+rs.getString("CHR_TYPE")+"</td>");
	     out.println("<td align='center'>"+rs.getString("CHR_THEME")+"</td>");
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
      System.out.println(se.getMessage());
	  //Handle errors for JDBC
      se.printStackTrace();
   }catch(Exception e)
   {
      //Handle errors for Class.forName
      e.printStackTrace();
	  System.out.println(e.getMessage());
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