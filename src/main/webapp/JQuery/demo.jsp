<%@ page language="java" import="java.sql.*" errorPage="" %>
<h2>Showing Messages Stored in database</h2> 
<%
String cont=request.getParameter("content");
try{
Class.forName("com.mysql.jdbc.Driver");
Connection con =DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "mythra");
Statement st = con.createStatement();
int i=st.executeUpdate("insert into messages(msg)values('"+request.getParameter("content")+"')"); 
ResultSet rs=st.executeQuery("select * from messages");
if(rs.next())
{
while(rs.next())
{
String message=rs.getString("msg");
%>

<li>
<div align="left">
<span >
<%
 out.println(message);	
%> </span>
</div>
</li>
<%
}
}
else{
out.println("No Records Found");}
}
catch(Exception e){
Exception ex = e;
out.println("Mysql Database Connection Not Found");
}
%>