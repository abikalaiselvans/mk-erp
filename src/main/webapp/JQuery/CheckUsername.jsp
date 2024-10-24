<%@ page language="java" import="java.sql.*" %>
<% response.setContentType("text/html");%>
<%
try {
String str=request.getParameter("user");
String connectionURL = "jdbc:mysql://localhost:3306/test";
Connection con;
Class.forName("com.mysql.jdbc.Driver");
// Get a Connection to the database
con = DriverManager.getConnection(connectionURL, "root", "mythra");
//Add the data into the database
String sql = "SELECT username FROM checkuser WHERE username='"+str+"'";
Statement stm = con.createStatement();
stm.executeQuery(sql);
ResultSet rs= stm.getResultSet();
int count = 0;
while (rs.next ()){
count++;
}
if(count==0)
{
out.println("UserName is Available");
}
else
	{
	out.println("Username is not available");
	}
}catch(Exception e){
out.println("Exception is ;"+e);
}
%>