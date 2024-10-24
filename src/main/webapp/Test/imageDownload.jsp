 <%@ page import="java.sql.*,java.io.*,java.util.*" %> 

<HTML>

 <HEAD>

  <TITLE>Download Images</TITLE>

  </HEAD>



 <BODY>

 <br><br>

  <table align="center" border=0 width="200px">

 <tr>

  <td colspan=2 align="center"><b>Download Images</b></td>

  </tr>

  <tr><td colspan=2> </td></tr>

  <%



  String connectionURL = "jdbc:mysql://localhost:3306/smartcampus";

  Connection con=null;

  try{  

  Class.forName("com.mysql.jdbc.Driver").newInstance();

  con=DriverManager.getConnection(connectionURL,"root","mythra");

  Statement stmt=con.createStatement();

  String strQuery = "select CHR_EMPID from com_m_staff where CHR_EMPID='ADMIN'";
	 
  ResultSet rs = stmt.executeQuery(strQuery);

  int sno=0;
  String ep="";
  while(rs.next())

  {

  sno++;
  ep=rs.getString(1);

  %>

  <tr style="background-color:#efefef;">

  <td><b><%=sno%></b></td>

  <td align="center">

<a href="image.jsp?imgid=<%=ep%>">

<img src="image.jsp?imgid=<%=ep%>" width="50" height="50" border="0"></a></td>

  </tr>

  <%

  }

  rs.close();

 

  stmt.close();

  }

  catch(Exception e)

  {

  e.getMessage();

  }

  %>

 </table>

  </BODY>

</HTML>