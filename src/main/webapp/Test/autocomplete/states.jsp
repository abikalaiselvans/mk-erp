<%@ page language="java" import="java.sql.*" %>
<% response.setContentType("text/html");%>
<%
String str=request.getParameter("queryString");
try 
{
	String connectionURL = "jdbc:mysql://localhost:3306/smartcampus";
	Connection con;
	Class.forName("com.mysql.jdbc.Driver");
	
	// Get a Connection to the database
	con = DriverManager.getConnection(connectionURL, "root", "mythra"); 
	
	
	//Add the data into the database
	String sql = "SELECT CHR_STATENAME FROM com_m_state WHERE CHR_STATENAME LIKE '"+str+"%' LIMIT 10";
	
	Statement stm = con.createStatement();
	stm.executeQuery(sql);
	ResultSet rs= stm.getResultSet();
	while (rs.next ())
	{
		out.println("<li onclick=\"fill('"+rs.getString("CHR_STATENAME")+"')\">"+rs.getString("CHR_STATENAME")+"</li>");
	}
}
catch(Exception e)
{
	out.println("Exception is ;"+e);
}
%>
 