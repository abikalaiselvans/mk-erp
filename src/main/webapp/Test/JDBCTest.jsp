<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Untitled Document</title>
</head>

<body  onpaste='return false;'>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<script language="javascript">
function CallPage(URLStr ) 
{ 
	location = URLStr; 
}	 
	
</script>

<form name="form1" method="post" action="">


<%

		try
		{
			
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/smartcampus", "root", "mythra");
			//out.println(con+"<br>");
			if(con == null)
				out.println("Connection null");
			else
			{
				Statement st = con.createStatement();
				//out.println(st+"<br>");
				 ResultSet rs = st.executeQuery(" SELECT id,CHR_NAME,FLAG FROM test ORDER BY  CHR_NAME ");
				//out.println(rs+"<br>");
				out.println("<center><table border='1' width='200'>");
				out.println("<tr><td>S.No</td><td>Name</td><td>Mobile</td></tr>");
				int i=0;
				 while(rs.next())
				{
					out.println("<tr><td>"+(i+1)+"</td>");
					out.println(" <td>"+rs.getString(2) +"</td>");
					out.println(" <td>"+ rs.getString(3)+"</td>");
					 out.println("/<tr>");
					i=i+1;
				} 
				 out.println("</center></table>");
				st.close();
				out.println("<br>"+con+"<br>");
				con.close();
				
				
 
			}	
			out.println(""+con+"---"); 
			
		}
		catch(Exception e)
		{
			out.println(e.getMessage());
		}
%>


<table width="53%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>
      
        <input type="button" name="Button"  value="Add"   accesskey="s"   onClick="CallPage('JDBCADD.jsp')">
         
    </td>
    <td><input type="button" name="Submit2" value="Edit"  onClick="CallPage('JDBCTest.jsp')"></td>
     
    <td><input type="submit" name="Submit4"  value="Close"   accesskey="c"  onClick="javascript:window.close()"></td>
  </tr>
</table> </form>
</body>
</html>
